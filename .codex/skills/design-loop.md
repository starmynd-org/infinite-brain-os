---
id: "skill-design-loop"
aliases: ["skill-design-loop", "design-loop"]
type: "Skill"
namespace: "personal-operator"
lifecycle_state: "research"
summary: "Design a loop as a bounded feedback system with an objective, controlled surface, evaluator, state substrate, stop condition, human gates, and absorption path."
confidence: 0.92
retrieval_class: "domain"
export_class: "internal"
description: "Use this skill when a recurring AI pattern should be shaped into an explicit loop instead of an ordinary one-shot workflow."
edges:
  - target: "[[autonomous-improvement-loops]]"
    relation: "informed_by"
    confidence: 0.94
  - target: "[[deterministic-workflow-boundary]]"
    relation: "bounded_by"
    confidence: 0.84
  - target: "[[standing-runtime-failure-posture]]"
    relation: "bounded_by"
    confidence: 0.86
created: "2026-05-30"
---

# design-loop

Use this skill to decide whether a proposed recurring pattern should become an explicit
loop and to shape its contract before any implementation starts.

## Use when

- a workflow will recur and use feedback to decide the next iteration
- a team wants an agent to keep improving or monitoring something across runs
- the operator senses the work is more than a linear pipeline but less than a new entity

## Do not use when

- the work is a one-shot procedure with no cross-run state or evaluator
- the pattern is really just a standing rule, playbook, or agent role
- the loop would mutate an unbounded surface with no clear stop condition

## Goal

Produce a loop design that is explicit enough to be implemented safely and judged on its
own merits.

## Build steps

1. Classify the loop:
   - `improvement`: optimize a bounded surface through repeated keep/discard cycles
   - `standing-operational`: repeatedly inspect, route, flag, or maintain live state
2. Write the objective in one sentence. Use a concrete success condition, not a vague
   ambition.
3. Define the controlled surface. Name exactly what the loop may read and what it may
   modify.
4. Define the evaluator. Name the metric, rubric, review rule, or evidence delta that
   decides whether the next step advances.
5. Pick the state substrate. Decide where queue state, frontier state, receipts, and run
   history live. Do not let chat transcript become the only state carrier.
6. Define the stop condition. Use a time budget, convergence threshold, approval gate,
   run limit, or explicit operator interrupt.
7. Mark the human gate points. State which transitions need review before the loop can
   continue or escalate.
8. Define the absorption path. State where repeat findings become durable structure:
   rule, playbook, decision, canon, memory, or output review.
9. Name the failure modes that matter most: hidden state, noisy churn, approval bypass,
   evaluator drift, or unbounded surface creep.

## Output contract

Return a loop brief with these headings:

- Loop class
- Objective
- Controlled surface
- Evaluator
- State substrate
- Stop condition
- Human gates
- Absorption path
- Primary failure modes

## Quality checks

- the objective can be measured or reviewed concretely
- the controlled surface is small enough to govern
- the evaluator can actually decide the next iteration
- the state substrate is explicit and visible
- the loop can stop without relying on vibes

## Anti-patterns

- calling a recurring task a loop without naming evaluator or state
- using “continuous improvement” as a slogan with no bounded surface
- giving a loop silent authority to escalate itself
- storing the only run state in chat history
