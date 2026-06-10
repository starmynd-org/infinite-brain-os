---
id: "knowledge-personal-operator-goal-tracking-and-alignment"
aliases: ["knowledge-personal-operator-goal-tracking-and-alignment", "goal-tracking-and-alignment"]
type: "Knowledge"
namespace: "personal-operator"
lifecycle_state: "research"
summary: "How the operator's goals are tracked and how his tasks and time stay aligned with them: goals live as durable git knowledge here and map onto Paperclip Goals as the runtime; an alignment check compares the time fact table and the task backlog against the goals and surfaces misalignment. The structure is fixed; the actual goals are operator-input-required."
confidence: 0.5
retrieval_class: "identity"
export_class: "internal"
edges:
  - target: "[[personal-operator-core-doctrine]]"
    relation: "part_of"
    confidence: 0.85
  - target: "[[knowledge-personal-operator-operator-profile]]"
    relation: "depends_on"
    confidence: 0.8
created: "2026-06-03"
---

# Goal Tracking and Alignment

the operator's goals are durable git knowledge in this namespace and map onto Paperclip Goals as the runtime
surface. The point is not just to list goals but to keep his tasks and time aligned with them, and to
surface misalignment for correction.

## Where goals live

- **Durable (git)**: the goal definitions, their rationale, and their horizon live here as knowledge.
  This is the source of truth for what the operator is trying to achieve. The actual goals are
  operator-input-required as of 2026-06-03 (filled in the chief-of-staff activation project); do not
  invent them.
- **Runtime (Paperclip Goals)**: the same goals project onto Paperclip Goals so the runtime can attach
  issues and progress to them. Git is the source of truth; Paperclip is the operational projection, per
  the paperclip boundary.

## The alignment check

The check reads three inputs and reports drift:

- the goals (this node)
- the task backlog (the planning ladder; what the operator is actually working on)
- the time fact table (`data/operator-time-fact-table.md`; how the operator actually spent his time)

It answers: is the operator's time going where his goals say it should, and are his active tasks the ones that
advance his goals. Misalignment (time or tasks not serving any goal, or a goal with no time or tasks
against it) is surfaced through the chief-of-staff membrane as a batched human-bound item, never
auto-corrected. The operator decides what to do with the drift.

## Boundary

The system surfaces alignment and drift; the operator owns the goals and the response. Goals are not invented
by an agent. The alignment check is read-only over the fact table and the backlog.
