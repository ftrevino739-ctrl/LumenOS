#!/usr/bin/env bash
set -Eeuo pipefail
ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
MANIFEST="${ROOT_DIR}/config/packages/base.txt"

command -v apt-cache >/dev/null 2>&1 || { echo "ERROR: apt-cache is required." >&2; exit 2; }
[[ -f "${MANIFEST}" ]] || { echo "ERROR: package manifest missing." >&2; exit 2; }

missing=0
while IFS= read -r package || [[ -n "${package}" ]]; do
  package="${package%%#*}"
  package="${package//[[:space:]]/}"
  [[ -z "${package}" ]] && continue
  if apt-cache show "${package}" >/dev/null 2>&1; then
    printf 'OK      %s\n' "${package}"
  else
    printf 'MISSING %s\n' "${package}"
    missing=$((missing + 1))
  fi
done < "${MANIFEST}"

if (( missing )); then
  printf '%d package(s) not found in configured APT indexes.\n' "${missing}" >&2
  exit 1
fi
echo "All manifest packages are present in configured APT indexes."
