#!/usr/bin/env bash
set -Eeuo pipefail
ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
cd "${ROOT_DIR}"

while IFS= read -r -d '' script; do
  bash -n "${script}"
  printf 'Shell syntax OK: %s\n' "${script}"
done < <(find scripts -type f -name '*.sh' -print0)

required_files=(
  README.md
  LICENSE
  docs/ARCHITECTURE.md
  docs/DESIGN-SYSTEM.md
  docs/BUILD.md
  config/packages/base.txt
  config/icons/lumen.svg
  config/plasma/Lumen.colors
  config/plasma/desktoptheme/lumen/metadata.json
  config/plasma/desktoptheme/lumen/plasmarc
  config/plasma/look-and-feel/com.lumen.desktop/manifest.json
  config/plasma/look-and-feel/com.lumen.desktop/metadata.json
  config/plasma/look-and-feel/com.lumen.desktop/contents/defaults
  config/plasma/layout-templates/com.lumen.panel/metadata.json
  config/plasma/layout-templates/com.lumen.panel/contents/layout.js
  config/plasma/desktoptheme/lumen/widgets/background.svg
  config/plasma/desktoptheme/lumen/widgets/panel-background.svg
  config/plasma/desktoptheme/lumen/dialogs/background.svg
  config/wallpapers/lumen.svg
  desktop/CMakeLists.txt
  desktop/main.cpp
  desktop/SystemActions.h
  desktop/SystemActions.cpp
  desktop/Main.qml
  desktop/GlassSurface.qml
  desktop/org.lumen.Desktop.desktop
  scripts/install.sh
  scripts/install-theme.sh
  scripts/build-iso.sh
)
for file in "${required_files[@]}"; do
  [[ -s "${file}" ]] || { echo "Missing or empty: ${file}" >&2; exit 1; }
done

python3 - <<'PY'
import json
import xml.etree.ElementTree as ET

with open("config/plasma/desktoptheme/lumen/metadata.json", encoding="utf-8") as stream:
    metadata = json.load(stream)
assert metadata["KPlugin"]["Id"] == "lumen"
assert metadata["KPlugin"]["Name"] == "Lumen"

with open("config/plasma/look-and-feel/com.lumen.desktop/manifest.json", encoding="utf-8") as stream:
    manifest = json.load(stream)
assert manifest["KPackageStructure"] == "Plasma/LookAndFeel"
with open("config/plasma/look-and-feel/com.lumen.desktop/metadata.json", encoding="utf-8") as stream:
    look_and_feel = json.load(stream)
assert look_and_feel["KPlugin"]["Id"] == "com.lumen.desktop"
with open("config/plasma/layout-templates/com.lumen.panel/metadata.json", encoding="utf-8") as stream:
    panel = json.load(stream)
assert panel["KPackageStructure"] == "Plasma/LayoutTemplate"

for path in (
    "config/icons/lumen.svg",
    "config/plasma/desktoptheme/lumen/widgets/background.svg",
    "config/plasma/desktoptheme/lumen/widgets/panel-background.svg",
    "config/plasma/desktoptheme/lumen/dialogs/background.svg",
    "config/wallpapers/lumen.svg",
):
    ET.parse(path)

required_frames = {
    "topleft", "top", "topright", "left", "center",
    "right", "bottomleft", "bottom", "bottomright"
}
for path in (
    "config/plasma/desktoptheme/lumen/widgets/background.svg",
    "config/plasma/desktoptheme/lumen/widgets/panel-background.svg",
    "config/plasma/desktoptheme/lumen/dialogs/background.svg",
):
    root = ET.parse(path).getroot()
    ids = {node.attrib.get("id") for node in root.iter()}
    missing = required_frames - ids
    assert not missing, f"{path} is missing SVG frame IDs: {sorted(missing)}"

print("JSON and SVG assets validated.")
PY

echo "Lumen repository validation passed."
