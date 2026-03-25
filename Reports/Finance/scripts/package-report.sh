#!/bin/zsh

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
SOURCE_DIR="$ROOT_DIR/Financial Report"
EXPORT_DIR="$ROOT_DIR/Exports/Server Packages"
OUTPUT_ZIP="$EXPORT_DIR/Financial Report - ready.zip"

mkdir -p "$EXPORT_DIR"
rm -f "$OUTPUT_ZIP"
# Strip VertiPaq cache by default so packages open blank until Refresh.
# Set KEEP_MODEL_CACHE=1 only when intentionally shipping a cached package.
if [[ "${KEEP_MODEL_CACHE:-0}" != "1" ]]; then
  find "$SOURCE_DIR" -path '*/.pbi/cache.abf' -type f -delete 2>/dev/null || true
fi
ditto -c -k --sequesterRsrc --keepParent "$SOURCE_DIR" "$OUTPUT_ZIP"
ls -lh "$OUTPUT_ZIP"
