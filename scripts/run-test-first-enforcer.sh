#!/usr/bin/env bash
set -euo pipefail

base_ref="${1:-origin/main}"
changed=$(git diff --name-only "$base_ref"...HEAD || true)
impl=$(printf '%s\n' "$changed" | grep -Ec '^(src/|scripts/|examples/)' || true)
tests=$(printf '%s\n' "$changed" | grep -Ec '^(tests/|spec/|__tests__/|examples/.+\.spec\.md)' || true)
if [[ "$impl" -gt 0 && "$tests" -eq 0 ]]; then
  echo "Implementation changed without tests/spec updates."
  exit 1
fi

echo "Test-first enforcer passed."
