#!/usr/bin/env bash
set -Eeuo pipefail

ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
BUILD_DIR="${ROOT_DIR}/build"
PREFIX="/usr/local"

if [[ "${EUID}" -eq 0 ]]; then
  echo "Do not run this script with sudo. It will request elevation only when needed." >&2
  exit 2
fi

if ! command -v apt-get >/dev/null 2>&1; then
  echo "Lumen source installer currently supports Ubuntu/Kubuntu and apt-based systems only." >&2
  exit 2
fi

packages=(
  build-essential
  cmake
  pkg-config
  qt6-base-dev
  qt6-declarative-dev
  qml6-module-qtqml
  qml6-module-qtqml-models
  qml6-module-qtqml-workerscript
  qml6-module-qtquick
  qml6-module-qtquick-controls
  qml6-module-qtquick-layouts
  qml6-module-qtquick-window
)
missing=()
for package in "${packages[@]}"; do
  if ! dpkg-query -W -f='${db:Status-Status}' "${package}" 2>/dev/null | grep -qx installed; then
    missing+=("${package}")
  fi
done

if (( ${#missing[@]} )); then
  printf 'The following packages will be installed: %s\n' "${missing[*]}"
  read -r -p "Continue? [y/N] " answer
  [[ "${answer}" =~ ^[Yy]$ ]] || { echo "Cancelled."; exit 0; }
  sudo apt-get update
  sudo apt-get install -y "${missing[@]}"
fi

echo "Building Lumen Desktop..."
cmake -S "${ROOT_DIR}/desktop" -B "${BUILD_DIR}" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX="${PREFIX}"
cmake --build "${BUILD_DIR}" --parallel

echo "Installing Lumen Desktop to ${PREFIX}..."
sudo cmake --install "${BUILD_DIR}"

echo "Installing the Lumen style and wallpaper for the current user..."
"${ROOT_DIR}/scripts/install-theme.sh"

echo
echo "Lumen Desktop is installed. Find 'Lumen Desktop Preview' in the application launcher."
echo "To start it from a terminal, run: lumen-desktop"
