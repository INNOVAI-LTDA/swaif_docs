#!/usr/bin/env bash
set -euo pipefail

count=$(find .github/agents -maxdepth 1 -name '*.md' | wc -l | tr -d ' ')
[[ "$count" == "9" ]] || { echo "Expected 9 agent specs, found $count"; exit 1; }

echo "Agent spec count check passed."
