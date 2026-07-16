# Wager Ledger Rules

Operative rules for the wager ledger and the Act-to-Orient feedback plane. This file owns the
checkable contract for how the brain books its work as a scientific process: every consequential
action can carry a pre-registered, falsifiable prediction (a wager) that is later scored against an
exogenous result and diagnosed, with results backflowing to component health. The reasoning lives in
[[decision-ai-architecture-wager-ledger-and-scientific-loop]], [[feedback-plane-act-to-orient-loop]],
[[metric-primitive]], [[surface-boundary]], and [[correction-loop-absorption]]. The concrete build
is an internal build project (not shipped).

Scope: this file governs the durable contract and the plane boundary. It does not govern the runtime
database internals or the deferred-evaluation scheduler, which live in the operational and analytical
substrates.

## Reuse first (locked)

Rule WAGER-1: the lifecycle is `observation -> routing -> disposition -> wager -> verdict ->
improvement`, and it reuses existing contracts rather than inventing parallels. observation reuses
`intake/schemas/intake-record.md`; routing reuses `intake/schemas/routing-decision.md`; disposition
reuses `intake/schemas/processed-receipt.md` and the planning
ladder; the action result reuses the result envelope in
`entities/rules/result-and-escalation-contract.md`; the nine signals reuse
`entities/rules/signal-vocabulary.md`; the predicted number reuses the metric primitive. These are not
re-declared here.

Rule WAGER-2: three core lifecycle records are new: `wager`, `wager_verdict`, `component_touch`. The
2026-06-19 review added two more by deliberate operator decision: `intake_event` (the
deterministic-lane audit log) and `wager_metric` (the secondary-metric list per wager). Adding any
further record is a change to this file, not a per-department improvisation.

## Two intake lanes (locked)

Rule WAGER-12 (lane gate before scoring): inbound items pass a cheap deterministic classifier first.
An item that matches a known pattern with a deterministic handler (spam, newsletter, receipt,
duplicate, known-sender-known-action) takes the **data-handling lane**: routed or handled by rule and
recorded as a lightweight log entry, often aggregated, with no four-signal score, no wager, and no
lifecycle. Only the residue (ambiguous, potentially novel, or potentially actionable) takes the
**judgment lane** and gets the orientation scoring and the full lifecycle. The lane is stored on the
observation as `lane` (deterministic or judgment). Scoring is what happens to items that survive the
filter, not the first thing that happens to every item. This keeps the OS optimized for data handling
and routing as well as for OODA, and it is more Boyd-faithful: routine flows through implicit
guidance, novelty through explicit orientation.

Rule WAGER-12b (audit the deterministic lane): every inbound item, both lanes, writes one thin
`intake_event` row (source, received_at, classifier verdict, lane, handler or disposition reference).
Deterministic-lane items may be aggregated and retention-capped, but they are never invisible: the log
makes auto-handling auditable, lets review sample for mis-classification, and lets the classifier rules
be scored and improved like any other component. Judgment-lane events link to the full `observation`
they promote into.

## The three new records (locked shapes)

Rule WAGER-2a, `wager` (git, immutable): `wager_id`, `disposition_id`, `result_id`,
`expected_revenue_impact`, `expected_contribution_profit_impact`, `comp_scenario` (prior_period,
budget, target, benchmark, or control_holdout), `baseline_ref` (which prior period, budget version,
target value, or benchmark), `dataset` (the BI dataset to query, for example a client analytics dataset),
`scope` (the dims to filter, for example source=amazon, sku_category=fragrance, region),
`date_range_start`, `date_range_finish`, `confidence`, `evaluate_at` (when the verdict runs), `basis`,
`pre_registered_at`, `registered_by` (principal), `status` (open, due, evaluated). Revenue and
contribution-profit are always required; a cost-only action sets revenue to 0 and books the cost
saving as the profit impact. Secondary metrics are `wager_metric` child rows, not columns here.

Rule WAGER-2b, `wager_verdict` (score in the analytical plane, diagnosis in git): `wager_id`,
`evaluated_at`, `actual_revenue`, `actual_contribution_profit`, `secondary_actuals` (per `metric_id`,
matching the `wager_metric` rows), `ground_truth_source`, `ground_truth_confidence`, `result` (hit,
miss, partial), `surprise`, `diagnosis`, `hard_to_vary`, `reorientation_candidate_ref`. Each actual is
measured over the wager's `date_range_start` to `date_range_finish` against its `comp_scenario` and
`baseline_ref`.

Rule WAGER-2c, `component_touch` (git edge): `touch_id`, `disposition_id` or `wager_id`,
`component_type`, `component_id`, `orient_role` (tradition, previous-experience, analysis-synthesis,
substrate), `role` (load-bearing, incidental).

Rule WAGER-2d, `wager_metric` (git, append-only, child of `wager`): `wager_metric_id`, `wager_id`,
`metric_id`, `predicted_magnitude`, `unit`, `comp_scenario` (defaults to the wager's). One row per secondary metric a wager
predicts (sessions, AOV, reactivation rate). Revenue and contribution-profit stay on the wager as
required columns; every other predicted metric is listed here so a wager can predict many metrics and
be sliced by them.

Rule WAGER-2e, `intake_event` (git, append-only, both lanes): `event_id`, `source`, `received_at`,
`classifier_verdict`, `lane` (deterministic or judgment), `handler_or_disposition_ref`. The audit log
of WAGER-12b. Judgment-lane rows link forward to an `observation`.

The analytical views `item_lifecycle`, `component_health`, and `calibration` are computed projections,
never hand-written tables.

## Disposition shape and chaining (locked)

Rule WAGER-15a (disposition is the umbrella, by reference not duplication): `disposition` is the
determination of how an observation is handled. It does not duplicate the realized entity; it points
to it. Shape: `disposition_id`, `observation_id`, `parent_disposition_id` (self, nullable),
`type` (task, knowledge, charter, architecture, swarm, reject), `target_type` and `target_id` (the
realized entity: a task in the planning ladder, a knowledge node in the graph, a charter change),
`pkm_flag` (true for charter and architecture, the folded pkm-opportunity), `status`. Adding a new
disposition type is a new `target_type` plus its own entity, not a change to this shape. The name
`disposition` is the standard records term and is kept on purpose; `action`, `decision`, and `outcome`
each collide with Act, Decide, and the result envelope.

Rule WAGER-15b (dispositions chain; the wager attaches to the terminal action): a `swarm` (or
investigate) disposition is non-terminal. Its job is to decide a course of action; on completion it
spawns a child disposition (`parent_disposition_id` set) that is the actual action. The wager attaches
to that terminal action disposition, never to the investigate one. This is the explicit Decide loop:
when the right action is unknown, the disposition is to run the loop, and its output re-enters as a
refined, bettable disposition.

## Department ownership (locked)

Rule WAGER-16a (department is a conformed dimension): the department is a first-class dimension, the
existing `departments/` layer (each with its INDEX and CHARTER). The `observation` carries an
`owning_department_id`, and its `disposition` and `wager` inherit it, so a department filters the whole
board (`item_lifecycle`, `component_health`, `calibration`) by its id to see exactly what is theirs and
what it should be managing. `routing_decision` records the routing act that set the owner. Sliced this
way, component health and calibration tell each department which of its own components drive profit.

Rule WAGER-16b (one owner per observation; the split resolves the many-to-many): an observation has
exactly one owning department, matching the single-accountable-owner doctrine. When one inbound item
matters to several departments or several use cases, the intake split fans it out: `intake_event` 1 to
many `observation`, one observation per department or use case, each single-owned. There is no
observation-to-department bridge; the fan-out is the split, and each owner runs its own
orient-decide-act and books its own dispositions and wagers. Optional cross-department collaboration is
named on the disposition, not by multiplying owners.

Rule WAGER-16c (the rollup is a department slice): a department's daily and weekly rollup is a
department-filtered projection of this model. Its intake, processed, changed, blocked, next, and health
are slices of `item_lifecycle` and the wager outcomes for that `department_id`. Department reporting and
the ledger are the same data at two grains, so the rollup reconciles from the ledger and is never a
second source.

## The four scientific constraints (locked)

Rule WAGER-3 (falsifiable, business-grounded, query-ready): a wager must fully specify how it will be
evaluated: a `dataset`, a `scope` (the dims to filter), a `comp_scenario` with its `baseline_ref`, a
`date_range_start` and `date_range_finish`, the predicted metrics with values (`wager_metric` rows),
and a confidence. It must always state `expected_revenue_impact` and
`expected_contribution_profit_impact`; a cost-only action sets revenue to 0 and books the cost saving
as the profit impact (pure profit). A wager that does not specify enough to compile an evaluation
query, or that states no money impact, is rejected. Specifying these fields is exactly what lets the
verdict be computed deterministically or by a cheap model rather than an expensive reasoning model
(see WAGER-9b).

Rule WAGER-4 (pre-registered and immutable): the prediction is written before the outcome is known and
is never edited afterward. A later change is a new wager, not an edit. The git append-only record is
the pre-registration artifact.

Rule WAGER-5 (measured, not asserted): a verdict scores against a source exogenous to the agent's own
orientation and records that source and its confidence. A verdict the producing agent reasserts from
memory is invalid. This is the guard against the incestuous-amplification failure.

Rule WAGER-6 (hard to vary): the verdict diagnosis must be an explanation that is hard to vary, not a
just-so story, and the `hard_to_vary` flag records whether it meets that bar.

## The plane boundary (locked)

Rule WAGER-7: git holds the contracts, the per-item receipts, the immutable pre-registered wagers, the
component touch-edges, and the promoted verdict diagnoses. The analytical plane holds the queryable
fact tables, the verdict scores, and the rolling views. Per [[surface-boundary]], the analytical
tables are a projection reconcilable from git, never a second source of truth.

Rule WAGER-8 (no scores in canon): a component's rolling score never lives in its frontmatter. Git
holds the touch-edge only; the score is an analytical number, computed as a join and surfaced on
demand. This keeps canon out of the live-metrics business.

Rule WAGER-9 (analytical store default): the analytical plane defaults to a local relational database,
Postgres, owned by devops-platform and registered in `tools/port-registry.md`. Postgres over MySQL for
JSONB, richer analytical SQL, and parity with the Paperclip Postgres. The store is swappable: it may
migrate to a managed warehouse (a hosted BI platform, BigQuery) later without forking truth, because it is a
projection of git.

Rule WAGER-9b (the wager compiles to a query): because a wager carries a `dataset`, a `scope` of dims,
a `comp_scenario` with `baseline_ref`, a `date_range_start` to `date_range_finish`, and the predicted
metrics (via `wager_metric`), the BI model (the metric primitive's lineage plus your BI semantic layer) compiles it directly into a structured query and returns the actuals. The wager is a
pre-registered, machine-readable BI query, not prose, and the verdict's `actual_*` values are produced
by that compiled query, never hand-asserted (this is the mechanical form of WAGER-5). Because the spec
is complete, evaluation is cheap: a deterministic compile or a small model, not an expensive reasoning
run. Local Postgres serves the query today; a managed BI platform serves it after migration, with no change to
the wager.

## Evaluation and improvement (locked)

Rule WAGER-10 (deferred evaluation): the verdict fires at the wager's horizon via the trigger taxonomy
(`condition: wager due` or `scheduled`), not by polling.

Rule WAGER-11 (scientist recommendations are wagers): a periodic scientist review may recommend
architecture changes (skills, agents, tasks, rules, charter), and each recommendation is itself a
pre-registered wager. It recommends through [[correction-loop-absorption]] and never self-approves
canon.

## Lifecycle status and the board (locked)

Rule WAGER-13a (living rows vs append-only): `observation` and `disposition` are living rows whose
`status` column advances; `routing_decision`, `wager`, `wager_verdict`, and `component_touch` are
append-only and never updated after creation. A new row means a new distinct event; a status change is
a column advance on a living row. The current status lives in the runtime; git holds append-only
transition receipts, never an in-place edit to a canonical file.

Rule WAGER-13b (status enum): the lifecycle status is one of `captured`, `scored`, `routed`,
`orienting`, `disposed`, `wagered`, `acting`, `evaluated`, `closed`. A disposition of type task also
carries the ladder sub-status (open, in-progress, done, abandoned).

Rule WAGER-13c (the board is a view): the one place to watch items move is the `item_lifecycle` view,
a join over the records by `observation_id` showing the thread and the current status. It is a
computed projection in the analytical plane, reconciled from receipts. Git never holds the mutable
board, and there is no second backlog.

## Enforcement: mechanical, not prose (locked)

Rule WAGER-14a (book at consequential moments, by hook): a conversation does not hand-maintain the
tables. It emits a lifecycle receipt at three moments only: disposition-created, wager-registered, and
result-produced. These are captured by hooks (a closeout hook extending the session ledger, and a
PostToolUse hook on external actions), not by relying on the model to remember.

Rule WAGER-14b (reconcile, do not trust): the department heartbeat reconciles the board from canonical
state (git commits plus the runtime's executed actions). A consequential action with no receipt is a
flagged gap, not a silent loss.

Rule WAGER-14c (coverage is a tracked metric): the share of consequential actions that are booked is a
safety metric, like the mis-surface rate. It is driven up over time. Leakage is made visible and
bounded, never assumed to be zero.

## Relationship

This file is the operative contract; [[decision-ai-architecture-wager-ledger-and-scientific-loop]] is
the decision and [[feedback-plane-act-to-orient-loop]] is the spec. The doctrine root is the bridge
`knowledge/ai-architecture/synthesis/boyd-to-agent-architecture-ooda-map.md`. Charter and architecture dispositions carry a
`pkm_flag` on the disposition (the former pkm-opportunity, folded in 2026-06-19); do not invent a
separate record for them.
