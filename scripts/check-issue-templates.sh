#!/usr/bin/env bash
set -euo pipefail

required=(
  .github/ISSUE_TEMPLATE/feature_request.yml
  .github/ISSUE_TEMPLATE/bug_report.yml
  .github/ISSUE_TEMPLATE/task_request.yml
  .github/CODEOWNERS
  .github/pull_request_template.md
)

for file in "${required[@]}"; do
  [[ -f "$file" ]] || { echo "Missing template/config: $file"; exit 1; }
done

echo "Issue template and ownership check passed."
