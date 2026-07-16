---
id: "decision-ai-architecture-task-sprint-execution-model"
aliases: ["decision-ai-architecture-task-sprint-execution-model", "ai-architecture-task-sprint-execution-model", "task-sprint-execution-model"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "A sprint or run is the execution record of one assumed task. The task binds its executor via execution_sprint, the executor binds back via parent_task, execution tiers into a lightweight single-file run or a full multi-wave sprint, and the task projects to a Paperclip issue with its waves or steps as sub-issues. Operator-approved 2026-06-29."
confidence: 0.9
retrieval_class: "domain"
export_class: "internal"
decision_status: "operator-approved"
decided_on: "2026-06-29"
decided_by: "the-operator"
created: "2026-06-29"
edges:
  - target: "[[decision-ai-architecture-paperclip-boundary]]"
    relation: "extends"
    confidence: 0.9
  - target: "[[knowledge-ai-architecture-surface-boundary]]"
    relation: "constrained_by"
    confidence: 0.9
  - target: "[[knowledge-ai-architecture-canon-entity-projects]]"
    relation: "refines"
    confidence: 0.9
  - target: "[[decision-ai-architecture-wager-ledger-and-scientific-loop]]"
    relation: "feeds"
    confidence: 0.8
---

# Decision: Task-Sprint Execution Model

Operator-approved on 2026-06-29 by the-operator. Canonizes the design produced in
an internal build record (not shipped). This decision changes the operative contract
`_system/swarm-sprint-rules.md` and refines the Project entity canon; it does not yet change runtime code
(the validator lint, the company-package renderer), which is the implementation sprint.

## Context

A sprint already named one task via `parent_task`, but the link was one-way, sprints were git-only and
invisible to the runtime, and the sprint package was too heavy to be the unit an AI uses for an ordinary
task. So an AI could not assume a task and track its progress where work is actually tracked.

## Decision

1. **A sprint or run is the execution record of exactly one task.** The task carries `execution_sprint`
   (the path to its run file or sprint directory); the executor keeps `parent_task` as the singular
   reverse anchor. The two must agree (round-trip), and a `mode: swarm` task has at most one active
   executor, with `supersedes` for re-opens.
2. **Execution tiers, one lifecycle.** A lightweight single-file **run** (`swarms/Runs/YYYY-MM-DD-<slug>.md`,
   `tier: run`) for a solo, bounded, single-step-list task; the full multi-wave **sprint** directory
   (`tier: full`) for parallel, cross-cutting, or prod-mutating work. Both share the status model and the
   writeback. A selection test decides the tier.
3. **Execution projects to the runtime.** task = Paperclip issue; wave (full) or step (run) = sub-issue
   under that issue via the existing `parentId` lineage. No new Paperclip primitive; the import include
   set stays `company,agents,projects,issues`. A `sprint_status`/`run_status` to issue-status crosswalk
   makes progress legible in both planes. Structure and final status project in; live state stays runtime
   and writes back as receipts (the Paperclip boundary holds).
4. **Autonomy (L1 default): claim is auto, accept is gated, full-launch is gated.** An agent may assume
   (claim) a task and create its run without a human; a full sprint still needs a launch receipt; every
   result is human-accepted at `in_review` (no agent self-accepts). The L2 seam (auto-launch low-risk full
   sprints, auto-accept checked runs) is a separate operator decision.
5. **Framing.** This is the Act leg of the OODA loop made legible; the closeout carries a `wager:` stanza
   so each finished task feeds the wager ledger.

## Status

Canon-applied 2026-06-29 to `_system/swarm-sprint-rules.md` and `entities/projects.md`. Implementation
(run template lints, renderer extension, first operator-gated pilot projection) is pending. See the
project at an internal build project (not shipped).
