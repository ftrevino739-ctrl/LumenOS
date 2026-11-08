#!/usr/bin/env bash
set -Eeuo pipefail

ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
BUILD_DIR="${ROOT_DIR}/build"
PREFIX="/usr/local"

if [[ "${EUID}" -eq 0 ]]; then
  echo "Do not run this script with sudo. It will request sudo only for package installation and app installation." >&2
  exit 2
fi

if ! command -v apt-get >/dev/null 2>&1; then
  echo "Lumen installer currently supports Ubuntu/Kubuntu and apt-based systems only." >&2
  exit 2
fi

if ! command -v cmake >/dev/null 2>&1 || ! pkg-config --exists Qt6Quick 2>/dev/null; then
  echo "This will install the build tools and Qt 6 development dependencies."
  read -r -p "Continue? [y/N] " answer
  [[ "${answer}" =~ ^[Yy]$ ]] || { echo "Cancelled."; exit 0; }
  sudo apt-get update
  sudo apt-get install -y build-essential cmake pkg-config qt6-base-dev qt6-declarative-dev qt6-quickcontrols2-dev qml6-module-qtquick qml6-module-qtquick-controls qml6-module-qtquick-layouts qml6-module-qtquick-window
fi

echo "Building Lumen Desktop..."
cmake -S "${ROOT_DIR}/desktop" -B "${BUILD_DIR}" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX="${PREFIX}"
cmake --build "${BUILD_DIR}" --parallel

echo "Installing Lumen Desktop to ${PREFIX}..."
sudo cmake --install "${BUILD_DIR}"

echo "Installing the Lumen color scheme for the current user..."
"${ROOT_DIR}/scripts/install-theme.sh" || echo "The app was installed; select Lumen manually in System Settings > Colors if needed."

echo
echo "Lumen Desktop is installed. Find 'Lumen Desktop Preview' in the application launcher."
echo "To start it from a terminal, run: lumen-desktop"
