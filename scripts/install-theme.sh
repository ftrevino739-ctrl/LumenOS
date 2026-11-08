#!/usr/bin/env bash
set -Eeuo pipefail

ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
SOURCE="${ROOT_DIR}/config/plasma/Lumen.colors"
TARGET_DIR="${HOME}/.local/share/color-schemes"
TARGET="${TARGET_DIR}/Lumen.colors"

[[ -f "${SOURCE}" ]] || { echo "Theme file not found: ${SOURCE}" >&2; exit 1; }
mkdir -p "${TARGET_DIR}"
install -m 0644 "${SOURCE}" "${TARGET}"
echo "Installed Lumen color scheme to ${TARGET}"

if command -v plasma-apply-colorscheme >/dev/null 2>&1; then
  plasma-apply-colorscheme Lumen || {
    echo "Theme installed, but Plasma could not apply it automatically." >&2
    exit 1
  }
  echo "Applied Lumen color scheme."
else
  echo "Theme installed. Open System Settings > Colors to select Lumen."
fi
