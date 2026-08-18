#!/usr/bin/env bash

set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd "${script_dir}/.." && pwd)"

output_dir="${PDF_OUTPUT_DIR:-${repo_root}/build/pdf-preflight}"
version_label="${PDF_VERSION_LABEL:-v1.0-candidate}"
chrome_bin="${CHROME_BIN:-/Applications/Google Chrome.app/Contents/MacOS/Google Chrome}"
node_bin="${NODE_BIN:-$(command -v node || true)}"
npm_bin="${NPM_BIN:-$(command -v npm || true)}"

if [[ -z "${node_bin}" || ! -x "${node_bin}" ]]; then
  echo "error: Node.js 18 or later is required" >&2
  exit 1
fi

if [[ -z "${npm_bin}" || ! -x "${npm_bin}" ]]; then
  echo "error: npm is required" >&2
  exit 1
fi

if [[ ! -x "${chrome_bin}" ]]; then
  echo "error: Chrome executable not found: ${chrome_bin}" >&2
  echo "Set CHROME_BIN to a Chromium-compatible browser executable." >&2
  exit 1
fi

mkdir -p "${output_dir}/html"

cd "${repo_root}"
"${npm_bin}" ci --ignore-scripts --no-audit --no-fund

active_profile=""
active_chrome_pid=""
cleanup_processes() {
  if [[ -n "${active_chrome_pid}" ]] && kill -0 "${active_chrome_pid}" 2>/dev/null; then
    kill -TERM "${active_chrome_pid}" 2>/dev/null || true
    wait "${active_chrome_pid}" 2>/dev/null || true
  fi
  if [[ -n "${active_profile}" && -d "${active_profile}" && "${active_profile}" == *"/sllef-pdf-chrome."* ]]; then
    rm -rf -- "${active_profile}"
  fi
}
trap cleanup_processes EXIT

file_size() {
  local file_path="$1"
  if stat -f '%z' "${file_path}" >/dev/null 2>&1; then
    stat -f '%z' "${file_path}"
  else
    stat -c '%s' "${file_path}"
  fi
}

render_with_chrome() {
  local html_path="$1"
  local pdf_path="$2"
  local output_stem="$3"
  local temporary_pdf="${pdf_path}.tmp.pdf"
  local chrome_log="${output_dir}/html/${output_stem}.chrome.log"
  local previous_size="-1"
  local stable_checks="0"
  local completed="0"

  rm -f -- "${temporary_pdf}"
  active_profile="$(mktemp -d "${TMPDIR:-/tmp}/sllef-pdf-chrome.XXXXXX")"

  "${chrome_bin}" \
    --headless=new \
    --disable-background-networking \
    --disable-component-update \
    --disable-crash-reporter \
    --disable-default-apps \
    --disable-extensions \
    --disable-sync \
    --metrics-recording-only \
    --no-first-run \
    --no-pdf-header-footer \
    --run-all-compositor-stages-before-draw \
    --user-data-dir="${active_profile}" \
    --virtual-time-budget=1000 \
    --print-to-pdf="${temporary_pdf}" \
    "file://${html_path}" \
    >"${chrome_log}" 2>&1 &
  active_chrome_pid="$!"

  for ((attempt = 0; attempt < 240; attempt++)); do
    if [[ -s "${temporary_pdf}" ]] && tail -c 2048 "${temporary_pdf}" | grep -a -q '%%EOF'; then
      current_size="$(file_size "${temporary_pdf}")"
      if [[ "${current_size}" == "${previous_size}" ]]; then
        stable_checks=$((stable_checks + 1))
      else
        stable_checks=0
        previous_size="${current_size}"
      fi

      if ((stable_checks >= 8)); then
        completed="1"
        break
      fi
    fi

    if ! kill -0 "${active_chrome_pid}" 2>/dev/null; then
      wait "${active_chrome_pid}" || true
      active_chrome_pid=""
      if [[ -s "${temporary_pdf}" ]] && tail -c 2048 "${temporary_pdf}" | grep -a -q '%%EOF'; then
        completed="1"
      fi
      break
    fi

    sleep 0.25
  done

  if [[ "${completed}" != "1" ]]; then
    echo "error: Chrome did not finish a valid PDF within 60 seconds" >&2
    sed -n '1,160p' "${chrome_log}" >&2
    return 1
  fi

  if [[ -n "${active_chrome_pid}" ]] && kill -0 "${active_chrome_pid}" 2>/dev/null; then
    kill -INT "${active_chrome_pid}" 2>/dev/null || true
    wait "${active_chrome_pid}" 2>/dev/null || true
  fi
  active_chrome_pid=""
  cleanup_processes
  active_profile=""

  mv -f -- "${temporary_pdf}" "${pdf_path}"
}

build_one() {
  local language="$1"
  local source_name="$2"
  local output_name="$3"
  local source_path="${repo_root}/${source_name}"
  local html_path="${output_dir}/html/${output_name%.pdf}.html"
  local pdf_path="${output_dir}/${output_name}"

  "${node_bin}" "${repo_root}/scripts/markdown_to_html.mjs" \
    "${source_path}" \
    "${repo_root}/styles/pdf.css" \
    "${html_path}" \
    "${language}"

  render_with_chrome "${html_path}" "${pdf_path}" "${output_name%.pdf}"

  if [[ ! -s "${pdf_path}" ]]; then
    echo "error: PDF was not created: ${pdf_path}" >&2
    exit 1
  fi

  echo "created ${pdf_path}"
}

build_one \
  "zh-CN" \
  "structured-llm-execution-framework-zh.md" \
  "structured-llm-execution-framework-zh-${version_label}.pdf"

build_one \
  "en" \
  "structured-llm-execution-framework-en.md" \
  "structured-llm-execution-framework-en-${version_label}.pdf"
