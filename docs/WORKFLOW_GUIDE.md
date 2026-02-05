# SWAIF Workflow Guide

**Daily Operations and Development Patterns**

This guide covers the practical, day-to-day workflows for developers using SWAIF. Learn how to navigate the six stages, use execution modes effectively, and troubleshoot common scenarios.

---

## Developer Daily Workflow

### Morning Routine

```bash
# 1. Sync with team changes
cd ~/projects/my-swaif-project
git pull origin main

# 2. Check current project stage
swaif status

# Output:
# Project: payment-service
# Current Stage: IMPLEMENT
# Active Tasks: 3
# Pending Approvals: 0
# 
# Recent Activity:
# - T-012: Completed (2h ago) by alice
# - T-013: In Progress (you) - 65% complete
# - T-014: Queued

# 3. Review today's assigned tasks
swaif tasks list --assigned-to=me --status=active

# Output:
# [T-013] ⚙ Add rate limiting middleware (4h, 65% complete)
# [T-014] ⏳ Implement token refresh endpoint (3h, queued)
# [T-015] ⏳ Add logging to auth flows (2h, queued)
```

### Working on a Task

```bash
# Start or resume a task
swaif implement --task=T-013 --mode=copilot

# If task requires high-risk changes, use human or challenger mode
swaif implement --task=T-014 --mode=challenger  # Security-critical

# Check task progress
swaif implement status T-013

# Output:
# Task: T-013 - Add rate limiting middleware
# Status: In Progress (65% complete)
# Started: 2024-01-15 09:30
# Estimated Time: 4h
# Actual Time: 2.6h
# 
# Completed Steps:
# ✓ Research rate limiter libraries
# ✓ Write tests for rate limiting
# ⚙ Implement middleware (current)
# ⏳ Integration tests
# ⏳ Documentation update
```

### Completing a Task

```bash
# Mark task as complete (automatic if all tests pass)
swaif implement complete T-013

# Review what was done
git log --oneline -n 5

# Output:
# a3f4b2c feat: Add rate limiting middleware [T-013]
# d8e9f1a test: Rate limiter edge cases [T-013]
# c2b4a6d docs: Update API docs with rate limits [T-013]

# Verify constitutional compliance
swaif audit --task=T-013

# Output:
# Task T-013 Audit:
# ✓ Article I: Commits properly traced to T-013
# ✓ Article III: Tests written before implementation
# ✓ Article IX: Documentation updated
# 
# Status: COMPLIANT
```

### End of Day

```bash
# Push all changes
git push origin main

# Update team on progress
swaif standup generate

# Output (auto-generated standup report):
# Yesterday:
# - Completed T-012: Add JWT validation (on time)
# - Completed T-013: Rate limiting middleware (10% under estimate)
# 
# Today:
# - Working on T-014: Token refresh endpoint (3h estimated)
# - Plan to start T-015: Auth logging (2h estimated)
# 
# Blockers:
# - None
# 
# Metrics:
# - Velocity: 105% of estimate
# - Test coverage: 94%
# - Code review: All approved
```

---

## Stage Transition Workflows

### Stage 1: INTAKE → SPECIFY

**Purpose:** Transform problem statement into detailed requirements.

#### Steps

```bash
# 1. Review intake document
swaif intake show

# Output displays:
# - Problem statement
# - Stakeholders
# - Business value
# - Initial risk assessment
# - Feasibility determination

# 2. Approve INTAKE gate
swaif gate review INTAKE

# Interactive checklist:
# ☑ Problem clearly defined?
# ☑ Stakeholders identified?
# ☑ Feasibility confirmed?
# ☑ Risk level acceptable?
# 
# Approve gate? [y/N]: y

swaif gate approve INTAKE

# 3. Generate specifications
swaif specify --mode=copilot

# This creates:
# - specs/requirements.md (behavioral specs)
# - specs/data-model.yaml (entity definitions)
# - specs/api-contract.yaml (OpenAPI spec)
# - specs/acceptance-criteria.md (test scenarios)

# 4. Review generated specs
less specs/requirements.md

# 5. Refine if needed
swaif specify refine \
  --section="User Authentication" \
  --add-requirement="Support OAuth2 social login"

# 6. Approve SPECIFY gate
swaif gate approve SPECIFY
```

#### SPECIFY Gate Checklist

- [ ] All functional requirements documented
- [ ] Data model defines all entities and relationships
- [ ] API contract specifies all endpoints
- [ ] Acceptance criteria testable and measurable
- [ ] Non-functional requirements specified (performance, security, etc.)
- [ ] Test coverage plan achieves 80%+

---

### Stage 2: SPECIFY → PLAN

**Purpose:** Design system architecture and select technology stack.

#### Steps

```bash
# 1. Generate architecture plan
swaif plan --mode=copilot

# This creates:
# - docs/architecture.md (system design)
# - docs/data-flow.mmd (Mermaid diagrams)
# - docs/tech-stack.md (technology decisions)
# - docs/risks.md (risk register)
# - infrastructure/terraform/ (IaC templates)

# 2. Review architecture decisions
swaif plan review

# Interactive review:
# Technology Stack:
# - Language: Python 3.11
# - Framework: FastAPI
# - Database: PostgreSQL 15
# - Cache: Redis 7
# - Deployment: Kubernetes
# 
# Accept stack? [y/N]: y

# 3. Run design validation
swaif plan validate

# Checks:
# ✓ All requirements addressed in design
# ✓ No circular dependencies
# ✓ Security controls identified
# ✓ Observability plan present
# ✓ Scalability considered
# ✓ Disaster recovery documented

# 4. Generate cost estimate
swaif plan cost-estimate

# Output:
# Infrastructure Cost Estimate:
# - Compute: $450/month (3 pods, 2 CPU each)
# - Database: $120/month (managed PostgreSQL)
# - Cache: $50/month (Redis)
# - Monitoring: $80/month (DataDog)
# - Total: ~$700/month
# 
# Development Cost Estimate:
# - Implementation: 80 hours (10 days)
# - Testing: 24 hours (3 days)
# - Documentation: 8 hours (1 day)
# - Total: 112 hours (~14 days)

# 5. Approve PLAN gate
swaif gate approve PLAN
```

#### PLAN Gate Checklist

- [ ] Architecture diagram shows all components
- [ ] Technology choices justified
- [ ] Data flow documented
- [ ] Security architecture defined
- [ ] Scalability plan present
- [ ] Risks identified and mitigated
- [ ] Cost estimate within budget
- [ ] Design review completed

---

### Stage 3: PLAN → TASKS

**Purpose:** Decompose plan into executable work units.

#### Steps

```bash
# 1. Generate task breakdown
swaif tasks generate

# Uses AI to analyze plan and create tasks
# Output:
# Generated 23 tasks:
# - 12 implementation tasks
# - 6 testing tasks
# - 3 infrastructure tasks
# - 2 documentation tasks
# 
# Total estimate: 112 hours
# Critical path: 48 hours
# Suggested parallelism: 3 developers

# 2. Review task structure
swaif tasks tree

# Output (hierarchical view):
# ├─ [EPIC-01] Authentication System
# │  ├─ [T-001] Setup database schema (2h)
# │  ├─ [T-002] Implement user model (3h)
# │  ├─ [T-003] Add password hashing (2h)
# │  ├─ [T-004] Create login endpoint (4h)
# │  │  ├─ Depends on: T-001, T-002, T-003
# │  └─ [T-005] Add JWT generation (3h)
# │     ├─ Depends on: T-004
# ├─ [EPIC-02] Rate Limiting
# │  ├─ [T-006] Research rate limiter (1h)
# │  └─ [T-007] Implement middleware (3h)

# 3. Adjust estimates if needed
swaif tasks adjust T-004 --estimate=6h --reason="Complex validation logic"

# 4. Assign tasks to team members
swaif tasks assign T-001,T-002,T-003 --to=alice
swaif tasks assign T-004,T-005 --to=bob
swaif tasks assign T-006,T-007 --to=me

# 5. Approve TASKS gate
swaif gate approve TASKS
```

#### TASKS Gate Checklist

- [ ] All plan items broken into tasks
- [ ] Each task < 8 hours
- [ ] Dependencies identified
- [ ] Critical path calculated
- [ ] Tasks assigned to team members
- [ ] Total estimate reviewed by team
- [ ] Risk tasks flagged for human/challenger mode

---

### Stage 4: TASKS → IMPLEMENT

**Purpose:** Write code, tests, and documentation.

#### Copilot Mode (Low Risk Tasks)

```bash
# Fully automated execution
swaif implement --task=T-001 --mode=copilot

# Behind the scenes:
# 1. Reads task requirements
# 2. Generates test cases first
# 3. Implements functionality
# 4. Runs tests and verifies
# 5. Commits with proper traceability
# 6. Pushes to main branch

# Monitor progress:
swaif implement tail T-001

# Real-time output:
# [T-001] 10% Analyzing requirements...
# [T-001] 25% Writing test cases...
# [T-001] 45% Implementing database schema...
# [T-001] 75% Running tests...
# [T-001] 90% Updating documentation...
# [T-001] 100% Complete ✓
```

#### Human Mode (Medium Risk Tasks)

```bash
# Semi-automated with human review checkpoints
swaif implement --task=T-004 --mode=human

# Process:
# 1. AI generates implementation plan
# 2. Human reviews and approves
# 3. AI writes tests
# 4. Human reviews tests
# 5. AI implements code
# 6. Human reviews code before commit

# Interactive prompt:
# Generated Implementation Plan:
# 
# 1. Create LoginRequest schema with validation
# 2. Implement password verification logic
# 3. Generate JWT on successful auth
# 4. Return token in response
# 5. Handle invalid credentials with 401
# 
# Approve plan? [y/n/edit]: y
# 
# Writing tests...
# ✓ test_login_success
# ✓ test_login_invalid_password
# ✓ test_login_user_not_found
# ✓ test_login_rate_limited
# 
# Review tests? [y/n]: y
# (opens editor with tests)
# 
# Tests approved. Implementing...
# 
# Implementation complete. Review changes:
# (opens diff viewer)
# 
# Approve commit? [y/n]: y
```

#### Challenger Mode (High Risk Tasks)

```bash
# Adversarial review for security-critical code
swaif implement --task=T-005 --mode=challenger

# Process:
# 1. Proposer AI creates implementation
# 2. Challenger AI attacks the design
# 3. Proposer defends or revises
# 4. Human arbitrates
# 5. Approved implementation committed

# Interactive session:
# [PROPOSER] Implementing JWT generation...
# 
# Proposed Implementation:
# ```python
# def generate_token(user_id: str) -> str:
#     payload = {'user_id': user_id, 'exp': datetime.utcnow() + timedelta(hours=1)}
#     return jwt.encode(payload, SECRET_KEY, algorithm='HS256')
# ```
# 
# [CHALLENGER] Security issues found:
# 1. No token rotation - same secret indefinitely
# 2. Missing 'iat' claim - can't detect old tokens
# 3. 1 hour expiry too long for sensitive app
# 4. No refresh token mechanism
# 5. HS256 symmetric - server must store secret
# 
# [PROPOSER] Revised implementation:
# ```python
# def generate_tokens(user_id: str) -> TokenPair:
#     now = datetime.utcnow()
#     access_payload = {
#         'user_id': user_id,
#         'iat': now,
#         'exp': now + timedelta(minutes=15),
#         'type': 'access'
#     }
#     refresh_payload = {
#         'user_id': user_id,
#         'iat': now,
#         'exp': now + timedelta(days=7),
#         'type': 'refresh',
#         'jti': str(uuid.uuid4())  # Unique ID for revocation
#     }
#     access_token = jwt.encode(access_payload, PRIVATE_KEY, algorithm='RS256')
#     refresh_token = jwt.encode(refresh_payload, PRIVATE_KEY, algorithm='RS256')
#     return TokenPair(access=access_token, refresh=refresh_token)
# ```
# 
# [CHALLENGER] Improvements accepted. Minor issue:
# - Should store refresh token JTI in database for revocation
# 
# [HUMAN REVIEW]
# Challenger's points are valid. 
# Implementation: APPROVED with note to add revocation list.
# 
# Committing implementation...
```

---

### Stage 5: IMPLEMENT → VERIFY

**Purpose:** Integration testing and deployment.

#### Steps

```bash
# 1. Run comprehensive verification
swaif verify

# Output:
# Running Verification Suite...
# 
# Constitutional Audit:
# ✓ Article I: Traceability (47/47 commits linked)
# ✓ Article II: Stage Gates (all approved)
# ✓ Article III: Test-First (96% coverage)
# ✓ Article IV: Challenger Review (3/3 high-risk tasks)
# ✓ Article V: Simplicity (avg complexity: 6.2)
# ✓ Article VI: Integration (0 stale branches)
# ✓ Article VII: Observability (all endpoints instrumented)
# ✓ Article VIII: Security (no critical CVEs)
# ✓ Article IX: Documentation (sync verified)
# 
# Integration Tests:
# ✓ API endpoints (23/23 passed)
# ✓ Database migrations (5/5 passed)
# ✓ Authentication flows (8/8 passed)
# ✓ Rate limiting (4/4 passed)
# 
# Performance Tests:
# ✓ Response time p95: 145ms (target: <200ms)
# ✓ Throughput: 1,240 req/s (target: >1,000)
# ✓ Error rate: 0.02% (target: <0.1%)
# 
# Security Scan:
# ✓ No critical vulnerabilities
# ⚠ 2 medium severity (acceptable)
# ✓ Secrets detection passed
# ✓ OWASP Top 10 mitigations present
# 
# Deployment Readiness:
# ✓ Docker image builds successfully
# ✓ Health endpoints responsive
# ✓ Database migrations tested
# ✓ Environment configs validated
# 
# Overall Status: READY FOR DEPLOYMENT

# 2. Generate deployment package
swaif verify package

# Creates:
# - dist/app-v1.2.0.tar.gz (application bundle)
# - dist/deployment-manifest.yaml (K8s config)
# - dist/runbook.md (operations guide)
# - dist/rollback-plan.md (disaster recovery)

# 3. Deploy to staging
swaif deploy --env=staging --dry-run

# Shows what will happen:
# Deployment Plan (Dry Run):
# 
# 1. Build Docker image: payment-service:v1.2.0
# 2. Push to registry: gcr.io/company/payment-service:v1.2.0
# 3. Apply database migrations (5 new migrations)
# 4. Update K8s deployment (3 replicas)
# 5. Run smoke tests
# 6. Monitor for 5 minutes
# 7. Mark deployment successful or rollback
# 
# Estimated time: 8 minutes

# Approve and deploy
swaif deploy --env=staging

# Live progress:
# ⚙ Building image... [1/7]
# ✓ Image built: payment-service:v1.2.0
# ⚙ Pushing to registry... [2/7]
# ✓ Image pushed
# ⚙ Running migrations... [3/7]
# ✓ 5 migrations applied
# ⚙ Updating deployment... [4/7]
# ✓ Rollout complete: 3/3 pods healthy
# ⚙ Running smoke tests... [5/7]
# ✓ All smoke tests passed
# ⚙ Monitoring... [6/7]
# ✓ No errors detected (5min observation)
# ✓ Deployment successful [7/7]
# 
# Staging Environment:
# URL: https://staging-payment.company.com
# Health: https://staging-payment.company.com/health
# Metrics: https://grafana.company.com/d/payment-service

# 4. Run acceptance tests in staging
swaif verify acceptance --env=staging

# Runs tests from specs/acceptance-criteria.md
# Output:
# Acceptance Tests (Staging):
# 
# ✓ User can login with valid credentials
# ✓ Invalid password returns 401
# ✓ Rate limiting blocks after 5 attempts
# ✓ JWT expires after 15 minutes
# ✓ Refresh token extends session
# ✓ Revoked tokens cannot be used
# 
# All acceptance criteria met: 6/6

# 5. Get stakeholder approval
swaif gate approve VERIFY --stakeholder="product-owner@company.com"

# Sends notification with:
# - Staging environment URL
# - Test results summary
# - Deployment metrics
# - Sign-off request

# 6. Deploy to production (after approval)
swaif deploy --env=production

# Uses same process as staging with added safeguards:
# - Blue/green deployment
# - Canary rollout (10% → 50% → 100%)
# - Automatic rollback on error spike
```

#### VERIFY Gate Checklist

- [ ] All constitutional articles compliant
- [ ] Integration tests pass in staging
- [ ] Performance benchmarks met
- [ ] Security scan clean (no critical/high)
- [ ] Acceptance criteria verified by stakeholders
- [ ] Runbook and rollback plan documented
- [ ] Production deployment approved

---

## Command Reference

### Project Commands

```bash
# Initialize new project
swaif init <project-name> --template=<template> --lang=<language>

# Check project status
swaif status

# Run diagnostics
swaif doctor

# View project metrics
swaif metrics

# Generate reports
swaif report --type=velocity|quality|compliance
```

### Stage Commands

```bash
# Move between stages
swaif intake create "<title>"
swaif specify [--mode=copilot|human]
swaif plan [--mode=copilot|human]
swaif tasks generate
swaif implement [--task=<id>] [--mode=copilot|human|challenger]
swaif verify

# View stage status
swaif stage show <INTAKE|SPECIFY|PLAN|TASKS|IMPLEMENT|VERIFY>
```

### Gate Commands

```bash
# Review gate status
swaif gate status <STAGE>

# Approve gate transition
swaif gate approve <STAGE> [--reviewer=<email>]

# Reject gate with reason
swaif gate reject <STAGE> --reason="<explanation>"

# Request waiver for exceptional cases
swaif gate waiver <STAGE> \
  --reason="<justification>" \
  --approver="<email>" \
  --compensating-control="<mitigation>"

# View gate history
swaif gate history
```

### Task Commands

```bash
# List tasks
swaif tasks list [--status=active|queued|complete]

# Show task tree
swaif tasks tree

# View task details
swaif tasks show <task-id>

# Assign tasks
swaif tasks assign <task-id> --to=<username>

# Adjust estimates
swaif tasks adjust <task-id> --estimate=<hours>

# Mark task blocked
swaif tasks block <task-id> --reason="<blocker>"
```

### Implementation Commands

```bash
# Execute single task
swaif implement --task=<id> --mode=<copilot|human|challenger>

# Execute all queued tasks
swaif implement --all [--parallel=<n>]

# Monitor implementation progress
swaif implement status [<task-id>]

# View real-time logs
swaif implement tail <task-id>

# Pause/resume execution
swaif implement pause <task-id>
swaif implement resume <task-id>
```

### Verification Commands

```bash
# Run full verification suite
swaif verify

# Run specific checks
swaif audit [--strict]
swaif audit security
swaif audit constitutional

# Package for deployment
swaif verify package

# Run acceptance tests
swaif verify acceptance --env=<staging|production>
```

### Deployment Commands

```bash
# Dry run deployment
swaif deploy --env=<env> --dry-run

# Deploy to environment
swaif deploy --env=<staging|production>

# View deployment status
swaif deploy status

# Rollback deployment
swaif deploy rollback --to=<version>
```

---

## Common Troubleshooting Scenarios

### Scenario 1: Gate Approval Blocked

**Symptom:**
```bash
swaif gate approve SPECIFY

# ERROR: Cannot approve gate
# Blocking issues:
# - Missing data model specification
# - Test coverage plan incomplete (45% planned, 80% required)
```

**Solution:**
```bash
# View detailed blockers
swaif gate blockers SPECIFY

# Output:
# Blocking Issues:
# 
# 1. Missing Artifact: data-model.yaml
#    Location: specs/data-model.yaml
#    Required by: Article II (Stage Gate Discipline)
#    Fix: Run `swaif specify --section=data-model`
# 
# 2. Insufficient Test Coverage Plan
#    Current: 45% (9/20 test cases)
#    Required: 80% (16/20 test cases)
#    Fix: Add test scenarios to specs/acceptance-criteria.md

# Fix issue #1
swaif specify --section=data-model

# Fix issue #2 (edit file)
vim specs/acceptance-criteria.md
# Add 7 more test scenarios

# Retry approval
swaif gate approve SPECIFY
# ✓ Gate approved
```

### Scenario 2: Implementation Failing Tests

**Symptom:**
```bash
swaif implement --task=T-008 --mode=copilot

# ERROR: Tests failing after implementation
# 3 of 12 tests failed:
# - test_login_rate_limiting
# - test_token_expiry
# - test_refresh_token_revocation
```

**Solution:**
```bash
# View test failures
swaif implement errors T-008

# Output shows stack traces and failure reasons

# Option 1: Retry with human mode for debugging
swaif implement --task=T-008 --mode=human --retry

# Option 2: View implementation logs
swaif logs --task=T-008 --verbose

# Option 3: Run tests locally
pytest tests/test_auth.py -v -k "rate_limiting or expiry or revocation"

# After fixing code:
swaif implement complete T-008
```

### Scenario 3: Constitutional Violation Detected

**Symptom:**
```bash
git push origin main

# CI Pipeline Failed:
# ✗ Constitutional Audit Failed
# Violations:
# - Article I: Commit a3f4b2c missing requirement traceability
# - Article III: New code in src/auth.py has 0% test coverage
```

**Solution:**
```bash
# Fix traceability violation
git log --oneline -n 1
# a3f4b2c Added login function

git commit --amend -m "feat: Add login function [T-008]"

# Fix test coverage violation
# Write missing tests
cat > tests/test_auth_login.py <<EOF
def test_login_success():
    response = client.post('/login', json={'username': 'alice', 'password': 'pass'})
    assert response.status_code == 200
    assert 'access_token' in response.json()
EOF

git add tests/test_auth_login.py
git commit -m "test: Add login function tests [T-008]"

# Re-run audit
swaif audit
# ✓ All articles compliant

# Push again
git push origin main
```

### Scenario 4: Dependency Conflicts

**Symptom:**
```bash
swaif implement --task=T-015

# ERROR: Dependency conflict detected
# Task T-015 depends on T-014 (not yet complete)
# Cannot start T-015 until T-014 finishes
```

**Solution:**
```bash
# View dependency graph
swaif tasks dependencies T-015

# Output:
# T-015: Add logging to auth flows
# Depends on:
#   ├─ T-014: Implement token refresh (IN PROGRESS, 75% complete)
#   └─ T-010: Setup logging infrastructure (COMPLETE)
# 
# Blocking: T-014
# Estimated wait: 30 minutes

# Option 1: Wait for T-014
swaif implement wait T-015

# Option 2: Work on different task
swaif tasks list --status=queued --no-blockers
# [T-016] Add API documentation (2h, no dependencies)

swaif implement --task=T-016

# Option 3: Remove dependency if not critical
swaif tasks dependency remove T-015 T-014 \
  --reason="Can implement logging independently"
```

### Scenario 5: Performance Degradation After Deployment

**Symptom:**
```bash
# Deployed to production
# Monitoring alerts: Response time p95 increased from 100ms to 800ms
```

**Solution:**
```bash
# Check deployment status
swaif deploy status

# Output:
# Deployment: payment-service v1.2.0
# Environment: production
# Status: DEPLOYED (15 minutes ago)
# Health: 3/3 pods healthy
# ⚠ Performance degradation detected:
#   - p95 latency: 800ms (baseline: 100ms)
#   - Error rate: 0.01% (baseline: 0.01%)

# View metrics
swaif metrics --env=production --window=30m

# Automatic rollback trigger
swaif deploy rollback --reason="Performance degradation"

# Output:
# Rolling back to v1.1.5...
# ✓ Rollback complete
# ✓ Latency restored: p95 = 105ms
# 
# Incident created: INC-2024-045
# Runbook: Review database query performance in v1.2.0
```

### Scenario 6: Merge Conflicts

**Symptom:**
```bash
git pull origin main

# CONFLICT (content): Merge conflict in src/auth.py
# Automatic merge failed; fix conflicts and then commit the result.
```

**Solution:**
```bash
# SWAIF enforces integration-first, so this should be rare
# But if it happens:

# View conflict
git diff src/auth.py

# SWAIF can help resolve
swaif resolve-conflict src/auth.py

# Output:
# Analyzing conflict...
# 
# Your changes: Added rate limiting decorator
# Main branch changes: Refactored function signature
# 
# Recommended resolution:
# ```python
# @rate_limit(calls=5, period=60)
# def authenticate_user(credentials: Credentials) -> TokenPair:  # New signature
#     # Your implementation
# ```
# 
# Apply recommendation? [y/n]: y

# Verify resolution
git status
# On branch main
# All conflicts fixed but you are still merging.

git commit -m "chore: Resolve merge conflict in auth.py"
git push origin main
```

---

## Best Practices

### 1. Task Sizing

**Good:** Tasks under 4 hours
```bash
# Well-sized tasks
[T-001] Create User model (2h)
[T-002] Add password hashing (1.5h)
[T-003] Write authentication endpoint (3h)
```

**Bad:** Tasks over 8 hours
```bash
# Too large - should be broken down
[T-001] Implement entire authentication system (40h)
```

**Fix:**
```bash
swaif tasks split T-001 \
  --into="Setup database, Implement models, Add endpoints, Write tests, Documentation"
```

### 2. Execution Mode Selection

**Use Copilot Mode When:**
- Task is < 4 hours
- Following established patterns
- Non-critical path
- Low security risk
- Well-defined requirements

**Use Human Mode When:**
- Task is novel or exploratory
- Requires design decisions
- Moderate risk
- Cross-cutting changes
- Performance-critical

**Use Challenger Mode When:**
- Security-critical (auth, payments)
- Data deletion/migration
- Breaking API changes
- Cryptography
- Compliance-sensitive

### 3. Commit Hygiene

**Good Commits:**
```bash
# Atomic, traceable, descriptive
git commit -m "feat: Add JWT refresh endpoint [T-014]"
git commit -m "test: Add rate limiting test cases [T-013]"
git commit -m "docs: Update API spec with auth endpoints [T-014]"
```

**Bad Commits:**
```bash
# Too vague, no traceability
git commit -m "Fixed stuff"
git commit -m "WIP"
git commit -m "Updates"
```

### 4. Branch Strategy

SWAIF enforces **integration-first**, so branches should be:
- Short-lived (< 24 hours)
- Focused on single task
- Merged frequently
- Always deployable on main

```bash
# Good pattern
git checkout -b task/T-014-token-refresh
# Work for 2-3 hours
git commit -m "feat: Token refresh endpoint [T-014]"
git push origin task/T-014-token-refresh
gh pr create --title "Token refresh endpoint [T-014]"
# Merge same day after CI passes

# Bad pattern
git checkout -b feature/authentication-system
# Work for 5 days
# 47 commits
# Main branch diverged significantly
# Merge conflict nightmare
```

---

## Summary

SWAIF workflows emphasize:
- **Systematic progression** through stages
- **Quality gates** at each transition
- **Automated execution** for routine tasks
- **Human oversight** for critical decisions
- **Continuous integration** to main branch
- **Traceability** for all changes

Master these workflows to maximize SWAIF's effectiveness.

**Next:** Study real-world examples in [Case Studies](CASE_STUDIES.md).

---

_Last Updated: 2024 | SWAIF v1.0.0_
