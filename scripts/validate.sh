#!/usr/bin/env bash
set -Eeuo pipefail
ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
cd "${ROOT_DIR}"

while IFS= read -r -d '' script; do
  bash -n "${script}"
  printf 'Shell syntax OK: %s\n' "${script}"
done < <(find scripts -type f -name '*.sh' -print0)

for file in README.md docs/ARCHITECTURE.md docs/DESIGN-SYSTEM.md docs/BUILD.md config/packages/base.txt; do
  [[ -s "${file}" ]] || { echo "Missing or empty: ${file}" >&2; exit 1; }
done
echo "VitreOS repository validation passed."
