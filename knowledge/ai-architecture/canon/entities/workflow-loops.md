---
id: "knowledge-ai-architecture-canon-entity-workflow-loops"
aliases: ["knowledge-ai-architecture-canon-entity-workflow-loops", "ai-architecture-entity-workflow-loops", "entity-workflow-loops"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Canon for the Workflow loop: an autonomous improvement loop that executes a procedure, evaluates the result, and chooses the next iteration, represented as a composition of existing entities rather than a new top-level type."
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
  - target: "[[autonomous-improvement-loops]]"
    relation: "derived_from"
    confidence: 0.92
  - target: "[[workflows]]"
    relation: "related_to"
    confidence: 0.85
created: "2026-05-31"
---

## What it is

A **Workflow loop** is an autonomous improvement loop: a workflow subtype that executes a
procedure, evaluates the result, and uses that feedback to choose the next iteration. The
difference from a normal [[workflows|workflow]] is the feedback step. Loops matter enough
to be named explicitly, but not enough to be a new top-level entity, because a loop has no
single durable home: its procedure, worker, methods, guardrails, artifacts, learnings, and
run state spread across several entity types. The full reasoning is in
[[autonomous-improvement-loops]].

## When to use it (and when not)

Use the loop pattern when a recurring feedback system repeatedly changes a bounded surface,
runs an evaluator, and advances only on improvement (an improvement loop), or repeatedly
inspects live state and produces visible receipts without escalating authority (a standing
operational loop). Do not name a loop when a plain workflow without feedback suffices, and
do not treat a loop as a new entity to store on its own. If a proposed loop cannot cleanly
state all seven loop-contract fields, it is not ready for unattended or semi-attended
operation.

## Required shape

A loop is a composition, not a single file. It declares the loop contract across its parts:

- **Objective**, **controlled surface**, **evaluator**, **state substrate**, **stop
  condition**, **human gate points**, and **absorption path** (the seven fields from the
  loop contract).
- The loop procedure lives in a [[workflows|workflow]] (or playbook), its worker in an
  [[agents|agent]], its methods in [[skills]], its guardrails in [[rules]] or `_system/`,
  its artifacts in [[output-nodes]], its learnings in [[memory-nodes]] and canon, and its
  live run state in the operational substrate.

## How it relates to the other entity types

A loop composes a [[workflows|workflow]], an [[agents|agent]], [[skills]], [[rules]],
[[output-nodes]], and [[memory-nodes]] rather than replacing any of them. It hangs off a
parent task on the planning ladder; it does not become a [[projects|project]] or a parallel
backlog and does not create a second source of truth. A specific loop family,
correction-to-structure, has durable structure as its output and feeds canon revisions.

## Governing rules and doctrine

The loop concept, the two loop classes, and the seven-field loop contract are in
[[autonomous-improvement-loops]]. The boundaries (no ontology change, no second source of
truth, no smuggled launch authority) are bounded by the standing-runtime-failure posture in
`_system/` and the decisions, and the planning-ladder reasoning is in [[core-doctrine]].
Loops stay human-gated and split deterministic from agentic work. See [[system-overview]]
for how loops sit in the entity set.
