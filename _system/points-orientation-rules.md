# Points and Orientation Rules

Operative rules for the points and orientation primitive: the earn model, the earn-event record shape, the
value-weighting, the actor and department attribution, the ladder earn-hooks, the plane boundary, and the
Goodhart guardrail that keeps it honest against the wager ledger. This file owns the checkable contract.
The reasoning lives in [[points-orientation-currency]] (the orientation-currency theory and the
department-orientation read model) and reuses [[rule-priority-model]], [[rule-signal-vocabulary]],
[[metric-primitive]], [[surface-boundary]], and the wager ledger contract `_system/wager-ledger-rules.md`.
The concrete build is an internal build project (not shipped).

Scope: this file governs the durable contract and the plane boundary. It does not govern the runtime
score store, the streak engine, or the leaderboard, which live in the operational substrate per
[[surface-boundary]].

## Status

Candidate, `verified_by: operator-pending`. This is a new contract drafted in the build sandbox; it is not
self-approved canon. The operator signs off before it is treated as settled. Every substantive revision
gets a dated changelog entry below.

## What points are (locked intent)

Rule POINTS-1: points are a standalone orientation currency, not a personal-only scoreboard and not a
copy of the wager ledger. They do two jobs at once. They reward throughput: prioritized work moving
forward through the planning ladder and its lifecycle. They orient attention: because each award is
weighted by the item's value, accrued points tell the operator, and later a self-serving AI department,
where the highest-value work is and how much of it is actually getting done. Points are earned, not
assigned: a completion event emits them; nothing hands them out for activity that completed nothing.

Rule POINTS-1a (complementary to the wager ledger, never a second value system): the wager ledger
verifies exogenous business value (a pre-registered, falsifiable prediction scored against an outside
metric at a horizon; see `_system/wager-ledger-rules.md`). Points reward the act of completing prioritized
work and orient focus. The wager verdict is the lagging outcome signal (did the bet create value); the
points award is the leading throughput signal (is high-value work moving, and which actor moved it). They
are aligned by construction (POINTS-3 derives the points weight from the same value signals the wager
uses) but they are not the same measure, and when they diverge value wins (POINTS-7). Points never
override, replace, or re-score a wager verdict.

## The earn-event record (locked shape)

Rule POINTS-2 (`earn_event`, git, append-only, immutable): every points award is one `earn_event` record,
written once and never edited. A later correction is a new compensating `earn_event`, not an edit, mirroring
the wager ledger's pre-registration discipline (WAGER-4). Fields:

- `earn_event_id`
- `ladder_level`: one of `intake_item`, `task`, `project`, `swarm` (the four earn-hooks, POINTS-5)
- `source_type` and `source_id`: the completed entity, by reference, never duplicated: the terminal
  `disposition` or `observation` for an intake item, the `task` on the planning ladder, the `project`, or
  the `swarm` sprint. Reuses existing ids; points invent no parallel entity.
- `completion_event`: the terminal transition that triggered the award (a disposition reached a terminal
  type, a task reached `done`, a project reached `complete`, a sprint reached `complete`)
- `actor_type`: one of `human`, `ai`, `hybrid`. Required. Evidence-based (POINTS-4), never self-declared by
  the earner.
- `actor_id`: the agent id or human principal that did the work (optional detail under `actor_type`)
- `owning_department_id`: required. Inherited from the source entity's owning department, matching the
  wager ledger's conformed department dimension (WAGER-16a). This is the slice key.
- `points_awarded`: the computed weighted value (POINTS-3). A number, but an immutable per-event audit
  fact, not a rolling tally.
- `weight_basis`: the inputs behind the award (the priority signals used and the `wager_ref` expected
  value, if any), so the award is explainable in one line and auditable, mirroring the priority model's
  explainability rule.
- `wager_ref`: nullable. The `wager_id` when the completed action carried a wager, so points and the
  value verdict are joinable on the same action.
- `signals_ref`: the nine-signal snapshot (or a reference to it) the weight was computed from
  ([[rule-signal-vocabulary]])
- `earned_at`: ISO 8601 timestamp the completion fired
- `booked_by`: the hook or skill that booked the event (POINTS-8)
- `idempotency_key`: `source_type` + `source_id` + `ladder_level` + `completion_event`. One completion
  earns once; re-opening and re-closing the same entity does not farm points (POINTS-7).

The live tally, streaks, and leaderboard are computed projections over these append-only records; they are
never stored in git (POINTS-6).

## Value-weighting (locked model, weights operator-tuned)

Rule POINTS-3 (points align to value, never busywork): the award is the item's scope base scaled by its
value, computed from the same signals the priority model already uses.

```
points_awarded = base(ladder_level) * value_multiplier
value_multiplier = f(priority_signals, wager_expected_value)
```

- `base(ladder_level)` reflects scope: a swarm or project completion carries a larger base than a single
  task or intake item, because it closes more. Defaults are operator-tuned (POINTS-3a).
- `value_multiplier` is driven by the priority-model signals ([[rule-priority-model]]: stakes,
  charter-alignment, dependency-unblocking, urgency, minus effort) and, where the completed action carried
  a wager, by its `expected_contribution_profit_impact`. High-value work earns more; the value multiplier
  is strong enough that a high-value task can outweigh a low-value project, so the currency points at value
  and not at raw count.
- Busywork earns the floor: an item with low stakes, low charter alignment, no dependency unblocking, and
  no wager value earns near zero. A `reject` disposition (an intake item closed by deciding not to act)
  earns the floor: closing the loop is acknowledged, but a non-action is not value.
- The award is explainable in one line, like the priority model: "earned 8 because high-stakes task,
  unblocked three, ai-accomplished." If the award cannot be explained from the signals and these rules, it
  is wrong.

Rule POINTS-3a (weights are operator-tuned, never earner-set): the `base` table and the
`value_multiplier` weights are operator-set and reviewed on the operator's cadence, exactly like the
priority-model weights ([[rule-priority-model]] and the operator-tuning decisions). An earner, human or
agent, never sets its own weights. Defaults are documented and start conservative until tuned.

## Actor and department attribution (locked)

Rule POINTS-4 (attribution is evidence-based and required): every `earn_event` carries `actor_type`
(`human`, `ai`, or `hybrid`) and `owning_department_id`, so points slice by who did the work and which
department owns it. `actor_type` is inferred from the booked evidence of who performed the completing work
(the session actor, the result envelope's producer, the commit author), not declared by the party that
benefits from the count. `hybrid` is the honest default when both a human and an agent materially
contributed; it is not a rounding convenience. Claiming `ai` for human work, or `human` for AI work, is
the named misattribution failure mode (POINTS-7). `owning_department_id` is inherited from the source
entity and is never hand-set to move points between departments.

## The four ladder earn-hooks (locked definitions)

Rule POINTS-5 (one weighted, attributed event per ladder completion): points hang off the existing
planning ladder ([[planning-to-execution-ladder]]) and the wager-ledger lifecycle, reusing their
completion semantics rather than inventing parallel state. Each hook fires once, at a terminal transition,
and emits exactly one `earn_event`. These are definitions; the runtime that books them is deferred to
activation (POINTS-6).

- **intake item** (`ladder_level: intake_item`): fires when a judgment-lane `observation` is driven to a
  terminal `disposition` (the lifecycle reaches `disposed` or `closed`; see WAGER-13b), or when a
  processed receipt closes the item. `actor_type` is who drove the disposition; `owning_department_id` is
  the observation's owner; the weight is the item's nine signals. A `reject` disposition earns the floor.
- **task** (`ladder_level: task`): fires when a planning-ladder task reaches `done` (not `abandoned`).
  Owner and signals come from the task and its project. When the task's disposition carried a wager, the
  weight includes the wager expected value and the event sets `wager_ref`.
- **project** (`ladder_level: project`): fires when a project reaches `project_status: complete`. Higher
  base (scope). Weight from the project's aggregate value and any wagers on its terminal actions.
- **swarm** (`ladder_level: swarm`): fires when a swarm sprint reaches `sprint_status: complete`. Higher
  base. Weight from the parent task's value and the sprint's wagers. Note the complementarity: a `swarm`
  disposition is non-terminal in the wager lifecycle (WAGER-15b: it spawns a child action disposition that
  carries the wager), so the swarm `earn_event` rewards the throughput of closing the sprint, while the
  business value of what the sprint produced is verified separately by the child action's wager. Points and
  the wager verdict meet on the same work at two grains.

## The plane boundary (locked)

Rule POINTS-6 (definitions and the audit trail in git, the live tally in runtime): per [[surface-boundary]],
git holds the durable, append-only side and the runtime holds the live, mutable side.

- Git holds: this contract; the earn-event schema; the metric definition ([[metric-effectiveness-points]]);
  and the append-only `earn_event` audit trail (the immutable record that each award happened, with its
  weight, actor, department, and `wager_ref`). The audit surface and where booked receipts land is
  documented in `departments/chief-of-staff/points-ledger/README.md`.
- The runtime holds: the live tally (current point totals), streaks, inbox-zero and speed-to-task bonus
  mechanics, and any leaderboard. These are computed projections over the append-only events, recomputable
  from git, and never written into git. No live number, rolling score, or leaderboard ever enters a
  canonical file, mirroring the wager ledger's no-scores-in-canon rule (WAGER-8). The runtime score store
  is the same analytical plane the wager ledger uses (local Postgres by default, owner devops-platform,
  port-registered; WAGER-9), so points and wagers share one substrate and join cleanly.

## The Goodhart guardrail (locked, load-bearing)

Rule POINTS-7 (effectiveness-points is a diagnostic signal, not a value target): Goodhart's law states
that when a measure becomes a target it ceases to be a good measure. Because points reward throughput,
optimizing the count directly corrupts it: a party that targets points will split work into more items,
complete low-value items, re-open and re-close entities, or claim `ai` for human work. The contract guards
against this with a layered defense:

1. **Not an objective function.** Effectiveness-points ([[metric-effectiveness-points]]) is a leading,
   diagnostic signal of AI leverage and momentum. It is never the optimization target. The objective is
   exogenous value, owned by the wager ledger.
2. **Value-weighting.** Points weight derives from the priority signals and wager expected value (POINTS-3),
   so a thousand trivial completions do not outscore one high-value completion. Busywork earns the floor.
3. **Wager cross-check (the honesty governor).** Points are reconciled against wager verdicts on the same
   actions (joined by `wager_ref`). A slice that accrues high effectiveness-points while its wagers keep
   missing is doing busywork or misdirected effort, not creating value, and is flagged. When points and
   value diverge, value wins and the weighting is re-tuned (POINTS-3a). Points never re-score a wager.
4. **Misattribution guard.** `actor_type` is evidence-based, not self-declared (POINTS-4). Claiming `ai`
   for human work or inflating counts is the named failure mode; the append-only, reviewable audit trail
   makes attribution auditable after the fact.
5. **No double-earn.** The `idempotency_key` (POINTS-2) makes one completion earn once; re-opening and
   re-closing an entity does not farm points.
6. **No self-set weights.** Weights are operator-tuned (POINTS-3a), never set by the party that earns.

Rule POINTS-7a (the safety metric): the divergence between accrued effectiveness-points and wager value
(high points, low wager hit-rate) is a tracked safety signal, like the wager ledger's booking-coverage
and the membrane's mis-surface rate. When it rises, the weighting is made more conservative. The point of
the metric is to make AI leverage visible, not to be maximized.

## The system-level effectiveness-points metric (pointer)

Rule POINTS-9 (one metric node, sliced by actor and department): the aggregate, effectiveness-points by
`actor_type` by `owning_department_id` rolled up across the whole brain (intake items, tasks, projects,
swarms), is defined once as a metric-primitive node, [[metric-effectiveness-points]] (`metric_id:
effectiveness-points`), per [[metric-primitive]] and `_system/metric-primitive-schema.md`. It is defined
now and dormant until the runtime hydrates it (`instrumentation_status: not-wired`). Its honest framing is
fixed by POINTS-7: a leading, diagnostic AI-leverage signal kept honest by the wager ledger, not a value
target.

## The department-orientation read model (defined, dormant)

Rule POINTS-10 (a department reads its own points slice to choose focus, dormant): a self-serving AI
department reads its own slice of the points board (filtered by `owning_department_id`, the same way it
reads its wager-ledger slice) as a focus signal: where its high-value points concentrate, how much it is
accomplishing via `ai` versus `human` versus `hybrid` (human-heavy high-value slices are automation
candidates), and which prioritized high-weight work is not moving (the next best action). The improvement
loop is a wager: a department pre-registers a wager that a specific change (a new skill, an automation, a
rule) will raise its AI-accomplished effectiveness-points on a slice, then verifies honestly against the
wager ledger so the loop is value-checked, not points-farmed. The model is defined in
[[points-orientation-currency]] and is dormant: it requires both the points runtime store and the
wager-ledger runtime to be live.

## Enforcement: mechanical, not prose (locked)

Rule POINTS-8 (book at the completion moment, by hook): a conversation does not hand-maintain the tally.
An `earn_event` is booked mechanically at the terminal completion transition (the ladder hooks of
POINTS-5), by the same kind of hook the wager ledger uses (a closeout hook extending the session ledger
and a transition hook on completions; WAGER-14a). A coach skill books the
event when it confirms a completion in a coaching loop (design; nothing books points yet). The heartbeat reconciles the tally from the
append-only events and flags any completion with no `earn_event`, exactly as the wager ledger reconciles
unbooked consequential actions (WAGER-14b). Booking coverage is a tracked metric (WAGER-14c).

## Runtime exclusion (locked)

Per [[surface-boundary]] and the swarm-sprint runtime-exclusion rule, these never become authoritative git
state: the live point tally, streaks, the leaderboard, in-flight bonus state, and any runtime event
stream. Git keeps the contract, the append-only `earn_event` audit trail, the metric definition, and
bounded writeback only.

## Relationship

This file is the operative contract; [[points-orientation-currency]] is the reasoning (the
orientation-currency theory, the Goodhart reasoning, and the department-orientation read model). It is the
throughput-and-orientation complement of the wager ledger's value truth: `_system/wager-ledger-rules.md`
owns the falsifiable value verdict, this file owns the weighted, attributed completion award, and POINTS-7
binds them so the points never drift from value. A chief-of-staff coach skill and command are the intended operator-facing coach that ranks
the backlog, surfaces the next best action, and books the earn-event on completion (design
only; not shipped).

## Changelog

- 2026-06-25: drafted as the operative points-and-orientation contract in an internal build
  sprint (records not shipped).
  Candidate, `verified_by: operator-pending`; no self-approved canon. Locks the earn model, the
  `earn_event` shape, the value-weighting, actor and department attribution, the four ladder hooks, the
  plane boundary, the Goodhart guardrail, the metric pointer, the dormant department-orientation read
  model, and the wager-ledger relationship.
