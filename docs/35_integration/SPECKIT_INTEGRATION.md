# SWAIF ↔ SpecKit Integration Interface

## Owner
SWAIF (this repository)

## Architecture
SWAIF is the SCADA/control layer. SpecKit is the production machine (CNC) that executes SDD transformations.
SWAIF never exposes raw client data directly to SpecKit; it passes a sanitized Factory Input Package (FIP).

```text
Manager
  -> SWAIF (intake / risk / constitution)
  -> SpecKit (specify / plan / tasks / implement)
  -> SWAIF (evaluate / release)
  -> Done
```

## Invocation Model
For every production stage, SWAIF applies a parametric callback pattern:
1. Read SWAIF context (constitution, intake state, memory, risk, execution type).
2. Set SpecKit parameters for the stage.
3. Invoke SpecKit in the background.
4. Validate resulting artifacts against SWAIF business and governance rules.
5. Handle outcome (`commit` / `open PR` / `block and escalate`).

## Parameter Matrix

| Stage | SpecKit Command | SWAIF Injects | SWAIF Validates After |
|-------|----------------|---------------|----------------------|
| Specify | /speckit specify | constitution, FIP, execution_type, memory | No NEEDS_CLARIFICATION, constitutional compliance, execution type coverage |
| Plan | /speckit plan | constitution, spec.md, memory | Evidence plan maps all ACs, research phase if required |
| Tasks | /speckit tasks | spec.md, plan.md | Every AC has ≥1 task, dependency order valid |
| Implement | /speckit implement | tasks.md, plan.md, execution_mode | Tests before code (constitution), checkpoints pass |

## Version Tracking
SWAIF tracks SpecKit dependency drift through an explicit impact log.
When SpecKit templates, command behavior, or agent expectations change:
- Register the change in `SPECKIT_IMPACT_LOG.md`.
- Assess governance impact (constitution, execution modes, risk controls).
- Assess template/reference impact (`templates/speckit-refs/*`).
- Define and track remediation actions before rollout.

## SWAIF Extensions
SWAIF adds control-plane capabilities that SpecKit does not own:
- Factory Input Package (FIP) intake and validation
- Execution type taxonomy and stage rigor policy
- Constitution enforcement and gate controls
- Kanban orchestration and GitHub Projects integration
- Evidence collection and evaluator/release blocking logic
- Pricing, metrics, and client-facing factory interface
