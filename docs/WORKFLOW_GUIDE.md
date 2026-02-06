# Workflow Guide

This guide describes the day-to-day operating flow, stage transitions, and common troubleshooting patterns in SWAIF.

## Daily Flow
1. **Plan the Day** — Confirm priorities, dependencies, and risk flags.
2. **Execute in Small Batches** — Keep work items narrow and testable.
3. **Validate Continuously** — Run checks early and often.
4. **Publish Status Transparently** — Update board states with clear evidence.
5. **Close with Learning** — Capture blockers, surprises, and follow-ups.

## Stage Transitions

### Intake → Ready
- Problem statement is clear.
- Success metrics are defined.
- Dependencies and owners are identified.

### Ready → In Progress
- Scope is bounded.
- Acceptance criteria are testable.
- Risk controls are documented.

### In Progress → Validation
- Functional work is complete.
- Tests pass at required levels.
- Operational readiness items are prepared.

### Validation → Release
- Quality and compliance checks pass.
- Stakeholder sign-off is recorded.
- Rollback/mitigation plan is available.

### Release → Learn
- Outcome data is collected.
- Deviations from plan are analyzed.
- Improvement actions are logged.

## Troubleshooting
- **Work stalls in Ready**: break oversized scope and remove ambiguous acceptance criteria.
- **Frequent late defects**: shift validation earlier and expand automated checks.
- **Unclear ownership**: re-map decisions to named roles in planning artifacts.
- **Transition churn**: enforce explicit entry/exit criteria at each stage.

See the [Case Studies](CASE_STUDIES.md) for applied examples and anti-patterns.
