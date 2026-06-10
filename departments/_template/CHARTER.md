---
id: "department-template-charter"
type: "Charter"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Template charter for an AI shadow department: mission, north star, owned outcomes, goals, KPIs, constraints, and reporting cadence. Copy to departments/<slug>/CHARTER.md and set id to department-<slug>-charter."
confidence: 0.86
retrieval_class: "identity"
export_class: "internal"
created: "2026-06-04"
---

# Department Charter Template

Copy this to `departments/<slug>/CHARTER.md`, set `id: "department-<slug>-charter"` and
`type: "Charter"`, and fill every section. A department without a charter is incomplete by default
(`_system/department-charter-rules.md`). The INDEX answers what the department contains; the charter
answers what it optimizes and how success is measured.

If the department materially belongs to external commercial scope, add optional frontmatter like:

```yaml
party_slugs: [acme, drift]
client_slug: "acme-crm"
brand_slug: "drift"
```

## Mission

What this department is for, in one paragraph. Start from the business function, not the tools.

## North Star

The single directional outcome the department moves toward over time.

## Owned Outcomes

The concrete results the department is accountable for.

## Key Goals

The near-term goals that advance the north star.

## KPIs / Metrics

The leading and lagging indicators. State the data posture for each: a shared Data System, a department
Data node, or provisional with explicit `not-wired` status. Do not leave a KPI without one of those.

## Targets and Review Posture

The targets, which metric is the safety metric, and how the targets are reviewed.

## Core Constraints

What the department must and must not do (who it works for, conservative defaults, audit trail, what it
does not own such as canon or launch approval).

## Related Entities

Parties, namespace, head agent, doctrine, runtime surface, owned data, produced outputs, goals.

## Human Review / Escalation

What the operator owns final acceptance of; what the operator tunes; what is fully AI-routed.

## Reporting Cadence

The daily update, the rollup target, and the weekly, monthly, and quarterly reviews.

## Open Gaps

What still has to be built or wired before this department is real.
