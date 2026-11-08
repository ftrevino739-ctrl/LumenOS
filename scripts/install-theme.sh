#!/usr/bin/env bash
set -Eeuo pipefail

ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
COLOR_SOURCE="${ROOT_DIR}/config/plasma/Lumen.colors"
STYLE_SOURCE="${ROOT_DIR}/config/plasma/desktoptheme/lumen"
LOOK_SOURCE="${ROOT_DIR}/config/plasma/look-and-feel/com.lumen.desktop"
PANEL_SOURCE="${ROOT_DIR}/config/plasma/layout-templates/com.lumen.panel"
WALLPAPER_SOURCE="${ROOT_DIR}/config/wallpapers/lumen.svg"

COLOR_DIR="${HOME}/.local/share/color-schemes"
STYLE_DIR="${HOME}/.local/share/plasma/desktoptheme/lumen"
LOOK_DIR="${HOME}/.local/share/plasma/look-and-feel/com.lumen.desktop"
PANEL_DIR="${HOME}/.local/share/plasma/layout-templates/com.lumen.panel"
WALLPAPER_DIR="${HOME}/Pictures/Wallpapers"

[[ -f "${COLOR_SOURCE}" && -f "${STYLE_SOURCE}/metadata.json" && -f "${LOOK_SOURCE}/manifest.json" && -f "${PANEL_SOURCE}/metadata.json" && -f "${WALLPAPER_SOURCE}" ]] || {
  echo "One or more Lumen theme assets are missing." >&2
  exit 1
}

mkdir -p "${COLOR_DIR}" "${STYLE_DIR}" "${LOOK_DIR}" "${PANEL_DIR}" "${WALLPAPER_DIR}"
install -m 0644 "${COLOR_SOURCE}" "${COLOR_DIR}/Lumen.colors"
cp -a "${STYLE_SOURCE}/." "${STYLE_DIR}/"
cp -a "${LOOK_SOURCE}/." "${LOOK_DIR}/"
cp -a "${PANEL_SOURCE}/." "${PANEL_DIR}/"
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

echo "In System Settings > Appearance > Global Theme, select Lumen. Keep the desktop/panel layout option unchecked to preserve existing panels."
echo "To activate the Plasma style separately, open System Settings > Appearance > Plasma Style and select Lumen."
echo "To add the optional panel, right-click the panel > Add Panel > Lumen Glass Panel. This adds a panel without deleting existing ones."
echo "To use the wallpaper, open Desktop and Wallpaper settings and choose Pictures/Wallpapers/Lumen.svg."
