---
id: "knowledge-ai-architecture-canon-entity-workflows"
aliases: ["knowledge-ai-architecture-canon-entity-workflows", "ai-architecture-entity-workflows", "entity-workflows"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Canon for the agentic Workflow entity: a repeatable reasoning pipeline in workflows/ with a named trigger, ordered steps, visible approvals, and stated outputs, used where judgment matters more than determinism."
confidence: 0.9
retrieval_class: "domain"
export_class: "internal"
verified_at: "2026-05-31"
verified_by: "operator-pending"
edges:
  - target: "[[system-overview]]"
    relation: "part_of"
    confidence: 0.9
  - target: "[[core-doctrine]]"
    relation: "derived_from"
    confidence: 0.88
  - target: "[[deterministic-workflow-boundary]]"
    relation: "bounded_by"
    confidence: 0.88
  - target: "[[deterministic-workflows]]"
    relation: "related_to"
    confidence: 0.85
created: "2026-05-31"
---

## What it is

An agentic **Workflow** is a repeatable reasoning pipeline: a Markdown definition in
`workflows/` that an agent follows step by step to produce an output. It is a governed
procedure, not a runtime graph. A workflow encodes the trigger, inputs, ordered steps with
visible approvals, and completion criteria for work that recurs but depends on open-ended
reasoning, synthesis, or review loops.

## When to use it (and when not)

Use a workflow when the same sequence of steps and handoffs will recur, the steps are
stable enough to encode, and operational consistency matters more than open-ended
exploration. Do not use a workflow when one specialist [[agents|agent]] can do the whole
job, when the work is too ambiguous and needs [[projects|project]] or swarm packaging, or
when the sequence is fully deterministic (that is a [[deterministic-workflows|deterministic
workflow]] in n8n). A workflow that masquerades as policy, or that hides its approvals, is
mis-shaped.

## Required shape

- **Folder**: canonical at `workflows/<name>.md`. Agentic workflows have no adapter mirror,
  so there is nothing to sync.
- **Frontmatter**: standard node fields plus `id: workflow-<slug>`, `type: "Workflow"`, and
  `runtime: "agentic"`. Workflows may also declare optional `party_slugs`, `client_slug`, and
  `brand_slug` when the procedure is materially tied to external commercial scope.
- **Body sections**: `## When to run`, `## Inputs`, `## Pipeline` (numbered steps with
  human approvals marked explicitly), `## Output format`, `## Notes`. Every step has a
  reason and approvals are visible.

## How it relates to the other entity types

A workflow orchestrates [[agents]] and [[skills]], reads [[knowledge-nodes]] and
[[tools]], and writes [[output-nodes]]. When part of it is fully deterministic, that
subflow is extracted to a [[deterministic-workflows|deterministic workflow]] while the
orchestration and review logic stay in the agentic workflow. When a workflow adds
evaluation and iteration, it becomes a [[workflow-loops|workflow loop]]. A workflow hangs
off a parent task on the planning ladder; it does not become a [[projects|project]] or a
parallel backlog.

This is especially useful for client or brand delivery procedures. The workflow can stay reusable
as a workflow while still declaring which parties, client, or brand it serves.

## Governing rules and doctrine

The deterministic-versus-agentic split that decides whether work is a Markdown workflow or
n8n JSON is in [[deterministic-workflow-boundary]]; the hybrid rule keeps orchestration in
Markdown and deterministic subflows in n8n. The reasoning that a workflow is a specialized
execution layer hanging off the canonical task, not an ontology change, is in
[[core-doctrine]] (the planning ladder). Operative workflow rules live in `_system/`
(`retrieval-load-order-policy`, `namespace-intake-rules`). See [[system-overview]] for how
workflows sit in the entity set.
