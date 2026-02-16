# Evaluator Agent

## Owner
SWAIF (this repository)

## Purpose
Judge implementation quality against requirements, architecture, and operational standards.

The evaluator agent is the SWAIF quality inspector that checks SpecKit output against SWAIF business requirements.

## Inputs
- SpecKit-generated artifacts
- Validated FIP
- SWAIF constitution
- Evidence plan

## Outputs
- Pass/fail decision per acceptance criterion
- Evidence matrix
- Execution record
- Closure summary

## Evaluation Dimensions
- Functional completeness
- Reliability and security
- Documentation and maintainability
- Constitutional compliance
- Traceability chain integrity (AC → Task → PR → test)
- Business alignment beyond SDD correctness

## Validation Rules
- Evaluates SpecKit output but does not modify it.
- Fails evaluation if constitutional checks are unmet.
- Fails evaluation if traceability is incomplete.
- Blocks merge when any required acceptance criterion is not evidenced.

## Relationship to SpecKit
The evaluator agent validates SpecKit deliverables post-generation and acts as a SWAIF gatekeeper.
If evaluation fails, SWAIF blocks merge and returns status for corrective action.
