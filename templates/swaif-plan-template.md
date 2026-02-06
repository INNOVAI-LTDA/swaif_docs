# SWAIF Implementation Plan Template

> Template owner: Engineering Leadership.
> Expected inputs: approved spec, architecture constraints, team capacity, platform standards, and risk mode.

## Plan Metadata

- **Plan ID**: `PLAN-YYYY-NNN`
- **Spec reference**: `[path/uri]`
- **Owner**: `[name/role]`
- **Risk mode**: `[low|moderate|high|critical]`
- **Target window**: `[start/end]`

## Phase -1 Readiness Gates (Pre-Execution)

> All Phase -1 gates must pass before feature coding begins.

| Gate | Required Inputs | Exit Criteria | Approver |
|---|---|---|---|
| Scope Gate | Approved spec, success metrics | Scope frozen or controlled change process active | Product + Eng |
| Architecture Gate | ADRs, system/data/API designs | Design accepted and risks logged | Architecture |
| Security Gate | Threat model, data classification | Controls defined; blockers resolved | Security |
| Operability Gate | SLO draft, telemetry plan, runbook skeleton | Monitoring and response ownership assigned | SRE/Ops |
| Delivery Gate | Task breakdown, dependencies, staffing | Execution plan baselined | Delivery Lead |

## 1) Architecture Plan

- **Current state summary**: `[brief]`
- **Target architecture**: `[brief + diagram link]`
- **Key design decisions (ADRs)**:
  - `[ADR-001]`
  - `[ADR-002]`
- **Trade-offs and rationale**: `[summary]`

## 2) Data Plan

- **Data entities and ownership**: `[table or bullets]`
- **Schema changes/migrations**: `[forward/backward compatibility, rollback]`
- **Retention and deletion policy impacts**: `[requirements]`
- **Data quality controls**: `[validation checks, reconciliation]`

## 3) API and Integration Plan

- **Contract changes**: `[endpoints/events/versioning]`
- **Compatibility strategy**: `[versioning/deprecation timelines]`
- **External dependency handling**: `[SLAs, retries, circuit breaking]`
- **Test strategy for integrations**: `[contract tests, sandbox tests]`

## 4) Observability Plan

- **SLIs/SLOs**: `[definitions + targets]`
- **Metrics/logs/traces**: `[required telemetry by component]`
- **Alerts**: `[critical alerts + on-call routing]`
- **Runbooks**: `[incident runbook links]`

## 5) Security and Compliance Plan

- **Threat model summary**: `[top abuse/failure cases]`
- **Controls mapping**: `[control -> implementation]`
- **Secrets and key management**: `[approach]`
- **Compliance evidence generation**: `[automated/manual artifacts]`

## 6) Delivery and Rollout Plan

- **Milestones**: `[phase/milestone list]`
- **Rollout strategy**: `[dark launch/canary/phased/full]`
- **Rollback strategy**: `[trigger + mechanism + owner]`
- **Communication plan**: `[stakeholder updates + cadence]`

## 7) Exit Criteria and Handover

- **Definition of done**: `[criteria]`
- **Production readiness sign-off**: `[roles + checklist links]`
- **Post-launch validation window**: `[duration + success checks]`
