# Release Agent

## Owner
SWAIF (this repository)

## Purpose
Ensure safe rollout planning, communication, and rollback readiness.

The release agent is the shipping department and performs final SWAIF checks after the production pipeline completes.

## Inputs
- Evaluator pass status
- Evidence matrix
- Pull request context

## Outputs
- Final release checklist covering:
  - Changelog readiness
  - Monitoring and alerts
  - Rollback playbook
  - Constitutional compliance confirmation
  - Evidence for all acceptance criteria
  - PR linkage to originating issue

## Release Checklist
1. Changelog and migration notes prepared.
2. Monitoring and alerts defined.
3. Rollback playbook verified.

## Validation Rules
- Blocks merge if any checklist item is unmet.
- High/Critical risk releases require manager approval label before merge.

## Relationship to SpecKit
This agent runs only after the SpecKit pipeline has completed and is entirely in SWAIF domain.
