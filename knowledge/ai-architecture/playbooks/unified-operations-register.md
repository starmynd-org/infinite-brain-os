---
id: "playbook-unified-operations-register"
aliases: ["playbook-unified-operations-register", "unified-operations-register"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "candidate"
summary: "The unified operations register: one department-stamped, aggregated review-and-drive surface for every department's recurring operations (daily, weekly, monthly, quarterly, day-startup, day-closeout, condition, on-call) plus its daily briefing. Defines the aggregate-view source-of-truth model (departments author and own their OPERATIONS rows; the register is a reconcilable projection), the per-department approval gate, the day-level startup and closeout phases, and how the /daily-startup and /daily-review commands consume it. A core ai-architecture primitive and a required department-buildout step."
confidence: 0.8
retrieval_class: "domain"
export_class: "internal"
verified_at: "2026-06-28"
verified_by: "operator-pending"
edges:
  - target: "[[department-onboarding-guide]]"
    relation: "extends"
    confidence: 0.88
  - target: "[[department-head-reporting-contract]]"
    relation: "depends_on"
    confidence: 0.85
  - target: "[[trigger-taxonomy]]"
    relation: "depends_on"
    confidence: 0.9
  - target: "[[department-web]]"
    relation: "depends_on"
    confidence: 0.82
  - target: "[[build-department]]"
    relation: "paired_with"
    confidence: 0.85
created: "2026-06-28"
---

# Unified Operations Register

## What it is

One department-stamped surface that aggregates every department's recurring operations into a single place
the operator can review, approve, and run his day from. It answers, in one read: what runs daily, weekly,
monthly, and quarterly across all departments, what runs at the start and the close of the operating day,
which department owns each task, and which department's cadence the operator has approved. It is the human
firing mechanism the fleet currently lacks: nothing yet fires a department's `scheduled:` rows without a
human (a clock-firing runtime is a later, staged build), so the operator
reads this register at the start and close of the operating day and drives the day from it.

The register lives at `departments/operations-register.md`.

## Source-of-truth model (aggregate view, not a second backlog)

The register is a **projection**, not a new source of truth. This keeps it inside the brain's hard rule
that nothing is a second source of truth and everything reconciles from canon (see [[core-doctrine]] and
the three-plane truth split).

- **Departments author and own their tasks.** Each task is defined once, in its owning department's
  `departments/<slug>/OPERATIONS.md`, using the `entities/rules/trigger-taxonomy.md` vocabulary. That file
  remains the authoritative owner, per the department-web model.
- **The register aggregates them, stamped by department.** Every register row carries its
  `owning_department`. The register adds no task that is not authored in some department's OPERATIONS, and a
  department's OPERATIONS rows all appear in the register.
- **A validator check keeps them reconciled.** `_system/checks/operations-register-reconcile-check.sh`
  (warn-only) flags drift: a department with an OPERATIONS file that is missing from the register, or a
  register block that points at a department with no OPERATIONS file. Row-level reconciliation is a
  follow-on.
- **Live run state never enters the register or git.** Whether today's task actually ran, failed, or is
  blocked is runtime state, per `_system/department-runtime-contract.md`. The register says what should run
  and when; it is never the live checklist.

## Cadence taxonomy and the day phases

The register groups tasks by the `entities/rules/trigger-taxonomy.md` triggers: `scheduled: daily`,
`scheduled: weekly`, `scheduled: monthly`, `lifecycle: on-startup`, `lifecycle: on-closeout`, `condition:`,
and `on-call:`. Quarterly work runs on the `scheduled: monthly` trigger with a once-per-quarter note (no new
trigger type is invented).

On top of the trigger, each daily task carries a **day phase** for presentation, so the day-level commands
know what to surface when. The day phase is a register-and-command grouping, not a new trigger type:

- **day-startup**: the daily tasks that open the operating day (for example the morning briefing and the
  day plan). Surfaced by `/daily-startup`.
- **during**: the daily tasks that run through the day (for example log pulls and adherence checks).
- **day-closeout**: the daily tasks that close the operating day (for example the evening review and the day
  score). Surfaced by `/daily-review`.

The day phase is distinct from the session lifecycle rows (`lifecycle: on-startup` and
`lifecycle: on-closeout`), which are per AI-session edges, not per operating-day edges.

## The approval gate (per department)

Each department block in the register carries one approval stamp: `approval: operator-pending` or
`approval: operator-approved (YYYY-MM-DD)`. The operator approves a department's whole cadence at once.
Until a department is approved, its cadence is registered but not active, and the day-level commands list
its tasks as pending-approval rather than driving them. The approval stamp is the operative form of the
operator's "I want my human approval on these" requirement: the register is the one place he reviews and
approves every department's daily, weekly, monthly, quarterly, startup, and closeout tasks.

## Actor and human responsibilities

Every cadence row carries an `actor`: who performs it.

- `ai` (the default, may be omitted): the department performs it.
- `hybrid`: the AI prepares or proposes and the operator decides (approve intake routing, approve vendor
  spend, approve a plan change, review and accept the executive brief).
- `human`: only the operator can do it, with no AI hand-off (a clinical test, a call, a judgment with no
  prep).

`actor` is distinct from the hard flags (`external`, `canon-touching`), which say whether a task touches the
outside world or canon, not who performs it.

Each task is still authored once in its owning department's OPERATIONS row. Department-scoped human tasks
live in that department; cross-cutting personal responsibilities not tied to one department live in
`chief-of-staff` (the operator-attention department), tagged `human`.

Each department declares its `human` and `hybrid` items in a `## Human responsibilities` subsection in its
OPERATIONS (the per-department source, placed alongside `## Intake watch`). The **human responsibilities
view** aggregates those subsections, grouped by cadence (daily, weekly, monthly, quarterly, day-startup,
day-closeout) and stamped by department, rendered at the TOP of `departments/operations-register.md`. It is
the operator's own checklist: what only he can do or must decide, on each cadence, plus the standing
approvals surfaced as they arise through the chief-of-staff executive brief. Like the rest of the register it
is a reconcilable projection, not a second list; the reconcile check can later assert it matches the
subsections. If it outgrows the register header, split it into a dedicated
`departments/human-responsibilities.md` (same projection, its own file).

## How the commands consume it

- **`/daily-startup`** reads the register and assembles the operating-day plan: the operator's
  human-responsibilities checklist first, then the active project and sprint backlog (active
  `projects/*/PLAN.md` and open `swarms/Sprints/*`, each with its next action and blocked-on-operator
  status), the approved `day-startup` and
  `during` daily tasks across all departments, each department's morning daily briefing rolled into the
  one executive brief, plus any weekly, monthly, or quarterly task due today. It reconciles with the
  session `start-session` command and the personal `daily-brief` command rather than duplicating them.
- **`/daily-review`** runs the end of the operating day: the approved `day-closeout` tasks, collection of
  each department's daily briefing and rollup into the executive brief, and the day score into the points
  system. It reconciles with the `close-session` command and the evening review.

Both commands only drive approved departments; they surface unapproved departments' cadence as pending so
nothing runs without the operator's sign-off.

## The daily briefing requirement

Every department emits one daily briefing, specified in `departments/<slug>/daily-briefing.md`:
a morning push with a one-glance summary band on
top and the detailed sections below (the detail is the agent proving its work). The briefing is the
operator-facing render of the department's daily rollup
(`entities/rules/department-head-reporting-contract.md`) and feeds the chief-of-staff executive brief, so
the operator reads one consolidated brief instead of one per department.

## Department-buildout requirement

Onboarding a department (per [[department-onboarding-guide]] and [[build-department]]) now includes:

1. author the department's cadence in `departments/<slug>/OPERATIONS.md` (daily, weekly, monthly,
   quarterly, the two session lifecycle rows, the day-startup and day-closeout daily rows, plus condition
   and on-call rows), with an `## Intake watch` list and a `## Human responsibilities` subsection declaring
   its `human` and `hybrid` operator items;
2. author `departments/<slug>/daily-briefing.md` from the template;
3. register the department's cadence block in `departments/operations-register.md` with
   `approval: operator-pending`;
4. the operator approves the department's cadence (per-department), which flips the stamp to
   `operator-approved (date)` and activates it for the day-level commands.

A department is not operating-ready until its cadence is registered and approved.

## Status and promotion

This playbook is a canon candidate (`verified_by: operator-pending`). It is built and usable in this
personal working repo; promotion to canon, and any reconciliation it forces in
`entities/rules/department-head-reporting-contract.md` or `entities/rules/trigger-taxonomy.md`, is the
operator's gated decision per [[core-doctrine]] (no self-approved canon).

## Changelog

- 2026-06-28: authored as the unified operations register primitive (operator-directed: one place to review
  and approve all departments' recurring tasks, stamped by department, driving /daily-startup and
  /daily-review). Pending operator sign-off.
