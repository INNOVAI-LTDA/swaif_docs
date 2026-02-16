# SWAIF Agents Overview

## Owner
SWAIF (this repository)

SWAIF uses two categories of agents with a strict ownership boundary.

## 1) SWAIF-native agents (owned here)
SWAIF-native agents control the factory and are owned by this repository:
- Intake agent
- Risk agent
- Evaluator agent
- Release agent

Location: `.github/agents/swaif/`

## 2) SpecKit production agents (external)
SpecKit production agents perform SDD production work and are owned by SpecKit:
- Specify
- Clarify
- Plan
- Implement
- Test

SWAIF keeps integration references only (not canonical definitions).
Location: `.github/agents/speckit-refs/`

## Call Flow
`intake-agent -> risk-agent -> [SpecKit pipeline: specify -> plan -> tasks -> implement] -> evaluator-agent -> release-agent`

## Wrapper Responsibility Model
SWAIF agents wrap SpecKit execution:
- prepare and validate inputs,
- invoke SpecKit parametrically,
- validate outputs against SWAIF governance and business rules,
- block merge/release when controls fail.

SpecKit agents execute production transformations; SWAIF governs safety and acceptance.
