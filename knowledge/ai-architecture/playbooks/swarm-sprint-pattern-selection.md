---
id: "playbook-ai-architecture-swarm-sprint-pattern-selection"
aliases: ["playbook-ai-architecture-swarm-sprint-pattern-selection", "ai-architecture-swarm-pattern-selection"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Pattern for deciding whether a swarm recommendation should reuse an existing sprint shape or scope a new bounded sprint."
confidence: 0.92
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[knowledge-ai-architecture-planning-to-execution-ladder]]"
    relation: "extends"
    confidence: 0.86
  - target: "[[decision-ai-architecture-pm-agent-posture]]"
    relation: "supports"
    confidence: 0.9
created: "2026-05-29"
---

# AI Architecture Swarm Sprint Pattern Selection

## Summary

When a task is swarm-shaped, the next decision is not "whether swarm exists" but
"whether to reuse an existing sprint pattern or scope a new sprint."

## Content

Prefer existing pattern reuse when:

1. a prior sprint already matches the work shape
2. the deliverable contract needs only minor adaptation
3. the main need is execution, not fresh architecture framing
4. roles, checkpoints, and handoffs are already known

Scope a new sprint when:

1. the work crosses a new architecture or governance boundary
2. the blast radius or dependency picture needs explicit framing
3. no prior sprint pattern fits cleanly
4. the brief itself is part of risk control
5. the result is likely to become a reusable pattern later

Tie-break rule:

If reuse is close but imperfect, reuse and record the adaptations.

If reuse would hide new risks, scope a new sprint.

Planning anchor rule:

Even when a swarm sprint is selected:

- the canonical parent task remains the planning anchor
- the sprint remains a specialized execution package
- approval remains human-gated

## Evidence

Primary sources:

- an internal build record (not shipped)
- an internal build record (not shipped)

## Edges

- `extends` the planning ladder by clarifying how one task binds to one specialized
  execution package.
- `supports` the PM-agent posture by making reuse and new-scope decisions explicit.

## Notes

This playbook is about sprint-shape selection, not launch approval or closeout
writeback.
