---
id: "workflow-department-daily-update"
aliases: ["workflow-department-daily-update", "department-daily-update"]
type: "Workflow"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Produces one department-level daily update from department assembly, intake, namespace state, and execution surfaces."
confidence: 0.9
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[department-model]]"
    relation: "informed_by"
    confidence: 0.91
  - target: "[[department-assembly-rules]]"
    relation: "depends_on"
    confidence: 0.9
  - target: "[[department-runtime-contract]]"
    relation: "depends_on"
    confidence: 0.86
  - target: "[[namespace-curator]]"
    relation: "references"
    confidence: 0.8
created: "2026-05-31"
runtime: "agentic"
departments:
  - "personal-health"
tools:
  - "order-ledger"
  - "example-mcp"
---

# Workflow: Department Daily Update

Produce a daily operating update for one department. The point is to make a department
explain what it saw, did, changed, escalated, and recommends next, so the AI-first
operating loop is visible and manageable.

## When to run

- once per operating day for each real department
- after a burst of important intake if the department state materially changed
- before a wider executive or cross-department rollup

## Inputs

- `departments/<department-slug>/INDEX.md`
- the department's head-of-department agent
- any namespace `INDEX.md` and canon files linked from the department assembly
- relevant intake sources and processed receipts
- any current execution surfaces the department owns

## Pipeline

### Step 1: Load the department assembly

Read `departments/<department-slug>/INDEX.md` and identify:

- the head agent
- the core namespaces
- the core workflows
- the intake sources
- the human review gates
- the daily rollup target

Do not improvise the department boundary from tags alone.

### Step 2: Gather today's changes

Gather the department's meaningful changes for the day:

- new intake items or processed receipts
- namespace updates
- active execution changes
- new open blockers, risks, or escalations
- changes in current interpretation or current-truth surfaces

If the department has no real changes, say so plainly.

### Step 3: Summarize the operating state

Write a concise daily update with these sections:

1. what came in
2. what the department processed
3. what changed in the department's current understanding or plan
4. what remains blocked or risky
5. what needs human or specialist review
6. the forward plan to advance the department's goals, with impact estimates (Step 3b)

### Step 3b: Build the forward plan and estimate impact

The daily update is not only a status report. It proposes how the department will advance its charter
goals next, using whatever mechanism best fits, and estimates the impact of each proposed action so the
operator and the fleet coordinator can prioritize. Read the department's `CHARTER.md` (north star, owned outcomes,
KPIs) so the plan is goal-directed, not task-chatter.

Produce a short ranked plan (three to five actions, fewer when the day was quiet). For each action:

- **Goal advanced**: the north-star outcome or KPI from `CHARTER.md` this action moves.
- **Mechanism**: how it would run, preferring the most autonomous mechanism that fits, from
  `knowledge/ai-architecture/concepts/choosing-the-right-primitive.md`: an existing SOP under
  `departments/<slug>/sops/`, an n8n deterministic automation, an agent, agent workflow, or loop, a
  department project task, or a human-gated step when judgment or approval is required. Name the
  specific asset, not a vague intent.
- **Impact estimate**: a low, medium, or high band on charter-alignment and stakes, plus the count of
  other work this unblocks (dependency-unblocking) and the rough effort. Use the signal vocabulary in
  `entities/rules/signal-vocabulary.md`; do not invent a new scoring scheme. State the assumption the
  estimate rests on in one clause so it is falsifiable. A consequential forward move should graduate
  this assumption into a pre-registered wager (`_system/wager-ledger-rules.md`,
  [[department-operating-guide]]): the impact estimate becomes expected revenue and contribution-profit,
  the assumption becomes the predicted metric, scoped and scored against an exogenous comparison.
- **Hard flags**: `external` and `canon-touching`. Any flagged action is proposed but gated; it
  surfaces for approval per `entities/rules/surfacing-policy.md` rather than running first-pass.

Rank the actions by the priority model in `entities/rules/priority-model.md` (impact and
dependency-unblocking up, effort down, deadlines and blockers respected). The top action is the
department's single most important next move; the rest are the ordered plan. Keep impact estimates
honest and comparable across days: a band, an unblock count, and the assumption, not a fabricated number.

### Step 4: Save the update

Save to:

```text
outputs/departments/<department-slug>/daily-update/<YYYY-MM-DD>.md
```

This workflow follows the department output placement contract in `outputs/departments/README.md`.

Required frontmatter shape:

```yaml
---
id: "output-department-daily-update-<department-slug>-<date>"
type: "Output"
namespace: "ai-architecture"
lifecycle_state: "scratch"
summary: "Daily operating update for the <department-slug> department on <date>."
confidence: 0.7
retrieval_class: "ephemeral"
export_class: "internal"
produced_by: "[[workflow-department-daily-update]]"
created: "<date>"
department: "<department-slug>"
---
```

### Step 5: Hand off to rollup if requested

If a cross-department or executive rollup is requested, pass the resulting output to
``department-daily-rollup``.

## Notes

- This workflow is assembly-first. It reads the department surface, then the linked
  namespaces and workflows.
- It should not invent runtime telemetry that is not present in the repo or runtime inputs.
- It is compatible with future Paperclip department dashboards because the output shape is
  explicit and repeatable.
