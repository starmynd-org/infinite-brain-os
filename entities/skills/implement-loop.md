---
id: "skill-implement-loop"
aliases: ["skill-implement-loop", "implement-loop"]
type: "Skill"
namespace: "personal-operator"
lifecycle_state: "research"
summary: "Implement a loop by creating the canonical workflow, supporting agent and skills, safety constraints, and visible output receipts without breaking control boundaries."
confidence: 0.9
retrieval_class: "domain"
export_class: "internal"
description: "Use this skill when a loop plan is approved and the repo artifacts now need to be created or updated."
edges:
  - target: "[[skill-plan-loop]]"
    relation: "depends_on"
    confidence: 0.9
  - target: "[[skill-build-workflow]]"
    relation: "uses"
    confidence: 0.84
  - target: "[[skill-build-agent]]"
    relation: "uses"
    confidence: 0.82
  - target: "[[skill-build-skill]]"
    relation: "uses"
    confidence: 0.82
  - target: "[[standing-runtime-failure-posture]]"
    relation: "bounded_by"
    confidence: 0.86
created: "2026-05-30"
---

# implement-loop

Use this skill to build the repo pieces a loop needs while preserving the Infinite Brain
control model.

## Use when

- a loop design and plan already exist
- the task is to create or revise canonical artifacts in the repo
- the operator wants the loop expressed through existing entities rather than chat alone

## Do not use when

- loop design is unsettled
- the main need is diagnosis or tuning of an existing loop; use [[skill-improve-loop]]

## Build steps

1. Create or update the loop workflow under `workflows/`. This file is the operating
   contract and should name objective, evaluator, state, gates, and outputs.
2. Create a bounded specialist agent under `entities/agents/` if the loop needs stable
   judgment beyond a plain workflow.
3. Create reusable skills under `entities/skills/` if the loop depends on techniques that
   future loops should reuse.
4. Add or update rules only when the loop changes authority, approval, style, or safety
   posture across sessions.
5. Name the output receipts and their paths. A loop without receipts is hidden runtime.
6. If adapter-facing entities changed, run `bash sync-adapters.sh`. Never hand-edit
   `.claude/` or `.codex/` copies.
7. Run `bash _system/validate.sh` and fix any broken links or schema issues.

## Output contract

Produce:

- canonical files created or updated
- adapter sync completed if entities changed
- validation status
- one short note on where runtime state and receipts live

## Quality checks

- the workflow is the contract, not a vague aspiration
- the agent job is bounded and does not swallow the whole system
- receipts are visible and named
- adapter mirrors were regenerated from canonical entities

## Anti-patterns

- implementing loop logic only in an agent prompt with no workflow contract
- writing to adapter mirrors as if they were source of truth
- adding permanent rules for behavior that belongs only inside one workflow
