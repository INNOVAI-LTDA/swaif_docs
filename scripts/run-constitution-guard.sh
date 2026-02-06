#!/usr/bin/env bash
set -euo pipefail

for f in docs/CONSTITUTION_GUIDE.md docs/SWAIF_HANDBOOK.md; do
  [[ -f "$f" ]] || { echo "Missing $f"; exit 1; }
done

echo "Constitution guard passed."
