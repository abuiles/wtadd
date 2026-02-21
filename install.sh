#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="${HOME}/.local/bin"
TARGET_BIN="${TARGET_DIR}/wt"

mkdir -p "${TARGET_DIR}"
install -m 0755 "${ROOT_DIR}/wt" "${TARGET_BIN}"

echo "Installed wt to ${TARGET_BIN}"
echo ""
echo "Make sure ${TARGET_DIR} is on your PATH."
echo "For zsh, add this to ~/.zshrc if needed:"
echo '  export PATH="$HOME/.local/bin:$PATH"'
