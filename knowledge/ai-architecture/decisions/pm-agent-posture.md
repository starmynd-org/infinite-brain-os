---
id: "decision-ai-architecture-pm-agent-posture"
aliases: ["decision-ai-architecture-pm-agent-posture", "ai-architecture-pm-agent-posture"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "The PM-agent is a routing and preparation layer that should choose the lowest-cost safe execution mode, recommend swarm readily for substantial work, and stop short of launch authority."
confidence: 0.95
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[playbook-ai-architecture-swarm-launch-governance]]"
    relation: "bounded_by"
    confidence: 0.92
  - target: "[[decision-ai-architecture-standing-runtime-posture]]"
    relation: "aligned_with"
    confidence: 0.86
created: "2026-05-29"
---

# AI Architecture PM Agent Posture

## Summary

The PM-agent should route work visibly across `manual`, `workflow`, `agent`, and
`swarm`, but it remains an advisory and preparation layer rather than a launch
authority.

## Content

Settled rules:

- choose the lowest-cost safe mode
- treat `swarm` as the normal path for substantial multi-agent work
- prefer reuse of an existing swarm pattern when it fits
- scope a new sprint when risks, boundaries, or architecture are materially new
- emit visible routing artifacts, rationale, and missing prerequisites
- do not create approval receipts or invoke launch without human approval already in place

Current readiness posture:

- bounded prototype complete
- hardening and limited operator trial complete
- useful for the next limited batch
- not ready for broad unattended use

## Evidence

Primary sources:

- an internal build record (not shipped)
- an internal build record (not shipped)
- an internal build record (not shipped)
- an internal build record (not shipped)
- an internal build record (not shipped)

## Edges

- `bounded_by` the swarm-governance playbook because PM routing never overrides the
  launch gate.
- `aligned_with` the standing-runtime posture because both preserve visible,
  human-gated authority.

## Notes

This node should be revisited if a later sprint changes trial readiness or expands the
PM-agent beyond advisory mode.
