---
id: "skill-improve-loop"
aliases: ["skill-improve-loop", "improve-loop"]
type: "Skill"
namespace: "personal-operator"
lifecycle_state: "research"
summary: "Review an existing loop for evaluator quality, state visibility, noise, authority drift, and absorption of repeated findings; tighten the contract without ontology sprawl."
confidence: 0.91
retrieval_class: "domain"
export_class: "internal"
description: "Use this skill when a loop already exists and the task is to make it safer, sharper, or more effective without redesigning the whole architecture."
edges:
  - target: "[[autonomous-improvement-loops]]"
    relation: "informed_by"
    confidence: 0.91
  - target: "[[standing-runtime-failure-posture]]"
    relation: "bounded_by"
    confidence: 0.9
  - target: "[[correction-loop-absorption]]"
    relation: "related_to"
    confidence: 0.78
created: "2026-05-30"
---

# improve-loop

Use this skill to review and tighten an existing loop without turning every problem into
a new entity or a full redesign.

## Use when

- a loop runs but produces weak gains, noisy alerts, or repeated operator correction
- state or receipts feel hidden or incomplete
- the loop keeps repeating work without learning enough from past runs

## Do not use when

- the loop still needs its first clean design; use [[skill-design-loop]]
- the task is to build the first version of the loop; use [[skill-implement-loop]]

## Review steps

1. Re-state the current objective and compare it to the actual observed behavior.
2. Inspect the evaluator. Ask whether it really decides progress or only creates motion.
3. Inspect state visibility. Frontier state, queue state, and receipts should be visible
   outside the runtime itself.
4. Inspect stop conditions and gates. A loop that never cleanly pauses is not robust.
5. Inspect noise. Count repeated alerts, repeated reviews, repeated corrections, or
   repeated no-op iterations.
6. Inspect absorption. Name which findings should become rules, playbooks, decisions, or
   canon rather than recurring output chatter.
7. Recommend the smallest contract change that improves the loop materially.

## Output contract

Return a loop improvement memo with:

- current objective
- observed failure or drag
- evaluator assessment
- state visibility assessment
- gate and stop assessment
- absorption opportunities
- recommended changes

## Quality checks

- recommendations change the contract, not just the wording
- repeated advisory noise is treated as a design defect
- findings that belong in durable structure are routed there
- the loop stays within existing ontology

## Anti-patterns

- adding more cadence instead of improving evaluator quality
- solving every repeated issue with more memory instead of structural absorption
- letting a loop keep re-flagging unchanged state with no evidence delta
