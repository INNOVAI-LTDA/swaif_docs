# SWAIF Quick Start Guide

**Get your first SWAIF project running in 5 minutes**

This guide walks you through installing SWAIF, initializing a project, and completing your first stage-gated workflow.

---

## How SWAIF Produces a Solution

SWAIF produces a solution by converting a request into a sequence of stage artifacts, then enforcing gate criteria between stages.

### 1) INTAKE — Structure the request into a decision-ready problem statement

**Primary tool:** `swaif intake` CLI workflow  
**Goal:** turn an unstructured request into an intake artifact with risk and feasibility metadata.

**Command used**
```bash
swaif intake create "Task API with CRUD operations"
```

**Parameters**
- `create`: starts a new intake artifact.
- `"Task API with CRUD operations"`: seed requirement title used to initialize prompts.

**What SWAIF asks for and records**
- Business intent, scope, constraints, stakeholders, priority.
- Initial complexity and risk level.
- Early assumptions/dependencies.

**Output artifacts**
- `.swaif/artifacts/intake-001.md`
- initial risk matrix metadata

---

### 2) INTAKE GATE — Verify readiness to specify

**Primary tool:** `swaif gate`  
**Goal:** ensure intake exit criteria are met before specification work begins.

**Commands used**
```bash
swaif gate status INTAKE
swaif gate approve INTAKE --reviewer="$(whoami)"
```

**Parameters**
- `status INTAKE`: evaluates gate checks for the INTAKE stage.
- `approve INTAKE`: records approval and unlocks the next stage.
- `--reviewer="$(whoami)"`: stamps the decision with the current operator identity.

**Gate checks typically include**
- stakeholder clarity
- feasibility evidence
- risk matrix completeness

---

### 3) SPECIFY — Convert intent into testable system behavior

**Primary tool:** `swaif specify`  
**Goal:** produce concrete, testable specifications from the intake artifact.

**Command used**
```bash
swaif specify --mode=copilot --auto-approve
```

**Parameters**
- `--mode=copilot`: uses Copilot-assisted generation behavior.
- `--auto-approve`: applies automatic gate approval when required checks pass.

**Output artifacts**
- `specs/api-contract.yaml`
- `specs/data-model.md`
- `specs/acceptance-tests.md`
- `specs/behaviors.md`

**Why this matters**
- Requirements become explicit contracts and acceptance criteria, reducing ambiguity before implementation.

---

### 4) PLAN — Select architecture and implementation strategy

**Primary tool:** `swaif plan`  
**Goal:** convert specs into a build-ready design and delivery approach.

**Command used**
```bash
swaif plan --mode=copilot
```

**Parameters**
- `--mode=copilot`: enables AI-assisted plan generation and trade-off documentation.

**Typical outputs**
- architecture document(s)
- deployment/runtime configuration
- dependency baseline
- explicit technology choices with rationale

**Gate behavior**
- The PLAN gate checks design completeness, risk controls, and implementation readiness.

---

### 5) TASKS — Decompose plan artifacts into executable units

**Primary tool:** `swaif tasks`  
**Goal:** break architecture into ordered, estimable tasks aligned to acceptance outcomes.

**Command used**
```bash
swaif tasks generate
```

**Parameters**
- `generate`: builds a structured task matrix from current plan/spec artifacts.

**Output artifacts**
- `.swaif/stages/tasks.yaml` (task IDs, sequencing, estimates, and dependency hints)

**Why this matters**
- Keeps implementation traceable: each task maps back to spec behavior and acceptance tests.

---

### 6) BUILD / VALIDATE — Implement with continuous conformance checks

**Primary tools:** implementation stack + SWAIF gate checks  
**Goal:** produce working software and prove it satisfies the specified behaviors.

**Typical command pattern**
```bash
# implement code per task
# run project test suite
# run stage or quality gate checks
swaif gate status BUILD
```

**Parameters**
- `status BUILD`: verifies BUILD-stage criteria (for example, required tests and quality controls).

**Evidence generated**
- passing test results
- implementation diffs tied to task IDs
- gate status output

---

### 7) RELEASE / LEARN — Ship safely and feed learning back into future work

**Primary tools:** release controls + SWAIF governance workflow  
**Goal:** deploy with guardrails, measure outcomes, and convert lessons into future intake inputs.

**Typical command pattern**
```bash
swaif gate status RELEASE
swaif gate approve RELEASE --reviewer="$(whoami)"
```

**Parameters**
- `status RELEASE`: confirms operational and governance checks before release.
- `approve RELEASE`: records release authorization.

**Learning loop outputs**
- release decision records
- post-release observations/metrics
- improvement items for subsequent intake cycles

---

### End-to-end traceability model

SWAIF’s core mechanism is: **request → artifacts → gated transition → next-stage artifact**.  
Because each stage has explicit commands, parameters, and outputs, teams can audit exactly how a solution was produced and why each decision was made.

---

## Prerequisites

Before starting, ensure you have:

| Requirement | Version | Check Command |
|-------------|---------|---------------|
| **Git** | 2.30+ | `git --version` |
| **GitHub CLI** | 2.20+ | `gh --version` |
| **Python** | 3.11+ | `python3 --version` |
| **Bash** | 4.0+ | `bash --version` |
| **Docker** (optional) | 20.10+ | `docker --version` |

### System Requirements
- **OS:** Linux, macOS, or WSL2 on Windows
- **RAM:** 4GB minimum, 8GB recommended
- **Disk:** 2GB free space

---

## Installation (2 minutes)

### Step 1: Clone SWAIF CLI

```bash
# Clone the repository
git clone https://github.com/your-org/swaif-cli.git
cd swaif-cli

# Run installer
./install.sh

# Verify installation
swaif --version
# Expected output: SWAIF CLI v1.0.0
```

### Step 2: Configure Authentication

```bash
# Authenticate with GitHub
gh auth login

# Set up SWAIF workspace
swaif config init

# Configure your preferences
swaif config set editor "code"  # or vim, emacs, etc.
swaif config set ai-provider "github-copilot"
```

### Step 3: Verify Setup

```bash
# Run diagnostics
swaif doctor

# Expected output:
# ✓ Git configured correctly
# ✓ GitHub CLI authenticated
# ✓ Python environment ready
# ✓ AI provider accessible
# ✓ All dependencies satisfied
```

---

## Your First Project (3 minutes)

### Scenario: Build a Task Management API

We'll create a REST API for managing tasks with full SWAIF discipline.

### Step 1: Initialize Project

```bash
# Create new project from template
swaif init task-api --template=rest-service --lang=python

# Navigate into project
cd task-api

# Project structure created:
# task-api/
# ├── .swaif/
# │   ├── constitution.yaml      # Project governance rules
# │   ├── stages/                # Stage tracking
# │   └── artifacts/             # Generated documents
# ├── src/                       # Source code
# ├── tests/                     # Test suites
# ├── docs/                      # Documentation
# └── README.md
```

### Step 2: Create Intake Request

```bash
# Start intake process
swaif intake create "Task API with CRUD operations"

# This launches an interactive prompt:
```

**Interactive Prompt:**
```
SWAIF Intake Wizard
-------------------
Project: task-api
Stage: INTAKE

Enter requirement details:

Title: Task Management REST API

Description: RESTful API for creating, reading, updating, and deleting tasks.
Each task has: id, title, description, status (todo/in-progress/done), created_at, updated_at.

Stakeholders (comma-separated): product-team, engineering-lead

Priority [low/medium/high/critical]: high

Initial Assessment:
  Complexity: [low/medium/high]: medium
  Risk Level: [low/medium/high/critical]: low
  Estimated Duration: [days]: 5

Save intake report? [Y/n]: Y

✓ Intake report saved: .swaif/artifacts/intake-001.md
✓ Risk matrix generated
✓ Ready for INTAKE gate review
```

### Step 3: Review and Approve Gate

```bash
# View intake report
swaif gate status INTAKE

# Output:
# INTAKE Gate Status
# ------------------
# Artifact: intake-001.md
# Risk Level: LOW
# Blockers: None
# 
# Exit Criteria:
# ✓ Stakeholder identified
# ✓ Feasibility assessed
# ✓ Risk matrix complete
# ⚠ Awaiting approval
#
# Ready to proceed: YES

# Approve the gate
swaif gate approve INTAKE --reviewer="$(whoami)"

# Output:
# ✓ INTAKE gate approved
# ✓ Stage advanced: INTAKE → SPECIFY
# Next: Run `swaif specify` to generate specifications
```

### Step 4: Generate Specifications

```bash
# Run specification generation in Copilot mode
swaif specify --mode=copilot --auto-approve

# SWAIF will:
# 1. Parse intake requirements
# 2. Generate behavioral specifications
# 3. Create data models
# 4. Design API contracts
# 5. Write acceptance criteria

# Output (abbreviated):
# Analyzing intake-001.md...
# Generating specifications...
# 
# ✓ API specification: specs/api-contract.yaml
# ✓ Data model: specs/data-model.md
# ✓ Test scenarios: specs/acceptance-tests.md
# ✓ Behavioral requirements: specs/behaviors.md
# 
# SPECIFY Gate Auto-Review:
# ✓ All requirements have acceptance criteria
# ✓ Test coverage plan: 100% (12 test cases)
# ✓ Data model validated
# 
# ✓ SPECIFY gate approved
# ✓ Stage advanced: SPECIFY → PLAN
```

### Step 5: Generate Architecture Plan

```bash
# Create implementation plan
swaif plan --mode=copilot

# Output:
# Generating architecture plan...
# 
# Technology Stack:
#   - Framework: FastAPI 0.104.0
#   - Database: PostgreSQL 15
#   - ORM: SQLAlchemy 2.0
#   - Testing: pytest + httpx
#   - Deployment: Docker + docker-compose
# 
# ✓ Architecture diagram: docs/architecture.md
# ✓ Database schema: docs/schema.sql
# ✓ Deployment config: docker-compose.yaml
# ✓ Dependency list: requirements.txt
# 
# PLAN Gate Status:
# ✓ Design review passed
# ✓ Tech stack approved
# ✓ Risks documented
# 
# Awaiting approval...

# Review the plan
less docs/architecture.md

# Approve if satisfied
swaif gate approve PLAN
```

### Step 6: Decompose into Tasks

```bash
# Break plan into executable tasks
swaif tasks generate

# Output:
# Task Breakdown:
# 
# [T-001] Setup database schema and models (2h)
# [T-002] Implement POST /tasks endpoint (1.5h)
# [T-003] Implement GET /tasks endpoint (1h)
# [T-004] Implement GET /tasks/{id} endpoint (1h)
# [T-005] Implement PUT /tasks/{id} endpoint (1.5h)
# [T-006] Implement DELETE /tasks/{id} endpoint (1h)
# [T-007] Add input validation (2h)
# [T-008] Write integration tests (3h)
# [T-009] Add API documentation (1h)
# [T-010] Setup Docker deployment (2h)
# 
# Total estimated time: 16 hours
# Critical path: T-001 → T-002 → T-008
# 
# ✓ Task matrix saved: .swaif/stages/tasks.yaml

# Approve task breakdown
swaif gate approve TASKS
```

### Step 7: Execute Implementation

```bash
# Start implementation (Copilot mode for low-risk tasks)
swaif implement --task=T-001 --mode=copilot

# SWAIF will:
# 1. Generate database models
# 2. Write test cases first (Test-First)
# 3. Implement functionality
# 4. Run tests and verify
# 5. Commit with traceability links

# For the full project:
swaif implement --all --mode=copilot --parallel=3

# This executes all tasks with 3 parallel workers
# Monitor progress:
swaif implement status

# Output:
# Implementation Progress:
# 
# ✓ T-001 Complete (2.1h actual)
# ✓ T-002 Complete (1.4h actual)
# ⚙ T-003 In Progress (45% complete)
# ⏳ T-004 Queued
# ⏳ T-005 Queued
# ...
# 
# Overall: 40% complete (6.5h / 16h estimated)
```

### Step 8: Verification and Deployment

```bash
# Run final verification
swaif verify

# Output:
# Constitutional Compliance Audit:
# 
# Article I (Traceability):
# ✓ All commits link to requirements
# ✓ 10/10 tasks traceable
# 
# Article III (Test-First):
# ✓ All tests written before code
# ✓ Coverage: 96% (target: 80%)
# 
# Article VI (Integration):
# ✓ All changes merged to main
# ✓ No stale branches
# 
# Article VII (Observability):
# ✓ Structured logging configured
# ✓ Health endpoints present
# 
# Verification Status: PASS
# Ready for deployment: YES

# Approve final gate
swaif gate approve VERIFY

# Deploy to staging
swaif deploy --env=staging

# Output:
# ✓ Docker image built
# ✓ Tests passed in container
# ✓ Deployed to staging environment
# ✓ Health check: PASS
# 
# API available at: https://staging-task-api.swaif.dev
# 
# 🎉 Project complete!
# Total cycle time: 4.2 days (planned: 5 days)
# Quality gates passed: 6/6
# Defects detected: 0
```

---

## Essential Commands Reference

### Project Management
```bash
swaif init <project>          # Create new project
swaif config set <key> <val>  # Configure settings
swaif doctor                  # Run diagnostics
swaif status                  # Show current stage
```

### Stage Operations
```bash
swaif intake create <title>   # Start intake
swaif specify                 # Generate specs
swaif plan                    # Create architecture
swaif tasks generate          # Break into tasks
swaif implement               # Execute tasks
swaif verify                  # Final validation
```

### Gate Management
```bash
swaif gate status <STAGE>     # Check gate status
swaif gate approve <STAGE>    # Approve transition
swaif gate reject <STAGE>     # Reject with reason
swaif gate waiver <STAGE>     # Request exception
```

### Execution Modes
```bash
--mode=copilot               # Fully automated
--mode=human                 # Manual oversight
--mode=challenger            # Adversarial review
```

---

## Troubleshooting

### Issue: "SWAIF command not found"

**Solution:**
```bash
# Add SWAIF to PATH
echo 'export PATH="$HOME/.swaif/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

### Issue: "Gate approval blocked"

**Solution:**
```bash
# Check exit criteria
swaif gate status <STAGE> --verbose

# View blocking issues
swaif gate blockers <STAGE>

# Fix issues, then retry approval
```

### Issue: "AI provider authentication failed"

**Solution:**
```bash
# Reconfigure AI provider
swaif config set ai-provider "github-copilot"

# Re-authenticate
gh auth refresh

# Test connection
swaif ai test
```

### Issue: "Tests failing during implementation"

**Solution:**
```bash
# Run tests manually to debug
cd <project-root>
pytest tests/ -v

# Check implementation logs
swaif logs --task=<TASK-ID>

# Retry with human mode for debugging
swaif implement --task=<TASK-ID> --mode=human
```

### Issue: "Constitutional violation detected"

**Solution:**
```bash
# View violation details
swaif audit --verbose

# Example: Missing traceability link
# Fix: Add requirement ID to commit message
git commit --amend -m "feat: Add endpoint [REQ-001]"

# Re-run verification
swaif verify
```

---

## Next Steps

✅ **You've completed your first SWAIF project!**

### Deepen Your Knowledge

1. **Study the Constitution:** Read [Constitution Guide](CONSTITUTION_GUIDE.md) to understand governance
2. **Master Workflows:** Explore [Workflow Guide](WORKFLOW_GUIDE.md) for advanced techniques
3. **Learn from Examples:** Study [Case Studies](CASE_STUDIES.md) for real-world patterns
4. **Compare Approaches:** Review [Comparison Matrix](COMPARISON_MATRIX.md) for decision frameworks

### Customize SWAIF

```bash
# Edit project constitution
swaif constitution edit

# Add custom quality gates
swaif gate create SECURITY_SCAN --criteria="Zero high/critical CVEs"

# Configure team-specific templates
swaif template create microservice --based-on=rest-service
```

### Get Help

- **Documentation:** https://swaif.dev/docs
- **Community:** https://discuss.swaif.dev
- **Issues:** https://github.com/your-org/swaif/issues

---

**Ready to build production-grade software with engineering discipline.**

_Last Updated: 2024 | SWAIF v1.0.0_
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
