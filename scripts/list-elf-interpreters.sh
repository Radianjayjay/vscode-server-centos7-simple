#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <server-dir>" >&2
  exit 1
fi

if ! command -v patchelf >/dev/null 2>&1; then
  echo "patchelf is required but not found in PATH" >&2
  exit 1
fi

if command -v realpath >/dev/null 2>&1; then
  SERVER_DIR="$(realpath "$1")"
else
  SERVER_DIR="$(readlink -f "$1")"
fi

if [[ ! -d "$SERVER_DIR" ]]; then
  echo "Server dir not found: $SERVER_DIR" >&2
  exit 1
fi

find "$SERVER_DIR" -type f -print0 | while IFS= read -r -d '' f; do
  interp="$(patchelf --print-interpreter "$f" 2>/dev/null || true)"
  if [[ -n "$interp" ]]; then
    printf '%s\t%s\n' "$interp" "$f"
  fi
done
