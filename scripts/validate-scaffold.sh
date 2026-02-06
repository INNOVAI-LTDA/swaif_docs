#!/usr/bin/env bash
set -euo pipefail

bash scripts/check-workflow-files.sh
bash scripts/check-agent-specs.sh
bash scripts/check-issue-templates.sh

example_count=$(find examples/oauth2-auth -maxdepth 1 -type f | wc -l | tr -d ' ')
[[ "$example_count" == "5" ]] || { echo "Expected 5 oauth2 example files, found $example_count"; exit 1; }

script_count=$(find scripts -maxdepth 1 -type f -name '*.sh' | wc -l | tr -d ' ')
[[ "$script_count" == "9" ]] || { echo "Expected 9 shell scripts, found $script_count"; exit 1; }

echo "Scaffold validation passed."
