---
id: "metric-effectiveness-points"
aliases: ["metric-effectiveness-points", "effectiveness-points"]
type: "Metric"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "System-level effectiveness-points: the value-weighted sum of completion-award points across the whole brain (intake items, tasks, projects, swarms), sliced by actor_type (human/ai/hybrid) and owning_department_id. A leading, diagnostic signal of AI leverage and momentum, kept honest by the wager ledger; explicitly not a value target."
confidence: 0.78
retrieval_class: "domain"
export_class: "internal"
verified_at: "2026-06-25"
verified_by: "operator-pending"
metric_id: "effectiveness-points"
format: "count"
polarity: "neutral"
aggregation: "sum"
expression: "sum(earn_event.points_awarded) over the period, grouped by actor_type and owning_department_id; each earn_event.points_awarded = base(ladder_level) * value_multiplier(priority_signals, wager_expected_value) per _system/points-orientation-rules.md POINTS-3"
depends_on: []
instrumentation_status: "not-wired"
implementation_path: "byo-adapter"
implementation_owner: "shared-platform"
edges:
  - target: "[[points-orientation-currency]]"
    relation: "explained_by"
    confidence: 0.88
  - target: "[[metric-primitive]]"
    relation: "conforms_to"
    confidence: 0.9
  - target: "[[wager-ledger-and-scientific-loop]]"
    relation: "kept_honest_by"
    confidence: 0.88
  - target: "[[rule-priority-model]]"
    relation: "derived_from"
    confidence: 0.82
created: "2026-06-25"
---

The system-level metric of the points and orientation primitive. The semantic definition lives here; the
operative contract is `_system/points-orientation-rules.md` (rule POINTS-9), and the reasoning is
[[points-orientation-currency]].

## Definition

Effectiveness-points is the value-weighted sum of completion-award points booked across the whole brain
over a period. Each `earn_event` (rule POINTS-2) contributes its `points_awarded`, where the award is the
ladder-level scope base scaled by the item's value (the priority-model signals plus, where present, the
wager expected value; rule POINTS-3). The metric is the sum of those awards.

## Slices

The metric is sliced by two conformed dimensions on every `earn_event`:

- `actor_type`: `human`, `ai`, or `hybrid`. This is the AI-leverage view: how much of the value-weighted
  completion the AI is actually accomplishing versus the human versus the two together.
- `owning_department_id`: the department that owns the work, matching the wager ledger's conformed
  department dimension (WAGER-16a), so a department reads its own effectiveness-points slice the same way
  it reads its wager slice.

It can also be cut by `ladder_level` (intake item, task, project, swarm) to see where completion is
concentrated.

## Polarity: neutral, on purpose

`polarity` is `neutral`, not `higher-better`. This is the load-bearing honesty choice. Effectiveness-points
is a leading, diagnostic signal of AI leverage and momentum, not a value target. More points is not
automatically better: a rising count that is not matched by passing wager verdicts is busywork, not value.
The metric exists to make AI leverage visible and to feed the per-department improvement loop, never to be
maximized. Goodhart's law is the central risk, and the contract's POINTS-7 guardrail (value-weighting, the
wager cross-check, evidence-based attribution, no double-earn, operator-tuned weights) is what keeps the
number meaningful. The objective function is exogenous value, owned by the wager ledger
([[wager-ledger-and-scientific-loop]]); this metric is the diagnostic beside it.

## Instrumentation status: not wired

`instrumentation_status` is `not-wired`. The metric is defined now and dormant. It hydrates when the points
runtime store exists (the live tally over the append-only `earn_event` audit trail; rule POINTS-6), which
is deferred to activation alongside the wager-ledger runtime and shares its analytical plane (local
Postgres, owner devops-platform). The lineage face (into a Data System namespace) and the diagnosis face
(into an Operating Library namespace) are dormant until then; this node currently carries only the semantic
definition.

## Placement note

This metric node sits in the `ai-architecture` doctrine-profile namespace because the points primitive is
architecture-level and has no dedicated Data System or Operating Library home yet. Whether it should move
to a dedicated brain-operations Data System namespace when the runtime ships is an operator-pending
decision, recorded against an internal build project (not shipped).
