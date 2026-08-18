#!/usr/bin/env node

import fs from "node:fs";
import path from "node:path";
import { pathToFileURL } from "node:url";
import MarkdownIt from "markdown-it";

const [sourcePath, cssPath, outputPath, language] = process.argv.slice(2);

if (!sourcePath || !cssPath || !outputPath || !language) {
  console.error(
    "Usage: markdown_to_html.mjs <source.md> <style.css> <output.html> <language>",
  );
  process.exit(2);
}

const markdown = fs.readFileSync(sourcePath, "utf8");
const css = fs.readFileSync(cssPath, "utf8");
const titleMatch = markdown.match(/^#\s+(.+)$/m);
const documentTitle = titleMatch?.[1] ?? path.basename(sourcePath);
const baseUrl = pathToFileURL(`${path.dirname(path.resolve(sourcePath))}${path.sep}`).href;

// Keep the canonical repository clickable without broadly treating dotted inline
// code such as `AGENTS.md` or `CLAUDE.md` as an Internet hostname.
const printableMarkdown = markdown.replace(
  /^(.*Canonical repository(?:：|:)\s*)(https:\/\/[^\s]+)(\s*)$/gmu,
  (_match, prefix, url, suffix) => `${prefix}[${url}](${url})${suffix}`,
);

const renderer = new MarkdownIt({
  html: false,
  linkify: false,
  typographer: false,
  breaks: false,
});

renderer.core.ruler.after("inline", "risk-label-pagination", (state) => {
  for (let index = 0; index < state.tokens.length - 2; index += 1) {
    const opening = state.tokens[index];
    const content = state.tokens[index + 1];
    const closing = state.tokens[index + 2];

    if (
      opening.type === "paragraph_open" &&
      content.type === "inline" &&
      closing.type === "paragraph_close" &&
      /^\*\*Risk \d+:/.test(content.content)
    ) {
      opening.attrJoin("class", "keep-with-next");
    }
  }
});

function escapeHtml(value) {
  return value
    .replaceAll("&", "&amp;")
    .replaceAll("<", "&lt;")
    .replaceAll(">", "&gt;")
    .replaceAll('"', "&quot;");
}

const body = renderer.render(printableMarkdown);
const html = `<!doctype html>
<html lang="${escapeHtml(language)}">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <base href="${escapeHtml(baseUrl)}">
  <title>${escapeHtml(documentTitle)}</title>
  <style>${css}</style>
</head>
<body>
  <main class="document">
${body}
  </main>
</body>
</html>
`;

fs.mkdirSync(path.dirname(outputPath), { recursive: true });
fs.writeFileSync(outputPath, html, "utf8");
