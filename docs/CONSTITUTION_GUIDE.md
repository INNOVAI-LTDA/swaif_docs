# SWAIF Constitution Guide

**The Nine Immutable Articles of Software Engineering Discipline**

A SWAIF constitution is a governance framework that enforces quality standards through automated and manual checks. Unlike traditional style guides or best practices documents, constitutional articles are **legally binding** within the project—violations block deployments, fail builds, and require formal waivers.

---

## Philosophy: Why Constitutions Matter

Software engineering suffers from "tragedy of the commons":
- **Short-term pressures** encourage shortcuts
- **Technical debt** compounds silently
- **Quality standards** drift over time
- **Tribal knowledge** remains undocumented

A constitution transforms implicit expectations into explicit, enforceable rules.

---

## The Nine Articles

### Article I: Requirements Traceability

**Principle:** Every code change must trace to a documented requirement or design decision.

#### What This Means

- **Commits** must reference requirement IDs in commit messages
- **Pull requests** must link to specification documents
- **Code comments** must cite design rationale for non-obvious logic
- **Orphaned code** (no traceability) cannot be merged

#### Enforcement Mechanism

```yaml
# .swaif/constitution.yaml
article_i:
  enabled: true
  enforcement: pre-commit
  rules:
    - commit_message_format: '\[REQ-\d+\]|\[TASK-\d+\]'
    - require_pr_link: true
    - orphan_detection: true
  exceptions:
    - pattern: 'chore:.*'  # Maintenance tasks
    - pattern: 'docs:.*'   # Documentation updates
```

#### Practical Examples

**❌ Violation:**
```bash
git commit -m "Fixed the bug"
# ERROR: No requirement traceability
```

**✅ Compliant:**
```bash
git commit -m "fix: Resolve null pointer in UserService [REQ-042]"
# Links to requirement REQ-042 in specs/requirements.md
```

**❌ Violation:**
```python
# Code comment with no justification
def calculate_score(value):
    return value * 1.5 + 42  # Magic numbers
```

**✅ Compliant:**
```python
# Scoring algorithm per SPEC-019 Section 4.2
# Base multiplier: 1.5 (engagement weight)
# Offset: 42 (normalization constant from A/B test #156)
def calculate_score(value):
    ENGAGEMENT_WEIGHT = 1.5
    NORMALIZATION_OFFSET = 42
    return value * ENGAGEMENT_WEIGHT + NORMALIZATION_OFFSET
```

#### Benefits

- **Audit trails** for compliance requirements (SOC2, ISO 27001)
- **Onboarding speed** (new developers understand "why")
- **Safe refactoring** (know the purpose before changing)
- **Scope control** (detect feature creep early)

---

### Article II: Stage Gate Discipline

**Principle:** Projects progress through defined stages. No stage may be skipped without formal waiver.

#### The Six Stages

1. **INTAKE** - Problem definition and feasibility
2. **SPECIFY** - Requirements and acceptance criteria
3. **PLAN** - Architecture and design
4. **TASKS** - Work breakdown and estimation
5. **IMPLEMENT** - Coding and testing
6. **VERIFY** - Integration and deployment

#### Gate Requirements

Each stage has **entry criteria** and **exit criteria**:

| Stage | Entry Criteria | Exit Criteria |
|-------|----------------|---------------|
| **INTAKE** | Problem statement submitted | Stakeholder approval, risk assessed |
| **SPECIFY** | INTAKE gate passed | Specifications complete, test plan exists |
| **PLAN** | SPECIFY gate passed | Architecture reviewed, tech stack chosen |
| **TASKS** | PLAN gate passed | All tasks estimated, dependencies mapped |
| **IMPLEMENT** | TASKS gate passed | All tests pass, code reviewed |
| **VERIFY** | IMPLEMENT gate passed | Constitutional audit clean, deployed |

#### Enforcement Mechanism

```yaml
article_ii:
  enabled: true
  enforcement: cli
  rules:
    - no_stage_skip: true
    - require_gate_approval: true
    - approval_authority:
        INTAKE: product-owner
        SPECIFY: tech-lead
        PLAN: architect
        TASKS: team
        IMPLEMENT: code-reviewer
        VERIFY: stakeholder
  exceptions:
    - waiver_process: true  # Allow formal exceptions
    - waiver_requires: [justification, risk-assessment, compensating-controls]
```

#### Practical Examples

**❌ Violation:**
```bash
# Try to skip straight to implementation
swaif implement --task=T-001

# ERROR: Cannot implement without approved TASKS gate
# Current stage: SPECIFY
# Required: Approve SPECIFY → PLAN → TASKS gates first
```

**✅ Compliant:**
```bash
# Proper progression
swaif gate approve SPECIFY
swaif plan --mode=copilot
swaif gate approve PLAN
swaif tasks generate
swaif gate approve TASKS
swaif implement --task=T-001  # Now allowed
```

**Waiver Process (Emergency Hotfix):**
```bash
# Production outage requires skipping PLAN stage
swaif gate waiver PLAN \
  --reason="P1 incident: payment processing down" \
  --approver="cto@company.com" \
  --compensating-control="Post-incident arch review within 48h"

# Waiver granted with conditions
# Can now proceed: SPECIFY → TASKS → IMPLEMENT
```

#### Benefits

- **Reduced rework** (catch design flaws before coding)
- **Predictable timelines** (no surprise late-stage changes)
- **Quality assurance** (systematic verification at each step)
- **Risk management** (formal checkpoints for high-stakes decisions)

---

### Article III: Test-First Development

**Principle:** Tests must be written before implementation code. No production code without corresponding tests.

#### What This Means

- **Unit tests** written before functions
- **Integration tests** written before endpoints
- **Acceptance tests** derived from specifications
- **Coverage thresholds** enforced at build time

#### Enforcement Mechanism

```yaml
article_iii:
  enabled: true
  enforcement: pre-commit, ci-pipeline
  rules:
    - test_before_code: true
    - min_coverage: 80%
    - coverage_targets:
        unit: 90%
        integration: 75%
        e2e: 60%
    - require_negative_tests: true  # Test failure cases
  exceptions:
    - excluded_paths:
        - 'scripts/one-time-migration.py'
        - 'docs/'
```

#### Practical Examples

**❌ Violation:**
```python
# Implementation without tests
def process_payment(amount, currency):
    if currency not in SUPPORTED_CURRENCIES:
        raise ValueError("Unsupported currency")
    return external_api.charge(amount, currency)
```

**✅ Compliant:**
```python
# tests/test_payment.py (written FIRST)
def test_process_payment_success():
    result = process_payment(100.00, 'USD')
    assert result.status == 'charged'
    assert result.amount == 100.00

def test_process_payment_invalid_currency():
    with pytest.raises(ValueError, match="Unsupported"):
        process_payment(100.00, 'INVALID')

def test_process_payment_api_timeout():
    with mock.patch('external_api.charge', side_effect=Timeout):
        with pytest.raises(PaymentError):
            process_payment(100.00, 'USD')

# THEN implement:
def process_payment(amount, currency):
    if currency not in SUPPORTED_CURRENCIES:
        raise ValueError("Unsupported currency")
    try:
        return external_api.charge(amount, currency)
    except Timeout:
        raise PaymentError("Payment service unavailable")
```

**CI Pipeline Check:**
```bash
# Run coverage check
pytest --cov=src --cov-report=term --cov-fail-under=80

# Output if failing:
# FAILED: Coverage 73% is below minimum 80%
# Missing coverage:
#   src/payment.py: 45%
#   src/auth.py: 62%
```

#### Benefits

- **Design feedback** (tests reveal API usability issues)
- **Regression protection** (changes can't break existing behavior)
- **Documentation** (tests show usage examples)
- **Refactoring confidence** (safe to change internals)

---

### Article IV: Challenger Mode Review

**Principle:** High-risk changes require adversarial review where a second AI agent attacks the proposed design.

#### When Challenger Mode Applies

**Mandatory for:**
- Security-critical code (authentication, authorization, encryption)
- Payment processing logic
- Data deletion or migration operations
- Breaking API changes
- Novel algorithms without established patterns

**Optional for:**
- Complex state machines
- Performance-critical paths
- Cross-service integrations

#### The Challenger Process

1. **Proposer Agent** creates implementation
2. **Challenger Agent** attempts to find flaws:
   - Security vulnerabilities
   - Edge cases not covered
   - Performance bottlenecks
   - Architectural inconsistencies
3. **Human Arbitrator** reviews debate and decides

#### Enforcement Mechanism

```yaml
article_iv:
  enabled: true
  enforcement: manual
  rules:
    - risk_threshold: high
    - mandatory_paths:
        - 'src/auth/**'
        - 'src/payment/**'
        - 'src/security/**'
    - challenger_model: 'gpt-4'
    - require_human_arbitration: true
```

#### Practical Example

**Scenario:** Implementing JWT token refresh endpoint

**Proposer Agent Output:**
```python
@app.post("/auth/refresh")
def refresh_token(refresh_token: str):
    """Exchange refresh token for new access token"""
    payload = jwt.decode(refresh_token, SECRET_KEY)
    user = get_user(payload['user_id'])
    new_access_token = create_access_token(user)
    return {"access_token": new_access_token}
```

**Challenger Agent Attack:**
```
SECURITY ISSUES IDENTIFIED:

1. NO SIGNATURE VERIFICATION
   - jwt.decode() is missing algorithms parameter
   - Vulnerable to algorithm confusion attack (CVE-2015-9235)
   - Attacker can sign with HS256 using public key

2. NO TOKEN REVOCATION CHECK
   - Refresh token could be compromised/stolen
   - No check against revocation list
   - Leaked token remains valid until expiry

3. NO RATE LIMITING
   - Attacker can brute-force refresh tokens
   - No throttling on failed attempts
   - Enables credential stuffing attack

4. MISSING AUDIT LOGGING
   - Token refresh events not logged
   - No forensic trail for compromised accounts
   - Violates Article VII (Observability)

RECOMMENDATIONS:
- Add explicit algorithm whitelist: algorithms=['RS256']
- Implement Redis-backed revocation list
- Add rate limiter: @limiter.limit("5 per minute")
- Log all refresh attempts with IP, user_id, timestamp
```

**Human Arbitrator Decision:**
```
RULING: Implementation REJECTED

Challenger identified critical vulnerabilities. 
Required changes before approval:
1. Fix algorithm confusion (HIGH severity)
2. Add revocation check (HIGH severity)
3. Add rate limiting (MEDIUM severity)
4. Add audit logs (LOW severity - nice to have)

Resubmit after fixes implemented.
```

**Revised Implementation:**
```python
@app.post("/auth/refresh")
@limiter.limit("5 per minute")
def refresh_token(refresh_token: str):
    """Exchange refresh token for new access token"""
    
    # Fix: Explicit algorithm whitelist
    try:
        payload = jwt.decode(
            refresh_token, 
            PUBLIC_KEY, 
            algorithms=['RS256']
        )
    except jwt.InvalidTokenError as e:
        logger.warning(f"Invalid refresh token: {e}")
        raise HTTPException(401, "Invalid token")
    
    # Fix: Check revocation list
    if redis.sismember('revoked_tokens', refresh_token):
        logger.warning(f"Revoked token used: {payload['user_id']}")
        raise HTTPException(401, "Token revoked")
    
    user = get_user(payload['user_id'])
    new_access_token = create_access_token(user)
    
    # Fix: Audit logging
    logger.info(
        "Token refreshed",
        extra={
            'user_id': user.id,
            'ip': request.client.host,
            'timestamp': datetime.utcnow()
        }
    )
    
    return {"access_token": new_access_token}
```

#### Benefits

- **Security hardening** (adversarial testing finds vulnerabilities)
- **Edge case coverage** (attacks surface unexpected scenarios)
- **Knowledge transfer** (review process teaches best practices)
- **Compliance evidence** (formal review trail for audits)

---

### Article V: Simplicity Mandate

**Principle:** Complexity requires written justification. Prefer boring, proven solutions.

#### What This Means

- **New dependencies** must justify their inclusion
- **Custom implementations** must explain why standard libraries insufficient
- **Complex algorithms** must document simpler alternatives considered
- **Architectural patterns** must defend against simpler approaches

#### Enforcement Mechanism

```yaml
article_v:
  enabled: true
  enforcement: code-review
  rules:
    - max_cyclomatic_complexity: 10
    - max_function_length: 50
    - require_dependency_justification: true
    - prefer_stdlib: true
  exceptions:
    - allowed_complexity:
        'src/algorithms/route_optimizer.py': 25  # Inherently complex domain
```

#### Practical Examples

**❌ Violation:**
```python
# Adding heavyweight dependency without justification
# requirements.txt
pandas==2.1.0  # Just to read a CSV file

# src/loader.py
import pandas as pd

def load_users():
    df = pd.read_csv('users.csv')
    return df.to_dict('records')
```

**✅ Compliant:**
```python
# Use standard library
import csv

def load_users():
    """Load users from CSV using stdlib csv module.
    
    Considered pandas but rejected because:
    - Only need simple CSV parsing (no complex transformations)
    - Pandas adds 15MB to deployment package
    - CSV module sufficient for current needs
    
    If we later need pivot tables or complex analytics,
    revisit pandas adoption (see ADR-007).
    """
    with open('users.csv') as f:
        return list(csv.DictReader(f))
```

**❌ Violation:**
```python
# Over-engineered factory pattern
class UserFactory:
    def create(self, user_type):
        if user_type == 'admin':
            return self._create_admin()
        elif user_type == 'regular':
            return self._create_regular()
    
    def _create_admin(self):
        user = User()
        user.permissions = AdminPermissions()
        return user
    
    def _create_regular(self):
        user = User()
        user.permissions = RegularPermissions()
        return user

# Only two user types, factory is overkill
```

**✅ Compliant:**
```python
# Simple dataclass with clear types
from dataclasses import dataclass

@dataclass
class User:
    username: str
    is_admin: bool
    
    @property
    def permissions(self):
        """Return permissions based on admin flag.
        
        Considered factory pattern but rejected:
        - Only 2 user types (admin/regular)
        - No complex initialization logic
        - Clear that user.is_admin drives behavior
        
        If user types exceed 3 or initialization 
        becomes complex, revisit factory pattern (ADR-012).
        """
        return AdminPermissions() if self.is_admin else RegularPermissions()
```

#### Complexity Metrics

```bash
# Check cyclomatic complexity
radon cc src/ -a

# Output:
# src/auth.py
#   L:45 authenticate_user - A (3)  # Simple, good
#   L:78 validate_token - B (7)     # Acceptable
#   L:120 complex_parser - D (15)   # Too complex!
# 
# ERROR: Function exceeds complexity limit (10)
# Requires justification comment or refactoring
```

#### Benefits

- **Maintainability** (simple code is easier to understand)
- **Onboarding** (new developers ramp up faster)
- **Debugging** (fewer places for bugs to hide)
- **Performance** (simple code often faster)

---

### Article VI: Integration-First Development

**Principle:** Integrate changes to main branch daily. No long-lived feature branches.

#### What This Means

- **Daily commits** to main branch (or short-lived branch merged within 24h)
- **Feature flags** for incomplete features
- **Backward compatibility** maintained during changes
- **CI pipeline** runs on every commit

#### Enforcement Mechanism

```yaml
article_vi:
  enabled: true
  enforcement: git-hooks, ci
  rules:
    - max_branch_age: 24h
    - require_ci_pass: true
    - feature_flag_incomplete: true
    - no_breaking_changes: true
  exceptions:
    - allowed_long_branches:
        - 'release/*'
        - 'hotfix/*'
```

#### Practical Examples

**❌ Violation:**
```bash
# Feature branch open for 5 days
git checkout -b feature/new-dashboard
# ... 5 days of commits ...
# Branch diverged 47 commits from main
# Integration nightmare when merging
```

**✅ Compliant:**
```bash
# Day 1: Scaffold with feature flag
git checkout -b feature/dashboard-scaffold
# Implement basic structure, hide behind flag
git commit -m "feat: Dashboard scaffold [REQ-089] (behind FF_NEW_DASHBOARD)"
git push && gh pr create --title "Dashboard scaffold" --fill
# Merge same day after CI passes

# Day 2: Add first component
git checkout -b feature/dashboard-widget-1
# Implement one widget, still behind flag
git commit -m "feat: Add user stats widget [REQ-089]"
# Merge within 24h

# Day 5: Enable for beta users
git checkout -b feature/dashboard-beta-rollout
# Update feature flag config
git commit -m "feat: Enable dashboard for beta cohort [REQ-089]"
# Merge and monitor metrics
```

**Feature Flag Implementation:**
```python
from feature_flags import is_enabled

def dashboard_view(request):
    if is_enabled('new_dashboard', user=request.user):
        return render_new_dashboard(request)
    else:
        return render_old_dashboard(request)  # Existing code unchanged
```

**Backward Compatibility:**
```python
# Adding new optional parameter
def create_user(username: str, email: str, phone: str = None):
    """Create user with optional phone number.
    
    Phone added in v1.2 but remains optional to maintain
    backward compatibility with existing callers.
    """
    user = User(username=username, email=email)
    if phone:
        user.phone = phone
    return user
```

#### CI Pipeline

```yaml
# .github/workflows/ci.yml
name: Continuous Integration
on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Run tests
        run: pytest tests/
      - name: Check coverage
        run: pytest --cov=src --cov-fail-under=80
      - name: Lint code
        run: ruff check src/
      - name: Type check
        run: mypy src/
      - name: Constitutional audit
        run: swaif audit --strict
```

#### Benefits

- **Merge conflicts minimized** (small, frequent integrations)
- **Fast feedback** (issues detected within hours, not weeks)
- **Continuous deployment** (always releasable main branch)
- **Team synchronization** (everyone sees latest changes)

---

### Article VII: Observability Mandate

**Principle:** All services emit structured logs, metrics, and traces. No blind deployments.

#### What This Means

- **Structured logging** (JSON format, not plain text)
- **Health endpoints** (`/health`, `/ready`)
- **Metrics exposure** (Prometheus, StatsD)
- **Distributed tracing** (OpenTelemetry)

#### Enforcement Mechanism

```yaml
article_vii:
  enabled: true
  enforcement: deployment
  rules:
    - require_health_endpoint: true
    - require_structured_logs: true
    - require_metrics: true
    - log_format: json
  exceptions:
    - excluded_services:
        - 'cli-tools'  # Non-daemon services
```

#### Practical Examples

**❌ Violation:**
```python
# Unstructured logging
def process_order(order_id):
    print(f"Processing order {order_id}")
    result = payment.charge(order_id)
    print(f"Result: {result}")
    return result
```

**✅ Compliant:**
```python
import structlog

logger = structlog.get_logger()

def process_order(order_id):
    """Process order with full observability."""
    logger.info(
        "order_processing_started",
        order_id=order_id,
        user_id=current_user.id,
        amount=order.total
    )
    
    try:
        result = payment.charge(order_id)
        logger.info(
            "order_processing_completed",
            order_id=order_id,
            transaction_id=result.id,
            duration_ms=result.duration
        )
        
        # Emit metric
        metrics.increment('orders.processed', tags=['status:success'])
        
        return result
        
    except PaymentError as e:
        logger.error(
            "order_processing_failed",
            order_id=order_id,
            error=str(e),
            error_type=type(e).__name__
        )
        
        metrics.increment('orders.processed', tags=['status:failed'])
        
        raise
```

**Health Endpoints:**
```python
from fastapi import FastAPI

app = FastAPI()

@app.get("/health")
def health_check():
    """Liveness probe: Is service running?"""
    return {"status": "healthy"}

@app.get("/ready")
def readiness_check():
    """Readiness probe: Can service handle traffic?"""
    checks = {
        "database": check_database_connection(),
        "redis": check_redis_connection(),
        "payment_api": check_external_api()
    }
    
    all_healthy = all(checks.values())
    status_code = 200 if all_healthy else 503
    
    return JSONResponse(
        content={"status": "ready" if all_healthy else "not_ready", "checks": checks},
        status_code=status_code
    )
```

**Distributed Tracing:**
```python
from opentelemetry import trace

tracer = trace.get_tracer(__name__)

def process_order(order_id):
    with tracer.start_as_current_span("process_order") as span:
        span.set_attribute("order_id", order_id)
        
        with tracer.start_as_current_span("charge_payment"):
            result = payment.charge(order_id)
            span.set_attribute("transaction_id", result.id)
        
        with tracer.start_as_current_span("send_confirmation"):
            email.send_confirmation(order_id)
        
        return result
```

#### Benefits

- **Debugging** (understand failures without reproducing)
- **Performance tuning** (identify bottlenecks with metrics)
- **Alerting** (catch issues before users report them)
- **Compliance** (audit logs for security investigations)

---

### Article VIII: Security-By-Default

**Principle:** Systems fail safe. Deny by default, grant explicitly.

#### What This Means

- **Least privilege** (minimum permissions required)
- **Fail closed** (errors deny access, not grant)
- **Input validation** (reject malformed data)
- **Secure defaults** (no insecure fallbacks)

#### Enforcement Mechanism

```yaml
article_viii:
  enabled: true
  enforcement: security-scan
  rules:
    - default_deny: true
    - require_input_validation: true
    - no_hardcoded_secrets: true
    - enforce_https: true
  exceptions:
    - local_development:
        allow_http: true
```

#### Practical Examples

**❌ Violation:**
```python
# Fail-open authorization (DANGEROUS)
def check_permission(user, resource):
    try:
        return permission_service.check(user, resource)
    except Exception:
        # If service is down, grant access (WRONG!)
        return True
```

**✅ Compliant:**
```python
# Fail-closed authorization
def check_permission(user, resource):
    """Check if user has access to resource.
    
    Security principle: Fail closed.
    If permission service is unavailable, deny access.
    Better to block legitimate user temporarily than
    allow unauthorized access.
    """
    try:
        return permission_service.check(user, resource)
    except Exception as e:
        logger.error(
            "permission_check_failed",
            user_id=user.id,
            resource=resource,
            error=str(e)
        )
        # Fail safe: deny access on error
        return False
```

**❌ Violation:**
```python
# No input validation
@app.post("/users")
def create_user(username: str, email: str):
    # Direct insertion without validation
    db.execute(f"INSERT INTO users VALUES ('{username}', '{email}')")
    # SQL injection vulnerability!
```

**✅ Compliant:**
```python
from pydantic import BaseModel, EmailStr, Field

class UserCreate(BaseModel):
    username: str = Field(..., min_length=3, max_length=20, regex='^[a-zA-Z0-9_]+$')
    email: EmailStr
    
    @validator('username')
    def username_no_profanity(cls, v):
        if profanity.check(v):
            raise ValueError('Username contains inappropriate content')
        return v

@app.post("/users")
def create_user(user: UserCreate):
    """Create user with validated input.
    
    Security measures:
    - Pydantic validates types and formats
    - Username regex prevents injection
    - Email validated with EmailStr
    - Parameterized query prevents SQL injection
    """
    db.execute(
        "INSERT INTO users (username, email) VALUES (:username, :email)",
        username=user.username,
        email=user.email
    )
```

**Secret Management:**
```python
# ❌ Hardcoded secret
API_KEY = "sk_live_abc123xyz"

# ✅ Environment variable
import os

API_KEY = os.environ.get('API_KEY')
if not API_KEY:
    raise EnvironmentError("API_KEY must be set")
```

#### Security Checklist

```bash
# Run security audit
swaif audit security

# Output:
# Security Audit Results:
# 
# ✓ No hardcoded secrets found
# ✓ All endpoints require authentication
# ✓ Input validation present on 47/47 endpoints
# ✓ HTTPS enforced in production config
# ⚠ 2 dependencies with known vulnerabilities:
#   - requests==2.28.0 (CVE-2023-xxxxx)
#   - pillow==9.0.0 (CVE-2023-yyyyy)
# 
# Action required: Update vulnerable dependencies
```

#### Benefits

- **Attack surface reduction** (deny-by-default minimizes exposure)
- **Defense in depth** (fail-safe on errors)
- **Compliance** (meets security audit requirements)
- **Incident recovery** (secure defaults limit breach impact)

---

### Article IX: Documentation Synchronization

**Principle:** Code changes update documentation in the same commit. No stale docs.

#### What This Means

- **API changes** update OpenAPI specs
- **Function changes** update docstrings
- **Architecture changes** update diagrams
- **Config changes** update README

#### Enforcement Mechanism

```yaml
article_ix:
  enabled: true
  enforcement: pre-commit
  rules:
    - require_docstrings: true
    - update_api_specs: true
    - check_readme_sync: true
  exceptions:
    - excluded_functions:
        - pattern: 'test_.*'  # Test functions don't need docstrings
```

#### Practical Examples

**❌ Violation:**
```python
# Commit that changes function signature without updating docs

# Before:
def create_user(username: str) -> User:
    """Create a user with username."""
    pass

# After (forgot to update docstring):
def create_user(username: str, email: str, phone: str) -> User:
    """Create a user with username."""  # STALE! Missing email, phone
    pass
```

**✅ Compliant:**
```python
# Same commit updates both code and docstring

def create_user(username: str, email: str, phone: str | None = None) -> User:
    """Create a user with contact information.
    
    Args:
        username: Unique identifier, 3-20 alphanumeric characters
        email: Valid email address for notifications
        phone: Optional phone number in E.164 format
    
    Returns:
        Created User instance with generated ID
    
    Raises:
        ValueError: If username already exists or email invalid
        
    Example:
        >>> user = create_user('alice', 'alice@example.com')
        >>> user.username
        'alice'
    """
    pass
```

**API Documentation Sync:**
```yaml
# openapi.yaml (updated in same commit as code)
paths:
  /users:
    post:
      summary: Create new user
      requestBody:
        required: true
        content:
          application/json:
            schema:
              type: object
              required: [username, email]
              properties:
                username:
                  type: string
                  minLength: 3
                  maxLength: 20
                email:
                  type: string
                  format: email
                phone:
                  type: string
                  format: phone
                  nullable: true
```

**README Sync:**
```markdown
<!-- Updated in same commit as docker-compose.yaml change -->

## Running the Application

\`\`\`bash
# Start services (now includes Redis for caching)
docker-compose up -d

# Services:
# - app:3000 - Main API server
# - postgres:5432 - Database
# - redis:6379 - Cache (NEW in v1.2)
\`\`\`
```

#### Automated Checks

```bash
# Pre-commit hook checks for doc sync
.git/hooks/pre-commit

#!/bin/bash
# Check if src/ changed without updating docs/

SRC_CHANGED=$(git diff --cached --name-only | grep '^src/')
DOCS_CHANGED=$(git diff --cached --name-only | grep '^docs/')

if [ -n "$SRC_CHANGED" ] && [ -z "$DOCS_CHANGED" ]; then
    echo "ERROR: Source code changed without updating docs/"
    echo "Files changed:"
    echo "$SRC_CHANGED"
    echo ""
    echo "Please update relevant documentation in docs/"
    exit 1
fi
```

#### Benefits

- **Reliable documentation** (always reflects current code)
- **Knowledge preservation** (changes documented at time of change)
- **Onboarding** (new developers see accurate examples)
- **API contracts** (external consumers rely on up-to-date specs)

---

## Customizing Your Constitution

### Editing the Constitution File

```bash
# Open project constitution
swaif constitution edit

# File: .swaif/constitution.yaml
```

```yaml
project: my-api
constitution_version: 1.0

# Enable/disable articles
articles:
  traceability: enabled
  stage_gates: enabled
  test_first: enabled
  challenger_mode: enabled
  simplicity: enabled
  integration_first: enabled
  observability: enabled
  security: enabled
  documentation: enabled

# Customize enforcement
enforcement:
  traceability:
    commit_format: '\[TICKET-\d+\]'  # Use JIRA format
    require_pr_link: true
  
  test_first:
    min_coverage: 90%  # Stricter than default 80%
    
  challenger_mode:
    mandatory_paths:
      - 'src/billing/**'  # Financial code
      - 'src/auth/**'     # Security code
      - 'src/data-migration/**'  # Data integrity

# Project-specific exceptions
exceptions:
  - article: stage_gates
    reason: "Hotfix process for P1 incidents"
    allowed_skips: [PLAN]
    requires: [post-incident-review]
  
  - article: integration_first
    reason: "Research spikes can be long-lived"
    allowed_branches: ['spike/*']
    max_age: 7d
```

### Amendment Process

```bash
# Propose constitutional amendment
swaif constitution amend \
  --article=III \
  --change="Lower coverage from 90% to 85%" \
  --reason="Current target too strict for data processing module"

# Requires team approval
swaif constitution vote --amendment=001

# After approval, automatically updates .swaif/constitution.yaml
```

---

## Constitutional Violations and Fixes

### Violation: Missing Traceability

**Detection:**
```bash
git commit -m "Added feature"

# ERROR: Commit message missing requirement ID
# Required format: [REQ-XXX] or [TASK-XXX]
```

**Fix:**
```bash
git commit --amend -m "feat: Added user search [REQ-147]"
```

### Violation: Stage Gate Skipped

**Detection:**
```bash
swaif implement --task=T-001

# ERROR: Cannot proceed to IMPLEMENT stage
# Current stage: SPECIFY
# Missing gate approvals: PLAN, TASKS
```

**Fix:**
```bash
# Proper sequence
swaif gate approve SPECIFY
swaif plan
swaif gate approve PLAN
swaif tasks generate
swaif gate approve TASKS
swaif implement --task=T-001  # Now succeeds
```

### Violation: Missing Tests

**Detection:**
```bash
git push

# CI Pipeline Failed:
# ❌ Test coverage 65% below minimum 80%
# ❌ New code in src/billing.py has 0% coverage
```

**Fix:**
```bash
# Write tests first
cat > tests/test_billing.py <<EOF
def test_calculate_invoice():
    result = calculate_invoice(items=[...])
    assert result.total == 150.00
EOF

# Then re-run
pytest tests/
git add tests/test_billing.py src/billing.py
git commit -m "feat: Invoice calculation [REQ-089]"
```

### Violation: Unstructured Logs

**Detection:**
```bash
swaif audit observability

# ERROR: Unstructured logging detected
# File: src/api.py:45
#   print(f"User {user_id} logged in")
```

**Fix:**
```python
# Replace print with structured logger
logger.info("user_login", user_id=user_id, timestamp=datetime.now())
```

---

## Constitution Philosophy: Why These Nine?

Each article addresses a specific failure mode:

| Article | Without It, You Get... |
|---------|------------------------|
| **I: Traceability** | Zombie code, unclear requirements, failed audits |
| **II: Stage Gates** | Late discovery of design flaws, costly rework |
| **III: Test-First** | Brittle code, fear of refactoring, manual testing |
| **IV: Challenger** | Security vulnerabilities, unhandled edge cases |
| **V: Simplicity** | Unmaintainable complexity, knowledge silos |
| **VI: Integration** | Merge hell, integration surprises, deployment fear |
| **VII: Observability** | Production debugging via guesswork |
| **VIII: Security** | Data breaches, unauthorized access |
| **IX: Documentation** | Stale docs, knowledge loss, onboarding friction |

**Together, they create a resilient engineering culture.**

---

## Summary

A SWAIF constitution is:
- **Enforceable** (not just guidelines)
- **Customizable** (adapt to your domain)
- **Evolvable** (formal amendment process)
- **Auditable** (violations tracked and reported)

Start with the default nine articles, then customize based on lessons learned.

**Next:** Learn daily operations in the [Workflow Guide](WORKFLOW_GUIDE.md).

---

_Last Updated: 2024 | SWAIF v1.0.0_
# Constitution Guide

This guide explains how to interpret SWAIF constitutional articles and evolve them responsibly.

## Article-by-Article Explanation

### Article I — Purpose and Scope
Defines the mission of SWAIF and the boundaries of where the framework applies.

### Article II — Principles
Codifies non-negotiable values: transparency, accountability, incrementalism, and evidence-based decisions.

### Article III — Authority and Decision Rights
Assigns who can decide what, including escalation paths and emergency exceptions.

### Article IV — Delivery Integrity
Requires stage discipline, quality gates, and explicit acceptance criteria.

### Article V — Risk, Security, and Compliance
Ensures regulated requirements and risk controls are incorporated from planning onward.

### Article VI — Learning and Improvement
Mandates retrospectives, incident learning, and periodic framework updates.

## Amendment Process
1. **Proposal Drafting** — Submit an amendment proposal with rationale, expected impact, and affected teams.
2. **Review Window** — Open a fixed review period for comments and objections.
3. **Steward Evaluation** — Governance stewards assess compatibility with existing articles.
4. **Ratification** — Approve via defined quorum or delegated authority.
5. **Publication** — Update canonical docs and communicate effective date.
6. **Adoption Review** — Verify implementation after an agreed evaluation interval.

## Practical Usage
- Link policy decisions to relevant articles in planning and review artifacts.
- Treat constitutional conflicts as first-class blockers, not downstream cleanup.
- Use amendments to resolve recurring friction instead of creating informal exceptions.
