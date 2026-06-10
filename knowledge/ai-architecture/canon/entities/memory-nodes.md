---
id: "knowledge-ai-architecture-canon-entity-memory-nodes"
aliases: ["knowledge-ai-architecture-canon-entity-memory-nodes", "ai-architecture-entity-memory-nodes", "entity-memory-nodes"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Canon for the Memory node: a reviewed learning distilled from experience or intake triage, the durable home for something learned the hard way, distinct from raw logs and from settled doctrine."
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
  - target: "[[correction-loop-absorption]]"
    relation: "related_to"
    confidence: 0.85
  - target: "[[knowledge-nodes]]"
    relation: "related_to"
    confidence: 0.82
created: "2026-05-31"
---

## What it is

A **Memory node** is a reviewed learning. It lives in `memory/` and holds something learned
from experience or from intake triage: a pattern, a mistake and its fix, a hard-won lesson
that should change future behavior. Memory is distilled, not raw. Execution logs from n8n or
Paperclip stay in those tools; the reviewed lesson drawn from a log becomes a memory node.
Memory is the layer where the brain remembers what it learned rather than re-deriving it.

## When to use it (and when not)

Create a memory node when a lesson from real work should persist and shape later decisions,
especially something learned the hard way. Do not create a memory node for a raw operational
log, an unprocessed intake stub (route it through the root `intake/` fabric first), or a
settled team-level truth that belongs in a namespace as a [[knowledge-nodes|concept or
decision]]. When a lesson recurs as the same operator correction, it should become structure
(a rule, playbook, decision, or canon revision), not just another memory note.

## Required shape

- **Folder**: `memory/`.
- **Frontmatter**: standard node fields plus `type: "Memory"`. First-person is acceptable in
  memory notes. A memory node above `scratch` carries no placeholder text.
- **Body**: state the lesson, the context it came from, and what to do differently. Add
  `derived_from` edges when the memory distills a specific source, run, or intake receipt.

## How it relates to the other entity types

A memory node is the distilled output of experience that [[agents]] and [[workflows]]
produce and that [[projects]] and [[workflow-loops]] leave behind. It feeds the
correction-to-structure loop: a recurring memory becomes a [[rules|rule]], a playbook, a
decision, or a canon revision. It differs from a settled [[knowledge-nodes|knowledge node]],
which is team-level truth, and from a [[data-nodes|data node]], which is a live-data pointer.

## Governing rules and doctrine

The reasoning that repeated correction becomes structure rather than repeated chat is in
[[correction-loop-absorption]] and [[core-doctrine]]; memory is where individual lessons land
before they are absorbed into durable structure. The operative correction-loop rules live in
`_system/correction-loop-rules.md`. Memory nodes are built with the `build-knowledge-node`
skill. See [[system-overview]] for how memory nodes sit in the entity set.
