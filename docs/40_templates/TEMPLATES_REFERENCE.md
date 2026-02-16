# Templates Reference

## Owner
SWAIF (this repository)

SWAIF separates template ownership between governance artifacts and external production-template references.

## SWAIF-owned template
- `templates/swaif-constitution.md` — the governance framework applied to every factory run.

## SpecKit-owned template references
- `templates/speckit-refs/` contains reference documents for SpecKit SDD templates:
  - spec template reference
  - plan template reference
  - tasks template reference

SWAIF extends SpecKit templates with factory-specific fields but does not own the base templates.

## Update policy
When SpecKit updates its templates, SWAIF must:
1. update corresponding reference docs in `templates/speckit-refs/`, and
2. assess and record impact in `docs/35_integration/SPECKIT_IMPACT_LOG.md`.
