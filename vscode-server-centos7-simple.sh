#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PATCH_SCRIPT="$SCRIPT_DIR/scripts/patch-vscode-server.sh"

SERVER_DIR="${VSCODE_SERVER_DIR:-$HOME/.vscode-server}"
GNU_DIR="${VSCODE_GNU_DIR:-$HOME/.vscode-server/gnu}"

if [[ ! -x "$PATCH_SCRIPT" ]]; then
  chmod +x "$PATCH_SCRIPT" 2>/dev/null || true
fi

if [[ ! -d "$SERVER_DIR" ]]; then
  echo "Server dir not found: $SERVER_DIR" >&2
  exit 1
fi

if [[ ! -d "$GNU_DIR" ]]; then
  echo "GNU dir not found: $GNU_DIR" >&2
  echo "Set VSCODE_GNU_DIR to a valid runtime dir and retry." >&2
  exit 1
fi

"$PATCH_SCRIPT" \
  --server-dir "$SERVER_DIR" \
  --gnu-dir "$GNU_DIR" \
  --create-skip-check

echo
echo "Patch workflow complete."
echo "If local VS Code was just upgraded, reconnect now."
