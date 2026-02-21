#!/usr/bin/env bash
set -euo pipefail

REPO="${REPO:-abuiles/wtadd}"
VERSION="${VERSION:-main}"
TARGET_DIR="${BIN_DIR:-${HOME}/.local/bin}"
TARGET_BIN="${TARGET_DIR}/wt"
TMP_FILE="$(mktemp)"

mkdir -p "${TARGET_DIR}"
trap 'rm -f "${TMP_FILE}"' EXIT

curl -fsSL "https://raw.githubusercontent.com/${REPO}/${VERSION}/wt" -o "${TMP_FILE}"
install -m 0755 "${TMP_FILE}" "${TARGET_BIN}"

echo "Installed wt to ${TARGET_BIN}"
echo "Source: https://github.com/${REPO} (${VERSION})"
echo ""
echo "Make sure ${TARGET_DIR} is on your PATH."
echo "For zsh, add this to ~/.zshrc if needed:"
echo '  export PATH="$HOME/.local/bin:$PATH"'
