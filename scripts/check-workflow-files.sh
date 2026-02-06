#!/usr/bin/env bash
set -euo pipefail

required=(
  .github/workflows/factory-stage-gate.yml
  .github/workflows/constitution-guard.yml
  .github/workflows/test-first-enforcer.yml
  .github/workflows/evaluation-agent.yml
  .github/workflows/risk-analyzer.yml
)

for file in "${required[@]}"; do
  [[ -f "$file" ]] || { echo "Missing workflow: $file"; exit 1; }
done

echo "Workflow file check passed."
