---
id: "decision-ai-architecture-standing-runtime-posture"
aliases: ["decision-ai-architecture-standing-runtime-posture", "ai-architecture-standing-runtime-posture"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Standing commander and admiral should be scheduled, approval-gated governance roles over visible state, not autonomous planning authorities."
confidence: 0.94
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[playbook-ai-architecture-swarm-launch-governance]]"
    relation: "depends_on"
    confidence: 0.88
  - target: "[[decision-ai-architecture-pm-agent-posture]]"
    relation: "aligned_with"
    confidence: 0.86
created: "2026-05-29"
---

# AI Architecture Standing Runtime Posture

## Summary

Commander and admiral are governance and orchestration roles over the canonical task
model and visible operational state. They are not independent planners and they do
not inherit autonomous launch or canonization authority.

## Content

Settled boundary:

- commander focuses on current and near-term execution hygiene
- admiral focuses on post-closeout review and follow-on discovery
- both may update visible operational projections and draft artifacts
- neither may grant launch approval, merge canon changes, or invent hidden standing state

Recommended first implementation:

- scheduled or heartbeat-driven review loops
- visible approvals and receipts
- optional Paperclip or the fleet coordinator surfaces for human-facing control

## Evidence

Primary sources:

- an internal build record (not shipped)
- an internal build record (not shipped)
- an internal build record (not shipped)

## Edges

- `depends_on` swarm governance because standing roles operate inside that gate.
- `aligned_with` PM-agent posture because both are advisory or proposal layers rather
  than silent executors.

## Notes

This node is about authority and runtime posture, not a full event-model catalog.
