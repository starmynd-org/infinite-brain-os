---
id: "rule-department-head-reporting-contract"
aliases: ["rule-department-head-reporting-contract", "department-head-reporting-contract", "department-rollup-contract"]
type: "Rule"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "The standard periodic rollup every department head emits up to the fleet coordinator. It is the clock-driven counterpart of the event-driven result-and-escalation contract: not one work product, but the whole department's state for the cycle. It is the single input the fleet coordinator aggregates into the fleet rollup and that the chief-of-staff role consolidates into the executive brief. Domain-free, read by every head and by the fleet coordinator."
confidence: 0.85
retrieval_class: "domain"
export_class: "internal"
description: "Apply this rule when a department head produces its periodic rollup (daily by default, weekly summary on cadence). Emit the standard department-rollup envelope so the fleet coordinator can aggregate one fleet view and the chief-of-staff role can consolidate one executive brief. Human-bound items are referenced here but routed through the result-and-escalation contract, never surfaced from the rollup itself."
edges:
  - target: "[[rule-signal-vocabulary]]"
    relation: "depends_on"
    confidence: 0.88
  - target: "[[rule-result-and-escalation-contract]]"
    relation: "complements"
    confidence: 0.87
created: "2026-06-09"
---

# Rule: Department-Head Reporting Contract

The periodic reporting side of the management layer. Where `[[rule-result-and-escalation-contract]]` is
the event-driven producer contract a head emits when it finishes one work product or hits one decision
point, this rule is the clock-driven contract a head emits once per cycle to report the whole
department's state. It is the operative form of the daily-update pattern in
`_system/department-runtime-contract.md`, made into one standard envelope across the department set so
the fleet coordinator and the chief-of-staff role aggregate a uniform shape instead of parsing bespoke
updates.

## The rollup envelope

Every department rollup carries:

- `rollup_id`
- `department` (slug) and `head` (head agent)
- `period` (the cycle: the date for a daily rollup, the week for a weekly summary)
- `cadence` (daily or weekly)
- `intake`: what came in this cycle (count plus the high-signal items)
- `processed`: what the department worked and completed
- `changed`: what materially changed in the department's state or canon-candidates
- `blocked`: in-flight work that is stuck, each with its blocker and whether the blocker is
  cross-department (a fleet-coordinator concern) or internal
- `needs_human`: references to the open human-bound items the department has escalated this cycle, by
  `result_id` (the items themselves travel via `[[rule-result-and-escalation-contract]]`, not in the
  rollup body)
- `next`: what the department intends to run next cycle
- `health`: a small fixed set of department health signals (queue size and age, in-flight count,
  cost-versus-cap posture, and the department's own confidence in its current state)
- `charter_alignment`: how this cycle's work served the department's north star (low, medium, high),
  per `[[rule-signal-vocabulary]]`
- `receipt_ref`

A missing section defaults conservative and explicit: an empty section is reported as empty, never
omitted, so an absent rollup is distinguishable from a quiet cycle.

## What the rollup is not

- It is not the escalation channel. Human-bound items are emitted through the result-and-escalation
  contract and aggregated by the chief-of-staff membrane. The rollup only references them by id so the
  fleet view and the brief can show counts and link through. A head never reaches the operator by way of
  its rollup.
- It is not a worker log. It is the department-level compression a strong VP would hand up: state and
  intent, not task chatter.
- It is not a second source of truth. The rollup is reconcilable from canonical repo state (backlog,
  intake receipts, sprint statuses, the state ledger). Recover the rollup from canon, not from chat.

## Cadence

- daily rollup: the default cycle, emitted once per heartbeat-day, answering came-in, processed,
  changed, blocked, needs-human, next.
- weekly summary: a coarser rollup over the week for the weekly coordination and management-layer
  reviews, emphasizing trend and charter-alignment over the day's line items.

Both use the same envelope; the weekly summary widens `period` and compresses the line-item sections.

## Where it goes

- up to the fleet coordinator: every work-department head's rollup feeds the fleet rollup, which
  aggregates them into one fleet view and resequences cross-department blockers. This is the single
  coordination input the fleet coordinator consumes.
- into the executive brief: the chief-of-staff role consolidates the rollups (via the fleet rollup's
  operator-facing slice) into one executive brief, so the operator reads one brief instead of one ping
  per department.
- the chief-of-staff membrane is the one protected-peer exception: it reports to the operator, not up
  to the fleet coordinator, so its rollup feeds the operator and syncs with the fleet coordinator
  rather than reporting into it.

## The producer set

Every department head the adopter assembles emits this rollup. The fleet coordinator aggregates them
into the fleet rollup, and the chief-of-staff role consolidates the operator-facing brief.

## Discipline

- one envelope, all departments: adding or removing a rollup section is a change to this rule, not a
  per-department improvisation.
- reconcilable from canon: the rollup is a projection of durable repo state, never the only home of a
  fact.
- every consequential rollup writes an append-only receipt to `departments/<slug>/receipts/`.
- live rollup state (the current cycle's in-flight values) belongs in the runtime substrate; git holds
  the contract and the audit trail, per the Paperclip boundary.

## Relationship

This rule is the periodic reporting contract; `[[rule-result-and-escalation-contract]]` is the
event-driven escalation contract. Both read `[[rule-signal-vocabulary]]`. The fleet coordinator
aggregates this rollup into the fleet view; the chief-of-staff role consolidates it into the executive
brief.
