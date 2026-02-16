# Specify Agent Reference

## Owner
SpecKit (external dependency — reference only)

## What it does
Transforms validated input context into a structured software specification.

## How SWAIF invokes it
Kanban label `swaif:specify` triggers a parametric call to the SpecKit specify stage.

## What SWAIF injects
- Constitution context
- FIP content
- Execution type
- Project memory

## What SWAIF validates after
- No `NEEDS_CLARIFICATION` markers remain unresolved
- Constitutional compliance is preserved
- Execution type minimum coverage is satisfied
