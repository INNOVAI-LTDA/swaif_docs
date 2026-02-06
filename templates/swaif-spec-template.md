# SWAIF Specification Template

> Template owner: Product + Architecture.
> Expected inputs: problem statement, user outcomes, constraints, constitution version, and delivery context.

## Metadata (YAML)

```yaml
spec_id: SPEC-YYYY-NNN
name: <short-title>
version: 0.1.0
status: draft # draft|review|approved|implemented|retired
owner:
  product: <name>
  engineering: <name>
  risk: <name>
constitution_ref:
  doc: <path-or-uri>
  version: <semver>
lifecycle_stage: specification
risk_mode: low # low|moderate|high|critical
last_updated: YYYY-MM-DD
```

## 1) Problem and Outcome Definition

- **Problem statement**: `[what is broken or missing]`
- **Target users/stakeholders**: `[who benefits or is impacted]`
- **Desired outcomes**: `[measurable outcomes]`
- **Out of scope**: `[explicit exclusions]`

## 2) Functional Scope

- **Capabilities in scope**
  - `[capability 1]`
  - `[capability 2]`
- **Interfaces affected**
  - `[UI/API/Event/Data contracts]`
- **Migration/rollout assumptions**
  - `[assumptions]`

## 3) Constitutional Checklist

> Mark each item `PASS`, `PARTIAL`, or `FAIL` and justify with evidence links.

- [ ] **Purpose alignment** — Solution directly supports constitutional purpose.
- [ ] **Decision rights** — Named accountable owners and approvers.
- [ ] **Stage-gate readiness** — Required artifacts are identified.
- [ ] **Quality baseline** — Test strategy and acceptance criteria defined.
- [ ] **Security/privacy baseline** — Threats, controls, and data handling defined.
- [ ] **Risk handling** — Risk level, mitigations, and exceptions documented.
- [ ] **Observability baseline** — Telemetry and incident signals defined.

## 4) Non-Functional Requirements (NFRs)

| Category | Requirement | Target | Verification Method | Owner |
|---|---|---|---|---|
| Performance | `[e.g., p95 latency]` | `[target]` | `[load/perf test]` | `[role]` |
| Availability | `[uptime objective]` | `[target]` | `[SLO monitor]` | `[role]` |
| Reliability | `[error budget / MTTR]` | `[target]` | `[ops drill + dashboards]` | `[role]` |
| Security | `[control objective]` | `[target]` | `[scan/review/test]` | `[role]` |
| Privacy | `[data minimization]` | `[target]` | `[review/audit]` | `[role]` |
| Compliance | `[framework requirement]` | `[target]` | `[evidence artifact]` | `[role]` |

## 5) Risk Assessment

- **Risk mode**: `[low|moderate|high|critical]`
- **Top risks**:
  1. `[risk]` — Probability: `[L/M/H]`, Impact: `[L/M/H]`, Mitigation: `[plan]`
  2. `[risk]` — Probability: `[L/M/H]`, Impact: `[L/M/H]`, Mitigation: `[plan]`
- **Residual risk summary**: `[remaining risk after controls]`
- **Exception requests** (if any): `[id, rationale, expiry, approver]`

## 6) Approval Record

| Role | Name | Decision | Date | Notes |
|---|---|---|---|---|
| Product Owner | `[name]` | `[approve/revise/reject]` | YYYY-MM-DD | `[notes]` |
| Engineering Lead | `[name]` | `[approve/revise/reject]` | YYYY-MM-DD | `[notes]` |
| Security/Risk | `[name]` | `[approve/revise/reject]` | YYYY-MM-DD | `[notes]` |

## 7) Evidence and Trace Links

- Constitution reference: `[link]`
- Plan artifact: `[link when available]`
- Tasks artifact: `[link when available]`
- Supporting research: `[links]`
