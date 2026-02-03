#!/usr/bin/env bash
set -euo pipefail

# Cache Fontshare fonts locally under `public/fonts/fontshare/` and generate `public/fonts/fonts.css`.
#
# Usage:
#   ./scripts/cache-fonts-fontshare.sh
#   ./scripts/cache-fonts-fontshare.sh satoshi 400,500
#
# Notes:
# - Requires: curl, node
# - This script fetches CSS from `api.fontshare.com` and font files from `cdn.fontshare.com`.

FONT_FAMILY="${1:-satoshi}"
WEIGHTS="${2:-400,500}"

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OUT_DIR="${ROOT_DIR}/public/fonts/fontshare/${FONT_FAMILY}"
CSS_TMP="${ROOT_DIR}/public/fonts/.fontshare.${FONT_FAMILY}.tmp.css"
CSS_OUT="${ROOT_DIR}/public/fonts/fonts.css"

mkdir -p "${OUT_DIR}"

CSS_URL="https://api.fontshare.com/v2/css?f[]=${FONT_FAMILY}@${WEIGHTS}&display=swap"
echo "[fonts] Fetch css: ${CSS_URL}"
curl -fsSL "${CSS_URL}" -o "${CSS_TMP}"

echo "[fonts] Download woff2 files…"
extract_urls() {
  if command -v rg >/dev/null 2>&1; then
    rg -o "https://cdn\\.fontshare\\.com[^)\"']+\\.woff2" "${CSS_TMP}"
    return
  fi
  # Fallback for systems without ripgrep
  grep -Eo "https://cdn\\.fontshare\\.com[^)\"']+\\.woff2" "${CSS_TMP}" || true
}

URLS="$(extract_urls | sort -u)"

if [[ -z "${URLS}" ]]; then
  echo "[fonts] No .woff2 URLs found in CSS. Aborting."
  exit 1
fi

while IFS= read -r url; do
  [[ -z "${url}" ]] && continue
  file="$(basename "${url}")"
  target="${OUT_DIR}/${file}"
  if [[ -f "${target}" ]]; then
    continue
  fi
  curl -fsSL "${url}" -o "${target}"
done <<< "${URLS}"

echo "[fonts] Rewrite css → ${CSS_OUT}"
node "${ROOT_DIR}/scripts/rewrite-fontshare-css.mjs" \
  "${CSS_TMP}" \
  "${CSS_OUT}" \
  "/fonts/fontshare/${FONT_FAMILY}" \
  "Satoshi"

rm -f "${CSS_TMP}"
echo "[fonts] Done."
