# Planner Agent Reference

## Owner
SpecKit (external dependency — reference only)

## What it does
Creates architecture and implementation plans from approved specification inputs.

## How SWAIF invokes it
Kanban label `swaif:plan` triggers the plan-stage call.

## What SWAIF injects
- Constitution context
- `spec.md`
- Project memory

## What SWAIF controls
- Enforces research phase when required by execution type

## What SWAIF validates after
- Evidence plan maps to all acceptance criteria
