---
id: "playbook-department-onboarding-guide"
aliases: ["playbook-department-onboarding-guide", "department-onboarding-guide", "onboard-a-department"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "The onboarding guide for a new AI shadow department: the role it must internalize in the full OODA and wager-ledger system, the sequenced steps to come online and wire itself into the whole (charter, assembly, intake lanes and owning_department_id, a conforming head, metrics and first wagers, rollup, capture, human layer), and an alignment acceptance checklist that proves the department is tied into the system. Points to the detailed docs; does not duplicate them."
confidence: 0.84
retrieval_class: "domain"
export_class: "internal"
verified_at: "2026-06-21"
verified_by: "operator-pending"
edges:
  - target: "[[department-model]]"
    relation: "depends_on"
    confidence: 0.92
  - target: "[[department-operating-guide]]"
    relation: "depends_on"
    confidence: 0.9
  - target: "[[build-department]]"
    relation: "paired_with"
    confidence: 0.88
  - target: "[[translate-business-function-into-ai-shadow-department]]"
    relation: "depends_on"
    confidence: 0.85
  - target: "[[wager-ledger-and-scientific-loop]]"
    relation: "depends_on"
    confidence: 0.85
  - target: "[[metric-primitive]]"
    relation: "depends_on"
    confidence: 0.82
created: "2026-06-21"
---

# Department Onboarding Guide

## What this guide is

The entry-point guide for standing up a new AI shadow department so it understands its role in the
full system and ties itself in. Read it first when onboarding a department. It sits between the others
and does not repeat them:

- [[department-model]] (canon): what a department is.
- [[build-department]] (skill) and `_system/department-assembly-rules.md`: the mechanical assembly.
- [[department-operating-guide]]: how a live department runs day to day with the ledger.
- This guide: how a new department comes online, wires into the OODA and wager-ledger system, and
  proves it with an acceptance checklist.

## The role a new department must internalize

Before building anything, the department (and its builder) must hold the mental model. A department is:

- an **Orient context**: its charter, knowledge, rules, skills, and memory are the frame it reasons
  from; it does not cycle faster, it holds a well-matched orientation and acts from it;
- the **owner of a slice of the board**: every observation it owns carries its `owning_department_id`,
  inherited by disposition and wager, so it sees and manages only what is theirs and learns which of
  its own components drive profit;
- a **runner of the lifecycle**: observation, routing, disposition, optional wager, action, verdict,
  improvement, on the items routed to it;
- a **maker of bets**: its consequential actions are pre-registered, business-grounded wagers scored
  against exogenous metrics, not opinions;
- a **reporter**: its daily and weekly rollup is its slice of the board aggregated;
- a **capturer**: it documents capture candidates from every conversation into its web.

Humans sit thin on top: goals, high-stakes approvals, exceptions.

## The onboarding sequence

Each step points to the detailed contract or guide; do not duplicate them here.

0. **Confirm it should be a department.** Use [[translate-business-function-into-ai-shadow-department]].
   A department is a whole-function redesign with intake-first AI, not a single tool or workflow.
1. **Write the charter.** Mission, north star, owned outcomes, constraints, reporting cadence, and a
   KPI set, per `_system/department-charter-rules.md`. The KPIs must be real metrics that wagers can
   predict and verdicts can score (map each KPI to a `metric_id` per [[metric-primitive]]); a KPI with
   no exogenous measurement is not a KPI.
2. **Build the assembly surface.** The INDEX and its components (intake surfaces, namespaces, agents,
   skills, workflows, tools, metrics, projects, human gates), per [[build-department]] and
   `_system/department-assembly-rules.md`.
3. **Wire intake, the two lanes, and ownership.** Route the department's channels through `intake/`.
   Declare the department's lane policy: which inbound patterns are deterministic (handled by rule,
   logged as `intake_event`) and which are judgment (scored, promoted to an `observation`). Ensure
   every observation routed to the department carries `owning_department_id` set to it. See
   `_system/wager-ledger-rules.md` (WAGER-12 the lanes, WAGER-16 ownership) and the intake routing maps.
4. **Stand up the head.** One head-of-department agent that conforms to
   `_system/department-head-operating-contract.md`: the stateless-per-cycle heartbeat, first-pass
   triage, the lifecycle, mechanical receipt booking, and escalation. It routes and delegates; it does
   not re-implement. How the head runs the loop with the ledger is [[department-operating-guide]].
5. **Define metrics and the first wagers.** Define the department's metrics per [[metric-primitive]],
   then decide how its consequential actions become wagers: required expected revenue and
   contribution-profit (cost-only sets revenue 0, books the saving as profit), the scope (dims), the
   comparison scenario, and the date range, so each bet is a machine-evaluable BI query. See
   [[wager-ledger-and-scientific-loop]] and `_system/wager-ledger-rules.md`.
6. **Turn on reporting.** The daily and weekly rollup, which is the department's slice of the board
   aggregated, per `entities/rules/department-head-reporting-contract.md` (WAGER-16c). Author the
   department's daily briefing (`departments/<slug>/daily-briefing.md`, the morning operator-facing render
   of that rollup) and register the department's cadence and daily briefing in
   `departments/operations-register.md` with `approval: operator-pending`. The operator approves
   per-department to activate it. See `knowledge/ai-architecture/playbooks/unified-operations-register.md`.
7. **Turn on capture.** Ambient capture of SOP, automation, skill, knowledge, and metric candidates
   into `departments/<slug>/capture/`, per `entities/rules/department-web-capture.md` and the
   department-web model.
8. **Wire the human layer.** The escalation membrane: consequential, external, or canon-touching work
   escalates per `entities/rules/result-and-escalation-contract.md` and the surfacing policy; it never
   self-approves.

## The alignment checklist (onboarding acceptance gate)

A department is correctly onboarded only when all of these are true:

- [ ] Charter exists with a north star, owned outcomes, and KPIs that each map to a `metric_id`.
- [ ] INDEX assembly surface is complete and names its components.
- [ ] The department's channels route through `intake/`; its lane policy (deterministic vs judgment)
      is declared; observations carry `owning_department_id`.
- [ ] A head agent exists and conforms to `_system/department-head-operating-contract.md`.
- [ ] At least one metric is defined per the metric primitive, and the department knows how its
      consequential actions become wagers (revenue, contribution-profit, scope, comp scenario, date
      range).
- [ ] The daily and weekly rollup emits, and it reconciles from the department's slice of the board.
- [ ] The department is registered in `departments/operations-register.md` with a `daily-briefing.md`, the
      reconcile check is clean, and the operator has approved its cadence (per-department).
- [ ] The capture rule is active (candidates land in `departments/<slug>/capture/`).
- [ ] The human escalation path is wired through the membrane; nothing self-approves canon or external
      actions.
- [ ] `bash _system/validate.sh` is clean for the department's new surfaces.

Until every box is checked, the department is onboarding, not live.

## Common onboarding mistakes

- **Human-first intake:** work reaches human inboxes before the architecture. A true department puts
  AI on the first pass.
- **Vanity charter:** KPIs that cannot be measured exogenously, so no wager can ever be scored.
- **No `owning_department_id`:** the department cannot filter the board and cannot be held accountable
  for its slice.
- **A head that re-implements:** the head should route and delegate to skills, workflows, and SOPs,
  not become a monolith.
- **Wagers scored on opinion:** a verdict the agent reasserts from memory is incestuous amplification;
  score against an exogenous metric.
- **A second backlog or a hand-maintained board:** the board is a view reconciled from receipts; never
  hand-maintain it in git.
- **Scoring everything or nothing:** route the bulk through the deterministic lane; score the residue.

## What this drives and where to go next

This guide drives every new department buildout and is the acceptance gate the builder runs. Deeper
reads: [[department-model]] (what a department is), [[department-operating-guide]] (day-to-day
operation), [[build-department]] (the assembly steps), `_system/department-charter-rules.md`,
`_system/department-assembly-rules.md`, `_system/department-head-operating-contract.md`, and
`_system/wager-ledger-rules.md` (the operating contract).

## Changelog

- 2026-06-21: authored as the new-department onboarding guide tying the buildout to the OODA and
  wager-ledger system. Operator-directed; pending final operator sign-off.
