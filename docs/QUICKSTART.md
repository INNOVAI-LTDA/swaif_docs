# SWAIF Quickstart

Use this guide to move from prerequisites to a working first SWAIF project.

## Prerequisites
- A version-controlled project repository
- A work tracking board (issues, tasks, or tickets)
- A CI pipeline capable of running tests and lint checks
- Team agreement on ownership roles (product, engineering, operations)

## Install / Setup
1. Create a `docs/` directory in your project repository for SWAIF artifacts.
2. Add governance references from the [Constitution Guide](CONSTITUTION_GUIDE.md).
3. Define your delivery stages as outlined in the [Workflow Guide](WORKFLOW_GUIDE.md).
4. Create a baseline scorecard for lead time, defect escape rate, and deployment frequency.

## First Project
1. Select a small, high-value initiative with clear acceptance criteria.
2. Run intake: objective, constraints, dependencies, and measurable outcome.
3. Move the initiative through stage gates with explicit go/no-go checks.
4. Release in a limited scope and gather outcome evidence.
5. Capture lessons learned and add follow-up improvements.

## Essential Commands
Adapt these to your stack; keep them standardized and visible:

```bash
# quality checks
npm run lint
npm test

# build and package
npm run build

# run locally
npm run dev
```

For deeper context, continue with the [SWAIF Handbook](SWAIF_HANDBOOK.md).
