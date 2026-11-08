#!/usr/bin/env bash
set -Eeuo pipefail

ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
COLOR_SOURCE="${ROOT_DIR}/config/plasma/Lumen.colors"
STYLE_SOURCE="${ROOT_DIR}/config/plasma/desktoptheme/lumen"
WALLPAPER_SOURCE="${ROOT_DIR}/config/wallpapers/lumen.svg"

COLOR_DIR="${HOME}/.local/share/color-schemes"
STYLE_DIR="${HOME}/.local/share/plasma/desktoptheme/lumen"
WALLPAPER_DIR="${HOME}/Pictures/Wallpapers"

[[ -f "${COLOR_SOURCE}" && -f "${STYLE_SOURCE}/metadata.json" && -f "${WALLPAPER_SOURCE}" ]] || {
  echo "One or more Lumen theme assets are missing." >&2
  exit 1
}

mkdir -p "${COLOR_DIR}" "${STYLE_DIR}" "${WALLPAPER_DIR}"
install -m 0644 "${COLOR_SOURCE}" "${COLOR_DIR}/Lumen.colors"
cp -a "${STYLE_SOURCE}/." "${STYLE_DIR}/"
install -m 0644 "${WALLPAPER_SOURCE}" "${WALLPAPER_DIR}/Lumen.svg"

echo "Installed the Lumen color scheme and Plasma style for this user."
echo "Wallpaper copied to ${WALLPAPER_DIR}/Lumen.svg"

if command -v plasma-apply-colorscheme >/dev/null 2>&1; then
  if plasma-apply-colorscheme Lumen; then
    echo "Applied the Lumen color scheme."
  else
    echo "The color scheme is installed; select Lumen in System Settings > Colors." >&2
  fi
else
  echo "Open System Settings > Colors and select Lumen."
fi

echo "To activate the Plasma style, open System Settings > Appearance > Plasma Style and select Lumen."
echo "To use the wallpaper, open Desktop and Wallpaper settings and choose Pictures/Wallpapers/Lumen.svg."
