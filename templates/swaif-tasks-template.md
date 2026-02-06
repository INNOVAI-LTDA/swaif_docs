# SWAIF Tasks Template

> Template owner: Delivery Lead / Team Leads.
> Expected inputs: approved plan, milestone dates, team ownership map, and risk mode.

## Task Set Metadata

- **Task Set ID**: `TASKS-YYYY-NNN`
- **Plan reference**: `[path/uri]`
- **Execution mode**: `[sequential|parallel|hybrid]`
- **Owner**: `[name/role]`
- **Status**: `draft`

## Task Structure

Use one task per independently reviewable unit with explicit completion evidence.

| Task ID | Title | Description | Owner | Estimate | Definition of Done |
|---|---|---|---|---|---|
| T-001 | `[task title]` | `[what + why]` | `[name/role]` | `[size/time]` | `[artifact/test/proof]` |
| T-002 | `[task title]` | `[what + why]` | `[name/role]` | `[size/time]` | `[artifact/test/proof]` |

## Execution Modes

### Sequential Mode
- Use when outputs from one task are strict prerequisites for the next.
- Typical for schema migrations, regulatory reviews, or contract-first dependencies.

### Parallel Mode
- Use when tasks can proceed independently with minimal coupling.
- Typical for UI/backend split work, isolated components, or documentation tracks.

### Hybrid Mode
- Use when foundational tasks must complete first, then fan out to parallel streams.
- Typical for architecture baseline + implementation branches.

## Dependency Mapping

| Task ID | Depends On | Blocking Reason | Unblock Criteria |
|---|---|---|---|
| T-002 | T-001 | `[reason]` | `[criteria]` |

## Risk-Aware Work Controls

- **High-risk tasks**: `[task ids]`
- **Required reviewers**: `[security/architecture/ops/etc.]`
- **Additional controls**: `[pairing, extra tests, staged rollout]`

## Traceability Matrix

> Ensure every task maps back to a plan section and spec requirement.

| Task ID | Plan Section | Spec Requirement | Constitution / Control Link | Evidence |
|---|---|---|---|---|
| T-001 | `[section]` | `[req-id]` | `[article/control]` | `[test/doc/link]` |

## Execution Log (Optional)

- `[YYYY-MM-DD] T-001 started/completed; notes`
- `[YYYY-MM-DD] T-002 blocked/unblocked; notes`
