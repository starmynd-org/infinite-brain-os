---
id: "knowledge-ai-architecture-autonomous-improvement-loops"
aliases: ["knowledge-ai-architecture-autonomous-improvement-loops", "ai-architecture-loop-patterns", "autonomous-improvement-loops"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Loops are a first-class execution pattern, not a new top-level entity: a workflow subtype that uses feedback, evaluation, and state transition to decide the next iteration."
confidence: 0.91
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[deterministic-workflow-boundary]]"
    relation: "extends"
    confidence: 0.88
  - target: "[[planning-to-execution-ladder]]"
    relation: "aligned_with"
    confidence: 0.86
  - target: "[[standing-runtime-failure-posture]]"
    relation: "bounded_by"
    confidence: 0.9
  - target: "[[correction-loop-absorption]]"
    relation: "related_to"
    confidence: 0.8
created: "2026-05-30"
---

# Autonomous Improvement Loops

## Summary

Loops matter enough to be named explicitly in the Infinite Brain, but not enough to
become a twelfth entity. A loop is a workflow subtype with recurrence, an evaluation
function, state carried across runs, and a rule for deciding the next iteration. The
entity model stays stable; the execution pattern gets more precise.

## Content

The architectural distinction is:

- a normal workflow executes a procedure
- a loop executes a procedure, evaluates the result, and uses that feedback to choose the
  next step

That difference is substantial in runtime behavior, safety posture, and operational
design. It is not substantial enough to justify a new top-level entity because a loop has
no single durable home. Its procedure may live in `workflows/`, its specialist worker in
`entities/agents/`, its reusable methods in `entities/skills/`, its guardrails in
`entities/rules/` or `_system/`, its artifacts in `outputs/`, its learnings in
`memory/`, and its live run state in the operational substrate.

The planning ladder therefore does not change. The parent task remains canonical, and the
loop is one specialized execution pattern hanging off that task.

## Why loops deserve explicit doctrine

Loops introduce design questions that ordinary workflows can often ignore:

- what objective is being optimized
- what surface the loop is allowed to mutate
- how the result is evaluated
- where frontier or queue state lives between iterations
- what stops the loop
- where human approval is required
- how successful corrections or discoveries are absorbed into durable structure

If those questions are left implicit, loops drift into hidden state, noisy churn, or
unsafe autonomy. Naming the pattern explicitly makes those contracts visible.

## Two loop classes

The Infinite Brain should distinguish two recurring loop classes.

- Improvement loop. Repeatedly change a bounded surface, run an evaluator, keep or discard
  the change, and advance the frontier only on improvement. Karpathy-style autoresearch is
  the clearest example.
- Standing operational loop. Repeatedly inspect live state, route or flag deltas, and
  produce visible receipts without silently escalating authority. Commander, admiral,
  monitor, and review passes fit here.

These two classes share loop mechanics but differ in risk. Improvement loops primarily
risk wasted search, broken artifacts, or evaluation drift. Standing operational loops
primarily risk hidden state, noisy re-flagging, approval bypass, or second-source-of-
truth drift.

## The loop contract

Every serious loop should declare these fields, whether in a workflow, a playbook, or a
runtime spec.

1. Objective: the concrete thing the loop is trying to improve or maintain.
2. Controlled surface: the files, queues, records, or parameters the loop may change.
3. Evaluator: the test, metric, rubric, or review that determines what counts as better.
4. State substrate: where run state, frontier state, pending items, and receipts live.
5. Stop condition: time budget, convergence threshold, approval boundary, or explicit
   operator interruption.
6. Human gate points: which transitions require review before the loop may continue.
7. Absorption path: where repeat findings become durable structure rather than recurring
   chat or recurring flags.

If a proposed loop cannot state all seven cleanly, it is not ready for unattended or
semi-attended operation.

## Entity implications

Loops should be represented as a composition of existing entities, not as a new entity:

- `Workflow`: the loop procedure and operating contract
- `Agent`: the bounded worker or coordinator when reasoning is needed
- `Skill`: the reusable design, planning, implementation, and improvement techniques
- `Rule`: authority, safety, and style constraints
- `Output`: run reviews, experiment summaries, and loop receipts
- `Memory` and canon: absorbed lessons that should change future behavior

This preserves the stable ontology while letting loop-heavy systems be designed
explicitly.

## Boundaries

Loops must respect three boundaries.

- They do not alter the planning ontology. A loop hangs off a task; it does not become a
  project or a parallel backlog.
- They do not create a second source of truth. Canon stays canonical; runtime state stays
  in the operational substrate.
- They do not smuggle in launch authority. Long-running or self-advancing loops must
  declare their human gates and stop conditions in advance.

## Edges

- `extends` [[deterministic-workflow-boundary]] because loops sharpen the runtime-class
  distinction inside workflows.
- `aligned_with` [[planning-to-execution-ladder]] because loops are specialized execution
  patterns, not ontology changes.
- `bounded_by` [[standing-runtime-failure-posture]] because unattended or recurring loops
  fail in predictable ways when hidden state and approval rules are weak.
- `related_to` [[correction-loop-absorption]] because correction absorption is a specific
  loop family whose output is durable structure.

## Notes

This concept names the pattern and the contract. Specific loop implementations belong in
workflows, playbooks, and runtime adapters. If future practice shows a loop family with a
durable storage shape that cannot be represented cleanly through workflows plus existing
entities, revisit the entity question then rather than preemptively expanding the
ontology now.
