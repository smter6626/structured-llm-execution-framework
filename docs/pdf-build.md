# Bilingual PDF build pipeline

This repository uses a command-line Markdown → HTML/CSS → headless Chrome pipeline for bilingual PDF generation.

The current default outputs are **layout/preflight candidates**, not formal v1.0 release assets. They remain under the ignored `build/` directory and must not be attached to a formal release. After DOI reservation, Step 7 can reuse the same entry point against the updated canonical Markdown.

## Build

Prerequisites:

- Node.js 18 or later and npm;
- Google Chrome or a Chromium-compatible browser;
- macOS system fonts used by `styles/pdf.css`.

Install the locked npm dependency and build both language versions with one command:

```sh
scripts/build_pdfs.sh
```

The script runs `npm ci` from `package-lock.json`, converts both canonical Markdown files with [`markdown-it`](https://www.npmjs.com/package/markdown-it) 14.1.0, and prints A4 PDFs with headless Chrome.

Default outputs:

```text
build/pdf-preflight/structured-llm-execution-framework-zh-v1.0-candidate.pdf
build/pdf-preflight/structured-llm-execution-framework-en-v1.0-candidate.pdf
```

The generated HTML is retained below `build/pdf-preflight/html/` for local diagnostics. The entire `build/` directory and `node_modules/` are ignored by Git.

## Configuration

The same entry point supports later release-stage paths and names without changing the converter:

```sh
PDF_OUTPUT_DIR=build/pdf-final \
PDF_VERSION_LABEL=v1.0 \
scripts/build_pdfs.sh
```

Set `CHROME_BIN`, `NODE_BIN`, or `NPM_BIN` only when the corresponding executable is not available at the default location or on `PATH`.

## Fonts and verification

No font binary is stored in this repository. The print stylesheet requests macOS system fonts:

- Chinese body: Songti SC / STSong;
- English body: Georgia / Times New Roman;
- headings: macOS system sans-serif with PingFang SC fallback;
- code: SF Mono / Menlo / Monaco with PingFang SC fallback.

PDF verification is intentionally separate from generation. Render every candidate page with a mature PDF renderer (the Step 5 preflight uses Poppler at approximately 200 DPI), inspect all pages, extract text, inspect link annotations, and record PDF metadata before treating the layout as reviewed.
