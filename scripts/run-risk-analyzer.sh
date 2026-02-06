#!/usr/bin/env bash
set -euo pipefail

echo "# Risk Analysis"
echo "| Risk | Impact | Likelihood | Mitigation |"
echo "|---|---|---|---|"
echo "| Spec ambiguity | Medium | Medium | Clarify unresolved requirements in issue comments |"
echo "| Missing tests | High | Medium | Enforce test-first checks in CI |"
