# Risk Agent

## Owner
SWAIF (this repository)

## Purpose
Identify and score delivery risk before merge.

The risk agent functions as the factory safety system and decides execution mode before SpecKit runs.

## Inputs
- Validated FIP
- Spec artifacts available at the current stage
- Blast radius analysis (technical, operational, and business impact)

## Outputs
- Risk score: Low / Moderate / High / Critical
- Execution mode: Copilot / Human / Challenger
- Required controls list (checks, approvals, and safeguards)

## Risk Rubric
- Impact: Low / Medium / High
- Likelihood: Low / Medium / High
- Mitigation owner and due date

## Validation Rules
- Risk classification must map to `.specify/factory/risk-mode-map.yaml`.
- High and Critical outcomes require manager sign-off before merge.
- Required controls must be explicit and auditable in the execution record.

## Relationship to SpecKit
Risk score and controls set the `execution_mode` parameter for SpecKit invocation.
SpecKit does not assess risk; it consumes SWAIF-provided execution mode.
