---
id: "decision-ai-architecture-standing-runtime-failure-posture"
aliases: ["decision-ai-architecture-standing-runtime-failure-posture", "ai-architecture-standing-runtime-failure-posture"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Standing commander and admiral loops must be designed against hidden state, approval bypass, mirror drift, and repeated advisory noise."
confidence: 0.93
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[decision-ai-architecture-standing-runtime-posture]]"
    relation: "qualifies"
    confidence: 0.92
  - target: "[[playbook-ai-architecture-swarm-launch-governance]]"
    relation: "reinforces"
    confidence: 0.84
created: "2026-05-29"
---

# AI Architecture Standing Runtime Failure Posture

## Summary

Standing commander and admiral runtime loops are only safe when they are built
against a known set of failure modes: second-source-of-truth drift, approval bypass,
runaway launch behavior, stale queue churn, and mirror divergence.

## Content

The non-negotiable guardrails are:

1. every action resolves to a visible receipt or draft artifact
2. canon plus visible operational state stay authoritative
3. launch remains explicitly human-gated
4. mirror surfaces such as Paperclip never outrank canon
5. repeated advisory events require evidence delta or cool-down behavior

Key failure classes to design against:

- hidden queue or follow-on state
- auto-launch after dependency changes
- approval bypass through runtime shortcuts
- noisy stale-loop re-flagging
- runtime drift from assumed substrate behavior
- mirror drift between cockpit and repo truth

## Evidence

Primary sources:

- an internal build record (not shipped)
- an internal build record (not shipped)

## Edges

- `qualifies` the standing-runtime posture by naming what must not go wrong.
- `reinforces` swarm governance because approval and receipt rules are shared safety
  boundaries.

## Notes

This decision is intentionally about safety posture, not about choosing one runtime
implementation stack.
