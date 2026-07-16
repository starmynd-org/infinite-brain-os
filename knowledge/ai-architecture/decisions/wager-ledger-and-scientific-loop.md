---
id: "decision-ai-architecture-wager-ledger-and-scientific-loop"
aliases: ["decision-ai-architecture-wager-ledger-and-scientific-loop", "wager-ledger-and-scientific-loop", "wager-ledger"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Adopt the wager ledger and the scientific feedback loop as a planned core primitive: every consequential item that flows through the system (intake to routing to disposition to action) can carry a pre-registered, falsifiable prediction tied to a metric, which is later scored against an exogenous result and diagnosed. This makes the Infinite Brain the bookkeeping layer for AI harnesses, the durable hypothesis-action-result ledger that sits under any replaceable harness. It is the operating instance of the boyd-deutsch error-correction engine and the implementation of the feedback-plane spec. Proposed as a decision, operator-gated; it enters canon only after it runs."
confidence: 0.82
retrieval_class: "domain"
export_class: "internal"
verified_at: "2026-06-18"
verified_by: "the-operator"
edges:
  - target: "[[knowledge-ai-architecture-canon-core-doctrine]]"
    relation: "extends"
    confidence: 0.88
  - target: "[[feedback-plane-act-to-orient-loop]]"
    relation: "implements"
    confidence: 0.9
  - target: "[[metric-primitive]]"
    relation: "depends_on"
    confidence: 0.88
  - target: "[[planning-to-execution-ladder]]"
    relation: "depends_on"
    confidence: 0.85
  - target: "[[correction-loop-absorption]]"
    relation: "feeds"
    confidence: 0.85
  - target: "[[surface-boundary]]"
    relation: "bounded_by"
    confidence: 0.88
  - target: "[[infinite-brain-control-model]]"
    relation: "bounded_by"
    confidence: 0.85
created: "2026-06-18"
---

# Wager Ledger and the Scientific Feedback Loop

## Summary

Adopt, as a planned core primitive, a single lifecycle in which every consequential item that flows
through the system can carry a falsifiable, pre-registered prediction (a **wager**) tied to a metric,
which is later scored against an exogenous result and diagnosed. This closes the Act-to-Orient
feedback arrow, the structurally weakest part of the brain read as an OODA web, and it makes the
Infinite Brain the **bookkeeping layer for AI harnesses**: the durable hypothesis, action, and result
ledger that sits under any harness and survives a harness change, per the harness-portability
doctrine in [[infinite-brain-control-model]].

This is the operating instance of doctrine the brain already holds. Core-doctrine says a decision is
a hypothesis, action is the test, and feedback updates orientation; an internal synthesis note (not shipped) reconciles Boyd's destruction-and-creation with
Deutsch's conjecture-and-criticism. The wager ledger takes those sentences literally. It is the
build-out of [[feedback-plane-act-to-orient-loop]]; the concrete schema, phasing, and tasks live in
an internal build project (not shipped).

## The decision

The brain treats the flow of work as a scientific process and books it. One lifecycle, reusing the
existing intake, planning, and result contracts rather than inventing parallels:

```text
observation -> routing -> disposition -> (wager attached) -> action -> verdict -> improvement
```

- **observation**: a captured intake item (the existing intake record). The raw Observe input.
- **routing**: the existing routing decision sends it to a department and names its disposition type.
- **disposition**: what it becomes, on the existing planning ladder: a task (which may belong to a
  project or a swarm-ai), a knowledge update, rarely a department-charter change, very rarely an
  AI-architecture change for the department, or a rejection.
- **wager**: a consequential disposition carries a pre-registered prediction tied to a metric.
- **verdict**: at the horizon, the prediction is scored against an exogenous result and diagnosed.
- **improvement**: a surprising or wrong verdict raises a correction-to-structure candidate
  ([[correction-loop-absorption]]); a periodic scientist agent recommends architecture changes.

## The four constraints that make it scientific, not self-flattering

1. **Falsifiable.** A wager must commit to a checkable claim: a metric, a direction or threshold, and
   a horizon. "This will help" is rejected. "Metric X up 15 percent within 30 days" is accepted.
2. **Pre-registered.** The prediction is recorded, immutable and timestamped, before the outcome is
   known. In a git-backed append-only ledger this is nearly free, and it is what prevents hindsight
   bias. This is a structural advantage of the brain, not an add-on.
3. **Measured, not asserted.** The result comes from a source exogenous to the agent's own
   orientation. A verdict the agent reasserts from memory is not interaction with reality, it is the
   incestuous-amplification failure Boyd names. Every verdict records its ground-truth source and that
   source's confidence.
4. **Hard to vary.** The diagnosis ("why right or wrong") must be an explanation that cannot be easily
   wiggled out of (the Deutsch bar), not a just-so story. The quality of re-orientation depends on it.

The headline metric over the whole ledger is **calibration**: when the system states confidence 0.8,
is it right 80 percent of the time. Calibration rolls up from the component-health view.

## Boundaries (where each thing lives)

This respects the three-plane split and [[surface-boundary]]:

- **Git** holds the contracts and schemas, the per-item durable receipts, the immutable
  pre-registered wagers, the component touch-edges (provenance), and the meaningful verdict diagnoses
  promoted as correction-to-structure candidates.
- **The analytical plane** holds the queryable BI fact tables, the verdict scores, and the rolling
  component-health and calibration rollups. It defaults to a **local relational database (Postgres)**,
  owner devops-platform, with a managed warehouse (a hosted BI platform, BigQuery) as a later migration. It is
  a swappable surface per [[surface-boundary]]: a projection reconcilable from git, never a second
  source of truth, so the store can change without forking truth. Postgres over MySQL for JSONB (the
  signals and payloads), richer analytical SQL, and parity with the existing Paperclip Postgres.
- **The runtime substrate** holds live wager state (open, due, evaluated) and the deferred-evaluation
  scheduler, which reuses the existing trigger taxonomy (`condition: wager due`, or `scheduled`).

Component scores never live in canon frontmatter. Git holds only the touch-edge (this action touched
rule or skill X). The score is an analytical number, computed as a join of touch-edges against
verdicts, surfaced on demand. Putting scores in frontmatter would make canon a mutable metrics store,
which the surface boundary forbids.

## The ground-truth dependency, in two tiers

The ledger is only as good as the result it scores against, and that source is a Data System namespace
plus a tool pointer feeding the [[metric-primitive]]. Two tiers:

- **Operational tier (available now):** acceptance-gate pass, deploy held, operator accept or reject
  or override, promoted-item-actually-used. Already exogenous and already emitted in receipts. The
  loop ships on this tier first.
- **Business tier (later):** revenue and client outcomes, pulled by API into the same local Postgres
  to start. A managed BI wrapper is an upgrade a deployment can migrate to, not a prerequisite:
  local Postgres is the free default tier.

## Component attribution, with the known traps

Tagging which components shaped an action and backflowing the verdict is the highest-value and most
dangerous part. Guard against: confounding (a component looks bad because it is used on hard problems),
attribution noise (distinguish load-bearing from incidental touches), and gaming (once scored, the
system may avoid low-scored components even when correct, which ossifies orientation). Start coarse and
do not over-trust early, low-power scores.

## The scientist role, and the recursion

A periodic agent reviews evaluated wagers, scores calibration, runs the deliberate deep-dive diagnosis
on high-surprise or high-stakes wagers, and recommends AI-architecture improvements (new or revised
skills, agents, tasks, rules, or charter tweaks). It is the slow Deutsch deep-dive complementing the
fast operational verdict. Two rules:

- **Its recommendations are themselves wagers.** "Revising skill X will lift metric Z" is a
  pre-registered hypothesis that gets evaluated. The system improving itself is subject to the same
  method, which also keeps it honest.
- **It recommends, it never self-approves canon.** Recommendations flow through
  [[correction-loop-absorption]] and the operator gate.

A later novelty layer injects variation (new ideas, brainstormed alternatives) into the flow. Frame it
precisely: the wager ledger is the selection pressure, novelty is the variation pressure, and variation
without selection is noise. Build selection first; novelty depends on being able to score what it
generates.

## Why this is not canon yet, and how it relates to 15.2

Canon describes the system as it runs (core-doctrine section 14), so this is proposed as a decision and
tracked as a project, and it promotes into canon only after it is built, verified, and operator
approved. It is consistent with section 15.2: this imports the missing governor (a real feedback and
accountability loop), it does not make Boyd the control model of record. The OODA framing is the lens;
the wager ledger is the operating capability.

## Refinements (2026-06-19)

Three refinements from operator review, folded into `_system/wager-ledger-rules.md`:

- **Two intake lanes.** Not every item is scored. A deterministic data-handling lane routes the bulk
  (spam, newsletters, receipts, duplicates) by rule with a lightweight log; only the judgment-lane
  residue is scored and enters the lifecycle. The OS is optimized for data handling and routing as
  well as for OODA, and this is more Boyd-faithful: routine flows through implicit guidance, novelty
  through explicit orientation.
- **Status board as a view, not new tables.** `observation` and `disposition` are living rows with a
  `status` enum; `routing_decision`, `wager`, `wager_verdict`, and `component_touch` are append-only.
  The watchable board is the `item_lifecycle` view, reconciled from receipts, not a hand-kept git file.
- **Enforcement is mechanical, not prose.** Conversations do not hand-update tables. Hooks book a
  receipt at disposition-created, wager-registered, and result-produced; the heartbeat reconciles and
  flags unbooked consequential actions; booking coverage is a tracked safety metric.
- **Wagers are business-grounded and machine-evaluable; the deterministic lane is audited.** Every
  wager states expected revenue and contribution-profit impact, a `scope` (dimensions like source and
  sku_category), and a `comparison_basis` (MoM, YoY, prior period, custom, or control_holdout);
  secondary metrics (sessions, AOV) are `wager_metric` child rows. Because those fields are structured,
  the BI model (metric-primitive lineage plus your BI semantic layer) compiles the wager into a
  query and returns the actuals, so the verdict is computed, not hand-asserted. Every inbound item,
  both lanes, writes a thin `intake_event` row so deterministic auto-handling is auditable and the
  classifier is self-improvable. Five new tables total: the three core plus `intake_event` and
  `wager_metric`.

## Status

Ratified design, operator-approved (the-operator, 2026-06-18): the three-table model, the
git-versus-Postgres boundary, and local Postgres as the initial analytical store are accepted. The
operative contract is `_system/wager-ledger-rules.md`; the concrete build is
an internal build project (not shipped). This decision node stays `lifecycle_state:
research` (the repo idiom for an operator-verified decision, as core-doctrine itself uses). It enters
the keystone `core-doctrine.md` only through the separate, still-open canon-candidate
`canon-candidate-ooda-orientation-lens`; canon is never self-approved.

## Changelog

- 2026-06-18: authored as a proposed decision (the OODA-to-architecture work).
- 2026-06-18: design ratified by the operator (three-table model, git-versus-Postgres boundary, local
  Postgres initial). Operative contract `_system/wager-ledger-rules.md` authored; project moved to
  active.
- 2026-06-19: folded in two-lane intake, the status board (view), and mechanical enforcement
  (operator review).
- 2026-06-19: business-grounded, BI-compilable wager schema (required revenue and contribution-profit,
  scope, comparison basis, `wager_metric`), the `intake_event` deterministic-lane audit log, and the
  wager-compiles-to-a-query rule (operator review).
- 2026-06-19: made wagers fully query-ready: `comp_scenario` + `baseline_ref`, `date_range_start` and
  `date_range_finish`, `dataset`; cost-only actions set revenue to 0 and book the saving as profit; the
  complete spec lets evaluation run deterministically or with a cheap model. `pkm_opportunity` folded
  into `disposition` as a `pkm_flag` (operator review).
