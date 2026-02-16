# Implementer Agent Reference

## Owner
SpecKit (external dependency — reference only)

## What it does
Writes code according to the approved task breakdown and plan.

## How SWAIF invokes it
Kanban label `swaif:implement` triggers implementation-stage execution.

## What SWAIF injects
- `tasks.md`
- `plan.md`
- `execution_mode` from risk agent

## What SWAIF controls
- Execution mode
- Checkpoint frequency

## What SWAIF validates after
- Tests are written before implementation per constitution
- Checkpoints pass
