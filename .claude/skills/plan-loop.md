---
id: "skill-plan-loop"
aliases: ["skill-plan-loop", "plan-loop"]
type: "Skill"
namespace: "personal-operator"
lifecycle_state: "research"
summary: "Turn a loop concept into a concrete build plan: files, entities, runtime substrate, review gates, and output receipts."
confidence: 0.91
retrieval_class: "domain"
export_class: "internal"
description: "Use this skill after loop design is settled and the next task is to translate it into concrete repo artifacts and runtime decisions."
edges:
  - target: "[[skill-design-loop]]"
    relation: "depends_on"
    confidence: 0.92
  - target: "[[planning-to-execution-ladder]]"
    relation: "aligned_with"
    confidence: 0.86
  - target: "[[autonomous-improvement-loops]]"
    relation: "informed_by"
    confidence: 0.9
created: "2026-05-30"
---

# plan-loop

Use this skill to convert a loop brief into the smallest correct set of artifacts and
execution choices.

## Use when

- a loop idea is sound and needs implementation planning
- the operator needs to know which entities and files to create first
- governance and runtime choices must be decided before coding or prompt work begins

## Do not use when

- the loop concept itself is still fuzzy; use [[skill-design-loop]]
- the work is already implemented and needs tuning; use [[skill-improve-loop]]

## Build steps

1. Anchor the loop to the canonical parent task or project. Do not create a shadow
   backlog for loop work.
2. Decide the entity set:
   - workflow for the operating contract
   - agent if a bounded specialist worker is needed
   - skills for recurring techniques
   - rules if new authority or safety constraints are required
3. Choose the runtime class:
   - Markdown workflow for judgment-heavy or review-heavy loops
   - n8n for deterministic subflows
   - hybrid when orchestration is agentic but substeps are deterministic
4. Plan the state model. Name where frontier state, queues, run logs, receipts, and
   reviews live.
5. Plan the output receipts. Every run or review cycle should produce visible artifacts,
   not hidden runtime behavior.
6. Plan human gates and failure posture. Name where approval is required and what events
   force pause, rollback, or operator review.
7. Sequence the build order from doctrine to runtime:
   - doctrine or workflow contract
   - agent or skills
   - rules
   - runtime adapters or scripts
   - outputs and review path

## Output contract

Return:

1. target artifacts and exact paths
2. runtime choice and why
3. state model
4. approval gates
5. expected outputs
6. build order

## Quality checks

- the plan does not invent a new entity just to host the loop
- every runtime behavior maps back to a visible canonical artifact
- the build order starts with contract, not with implementation thrash
- output receipts are explicit

## Anti-patterns

- implementing before choosing where state lives
- treating a loop like an agent personality instead of a governed pattern
- creating a sprint-only design with no reusable canonical contract
