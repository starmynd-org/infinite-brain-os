# Routing: Residue and Review Posture

How the intake fabric watches for items that did not cleanly land, and the review loop that clears
them. This is the residue and handoff side of routing. `destination-rules.md` decides where an item
goes; this file defines what happens when an item does not get there, or gets there but is not
accepted, or waits on a human.

Residue is the durable backlog signal, not live queue state. A residue item is a settled receipt or
captured record that records an unresolved disposition. It is never a tracked `unprocessed/`,
`in-review/`, or `blocked/` folder; that is runtime state owned by the operational app
(`_system/namespace-intake-rules.md`, INTAKE-2).

## The three residue classes

- **Triage residue.** An item that was captured and scored `defer` (0.35 to below 0.65 in
  `scoring-model.md`), or a `verify-before-promote` item, that has not yet been promoted or rejected.
  The captured record stays in `sources/<family>/`; the open status is runtime state, not a git
  queue. Residue here is counted, not stored as a backlog file.
- **Handoff residue.** An item that was routed to a department or namespace, with a routing decision
  recorded, but the destination has not yet produced the node and the per-destination trail pointer
  in `intake/destinations/<ns>/processed/` is missing. The route is open until that pointer exists.
- **Ambiguity residue.** An item flagged ambiguous or `approval_state: pending`, awaiting an operator
  call on the lane, the namespace, a new-namespace proposal, or a canon change.

A processed receipt is required for every processed item, including items routed to `nothing`
(INTAKE-6). Residue is the set of items whose receipts record a defer, an open handoff, or a pending
approval, rather than a closed disposition.

## When a route is closed

A route is not done at the routing decision. It closes when both are true:

1. the destination department or namespace has produced or updated the node, project, action, or
   workflow input, and
2. the source-keyed receipt under `intake/processed/<family>/` and the destination-keyed pointer
   under `intake/destinations/<ns>/processed/` both exist and reference each other
   (INTAKE-6 and INTAKE-7).

Until both hold, the item is handoff residue and shows up in the destination-residue count for its
lane. A receipt that records a route but carries no matching routing decision or destination link is
a validate.sh error in the intake tree, so an unclosed handoff is visible, not silent.

## The review loop

The cadence mirrors the operating rhythm in `departments/intake-operations/INDEX.md` and `CHARTER.md`.

- **Daily intake routing update.** Emit what arrived, what was processed, what was routed where, what
  remains ambiguous, and which destinations are building residue. This is the daily surfacing of all
  three residue classes by lane.
- **Weekly routing and residue review.** Re-score triage residue (promote, reject, or keep deferred
  with a reason), close or escalate handoff residue (chase the destination or move the lane), and
  clear ambiguity residue with the operator. Nothing should sit in residue across two reviews without
  an explicit reason recorded in its receipt.
- **Weekly department-destination calibration.** Per lane, ask whether residue is growing, whether
  routing is landing in the right department, and whether the department map or the scoring weights
  need adjustment. A lane whose residue keeps growing is a routing-doctrine signal, not just a
  backlog.

## Handoff posture across the membrane

Routing produces three kinds of handoff, each with its own close condition:

- **To a department or namespace.** Closes when the node and the trail pointer exist, as above.
- **To `infinite-brain-ops` (PKM and structural).** A likely canon candidate, a namespace-structure
  implication, a new tool, workflow, or department implication, or a refined project-task
  recommendation gets a PKM-opportunity handoff (`intake/schemas/pkm-opportunity.md`) in addition to
  the normal receipt. Closes when infinite-brain-ops dispositions it.
- **To `chief-of-staff` (human-bound).** A decision, approval, blocker, or assumption needing
  sign-off escalates through the operator human-queue contract and surfacing policy. Intake routes it
  and continues; it does not block waiting, and it does not perform the human task itself
  (`.claude/rules/result-and-escalation-contract.md`, `.claude/rules/operator-human-queue-contract.md`).

## Metrics

The residue and handoff metrics are the intake-operations KPIs (`departments/intake-operations/CHARTER.md`):

- intake processing rate
- time from capture to processed receipt
- ambiguous routing count (ambiguity residue)
- destination residue count (handoff residue by lane)
- rejected-noise ratio

All are manual now. No live instrumentation exists in git, and live queue counts stay in the
operational app. Live binding of these metrics is an activation concern, not part of this doctrine.

## Anti-capture default

The conservative default is to surface or defer, never to silently auto-route a doubtful item. This
mirrors the L1 surfacing posture (`.claude/rules/surfacing-policy.md`): learning is off, nothing
auto-handles, and anything `external`, `canon-touching`, or low-confidence surfaces. The raw captured
records stay accessible to the operator at any time. Misrouting is the routing safety metric: when it
rises, the routing and ambiguity rules tighten immediately.
