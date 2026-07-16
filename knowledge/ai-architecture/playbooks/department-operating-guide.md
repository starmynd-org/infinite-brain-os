---
id: "playbook-department-operating-guide"
aliases: ["playbook-department-operating-guide", "department-operating-guide"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "The canonical guide for how an AI shadow department operates within the OODA loop and the wager ledger: the department as an Orient context, the two intake lanes, the item lifecycle (observation, routing, disposition, wager, verdict), what a department owns (its slice of the board via owning_department_id), how the head's heartbeat runs it, how a department makes a business-grounded wager, and how verdicts feed component health, calibration, and the rollup. Operative contract: _system/wager-ledger-rules.md."
confidence: 0.84
retrieval_class: "domain"
export_class: "internal"
verified_at: "2026-06-19"
verified_by: "operator-pending"
edges:
  - target: "[[department-model]]"
    relation: "derived_from"
    confidence: 0.92
  - target: "[[wager-ledger-and-scientific-loop]]"
    relation: "depends_on"
    confidence: 0.92
  - target: "[[feedback-plane-act-to-orient-loop]]"
    relation: "depends_on"
    confidence: 0.88
  - target: "[[planning-to-execution-ladder]]"
    relation: "depends_on"
    confidence: 0.85
  - target: "[[correction-loop-absorption]]"
    relation: "feeds"
    confidence: 0.82
created: "2026-06-19"
---

# Department Operating Guide

## What this guide is

The canonical guide for how an AI shadow department operates inside the brain's OODA loop and the wager
ledger. The department doctrine ([[department-model]]) says what a department is; this guide says how it
runs day to day with the ledger. The operative contract is `_system/wager-ledger-rules.md`; the
reasoning is the OODA bridge `knowledge/ai-architecture/synthesis/boyd-to-agent-architecture-ooda-map.md` and
[[feedback-plane-act-to-orient-loop]]. The visual companion is `docs/ooda-infinite-brain-map.html` (Boyd's real OODA web, then the
same topology mapped onto this architecture).

## The department is an Orient context

Read as Boyd's OODA, a department is an Orient context. Its charter, knowledge namespaces, rules,
skills, prior tasks, and memory are the frame it reasons from; its head agent runs orient-decide-act on
the items routed to it. The department's job is not to cycle faster, it is to hold a well-matched
orientation and act from it. Most routine work flows through implicit guidance (deterministic handlers,
fat skills, learned rules); only genuinely novel work takes the explicit decide path (scoper, swarm,
sprint, project).

## The two lanes

Not every item is scored. Inbound items pass a cheap deterministic classifier first.

- **Data-handling lane (the bulk):** spam, newsletters, receipts, duplicates, known-sender-known-action.
  Handled by rule, logged as a thin `intake_event`, never scored, never a wager. Auditable, never
  invisible.
- **Judgment lane (the residue):** ambiguous, novel, or actionable items. Their `intake_event` links to
  a full `observation` that is scored and enters the lifecycle below.

A department optimizes for both: handle its routine data cleanly, and reserve the loop machinery for the
consequential slice.

## The lifecycle an item moves through

`observation -> routing -> disposition -> (wager?) -> action -> verdict -> improvement`

- **observation:** the captured, scored item (judgment lane). Carries `owning_department_id`.
- **routing:** sends it to the department and names the disposition type.
- **disposition:** what it becomes. The umbrella record points to the realized entity by
  `target_type` + `target_id` (a task on the [[planning-to-execution-ladder]], a knowledge node, a
  charter change) and never duplicates it. A `swarm` disposition is non-terminal: it decides a course of
  action and spawns a child disposition (`parent_disposition_id`) that carries the wager.
- **wager:** attached only when the disposition is a bet on a future outcome (most actions; not pure
  knowledge updates). See "How a department makes a wager."
- **action:** the work ships; the result envelope records whether it shipped (not whether it worked).
- **verdict:** at the horizon, the wager is scored against an exogenous metric and diagnosed.
- **improvement:** a surprising verdict raises a correction-to-structure candidate
  ([[correction-loop-absorption]]); the scientist may file a new wager.

`observation` and `disposition` are living rows whose status advances; the rest are append-only.

## What a department owns

A department is the owner and accountability unit for its slice of the board. `observation` carries
`owning_department_id`, and `disposition` and `wager` inherit it, so the department filters the whole
board by its id:

- its inbox (open observations), its backlog (open dispositions), its in-flight wagers and due verdicts;
- its `component_health` and `calibration`, sliced to its own components, so it learns which of its own
  playbooks, skills, and rules actually drive profit.

One inbound item that matters to several departments is split into one observation per department: the
fan-out is the split, not a shared row. One accountable owner per observation, matching the
single-accountable-owner doctrine. Cross-department collaboration is named on the disposition, not by
multiplying owners; cross-department coordination is the fleet coordinator's job, not a second owner.

## The head's loop, run with the ledger

The head's stateless-per-cycle heartbeat (see `department-head-runtime`) maps onto the lifecycle:

1. Load orientation: charter, INDEX, knowledge, the state ledger.
2. Read the department's slice of the board: new observations, backlog dispositions, due wagers.
3. Decide the next action with the priority model; scope a disposition (task, knowledge, charter, or a
   swarm when the right action is unknown).
4. For consequential actions, pre-register a wager before acting.
5. Dispatch; emit structured results; book receipts.
6. Reconcile the board from canonical state; escalate human-bound items through the membrane.

The head does not hand-maintain tables. Receipts are booked mechanically at disposition-created,
wager-registered, and result-produced; the heartbeat reconciles and flags any unbooked consequential
action.

## How a department makes a wager

A wager is a pre-registered, business-grounded, falsifiable prediction, and it is a machine-readable BI
query. It states:

- `expected_revenue_impact` and `expected_contribution_profit_impact` (always; a cost-only action sets
  revenue to 0 and books the saving as profit);
- the `scope` (the dims it applies to, for example source=amazon, sku_category=fragrance);
- the `comp_scenario` (prior_period, budget, target, benchmark, or control_holdout) and its
  `baseline_ref`;
- the `dataset`, the `date_range_start` and `date_range_finish`, and a confidence;
- secondary metrics (sessions, AOV) as `wager_metric` rows, each tied to a `metric_id` per the
  [[metric-primitive]].

Because the bet is fully specified, the BI model compiles it into a query and the verdict is computed
deterministically or by a cheap model, not an expensive reasoning run. A knowledge update records a
truth, not a bet, so it carries no wager; its feedback is accuracy, usage, and freshness review.

## Verdicts, learning, and the rollup

The verdict scores the actuals against the comp scenario over the date range, records the surprise, and
writes a hard-to-vary diagnosis. Results backflow to `component_health` and `calibration` (now
profit-attributed), so the department sees which components pay off and whether its stated confidence is
calibrated. The department's daily and weekly rollup is exactly this slice aggregated: intake,
processed, changed, blocked, next, health, and charter alignment are projections of the department's
`item_lifecycle` and wager outcomes. Reporting and the ledger are the same data at two grains, so the
rollup reconciles from the board and is never a second source.

## Hard rules for a department

- Score the residue, not everything. Route the bulk deterministically and log it.
- One accountable owner per observation; split for many.
- A consequential action carries a wager before it acts; a knowledge update does not.
- State revenue and contribution-profit impact on every wager (cost-only = revenue 0, saving as
  profit), plus scope, comp scenario, and date range, so it is query-evaluable.
- Score against an exogenous metric, never the agent's own re-assertion.
- Never hand-maintain the board; book receipts mechanically and reconcile.
- Never put a rolling score in canon frontmatter; scores live in the analytical plane.

## What this drives and where to go next

This guide drives every department head's heartbeat, the build-department path, and the daily and weekly
rollups. Deeper reads: `_system/wager-ledger-rules.md` (the contract), [[wager-ledger-and-scientific-loop]]
(the decision), [[feedback-plane-act-to-orient-loop]] (the spec), and [[department-model]] (what a
department is).

## Changelog

- 2026-06-19: authored as the canonical department operating guide in the canonization session
  (operator-directed). Pending final operator sign-off.
