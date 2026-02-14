# Repository Purpose — SWAIF Documentation Hub

## What this repository is
This repository is the canonical documentation source for SWAIF.

It exists to define, evolve, and publish:
- SWAIF governance (constitution, articles, principles)
- SWAIF workflow and stage gates
- Agent roles and execution modes
- Canonical templates (specify, plan, tasks)
- Research methodology (validation protocol, metrics, experimental design)
- Documentation outputs for multiple purposes:
  - public funding proposals (e.g., FAPESP/CNPq/FINEP)
  - customer presentations and pitch narratives
  - technical articles and research reports
  - benchmarks and case write-ups (documentation only)
  - lessons learned and failure analyses (documentation only)

This repository is the “engine specification,” not the execution environment.

---

## What this repository is NOT
This repository must NOT contain:
- product codebases or running implementations
- experimental run logs and datasets (raw execution results)
- benchmark raw data and trace files
- generated artifacts tied to a specific execution run
- customer-specific confidential materials (unless explicitly designed as sanitized examples)

Execution belongs in separate repositories.

---

## Relationship to SWAIF Execution Repositories
Separate execution repositories will:
- run SWAIF workflows end-to-end (hands-on, research, PoC, MVP, product)
- store cases, experiments, and datasets
- produce measurable results
- optionally sync templates and reference governance from this documentation hub

This repository provides the reference materials and canonical templates that execution repositories may import.

---

## Change policy (simple rules)
- Documentation and templates can evolve here.
- Any update that changes workflow meaning must be tracked via PR.
- Any material derived from real execution must be published here only as a sanitized, stable report (never raw run artifacts).

---

## Single sentence summary
This repository defines SWAIF; other repositories run SWAIF.
