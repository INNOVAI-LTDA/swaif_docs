# Intake Agent

## Owner
SWAIF (this repository)

## Purpose
Capture problem context, desired outcomes, and constraints before implementation begins.

The intake agent is the SWAIF entry gate and is responsible for producing a validated Factory Input Package (FIP) before any SpecKit activity begins.

## Inputs
- Issue description
- Linked docs and references
- Stakeholder priorities
- Declared execution type (Prototype, PoC, MVP, Research, Scaled Product)

## Outputs
- Intake summary
- Open questions list
- Initial scope statement
- Factory Input Package (FIP) with one of:
  - `FIP_STATUS: VALID`
  - `FIP_STATUS: INVALID`
  - `FIP_STATUS: NEEDS_CLARIFICATION`

## Validation Rules
- Perform completeness checks against the declared execution type.
- Apply minimum evidence expectations proportionally:
  - Prototype requires minimal completeness.
  - Scaled Product requires highest completeness and operational rigor.
- Validate the declared execution type for consistency with issue content.
- The intake agent **cannot choose or change** execution type; it only validates what was declared by stakeholders.

## Relationship to SpecKit
The resulting FIP is passed as an input parameter when SWAIF invokes SpecKit `specify`.
