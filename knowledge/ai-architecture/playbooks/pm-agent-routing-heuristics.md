---
id: "playbook-ai-architecture-pm-agent-routing-heuristics"
aliases: ["playbook-ai-architecture-pm-agent-routing-heuristics", "ai-architecture-pm-routing-heuristics"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Reusable routing signals for choosing between manual, workflow, agent, and swarm while keeping the PM-agent advisory and human-gated."
confidence: 0.93
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[decision-ai-architecture-pm-agent-posture]]"
    relation: "implements"
    confidence: 0.91
  - target: "[[playbook-ai-architecture-swarm-launch-governance]]"
    relation: "bounded_by"
    confidence: 0.88
created: "2026-05-29"
---

# AI Architecture PM Agent Routing Heuristics

## Summary

The PM-agent should choose the lightest safe execution mode, but substantial
multi-step work should still route to `swarm` readily because that is the proven
high-capacity substrate in this doctrine line.

## Content

Evaluate these signals before choosing a mode:

1. acceptance criteria complexity
2. expected decomposition size
3. repo and domain span
4. review and handoff count
5. context-window pressure
6. need for durable execution artifacts
7. whether a matching workflow or swarm pattern already exists

Mode guidance:

- choose `manual` when judgment is primary and automation adds little value
- choose `workflow` when the path is deterministic and contract-heavy
- choose `agent` when one bounded context can complete the work cleanly
- choose `swarm` when parallel lanes, staged checkpoints, or multi-role coordination
  are materially present

Borderline rule:

If the work is clearly substantial but reuse and scope are still ambiguous, bias
toward `swarm` and make the missing prerequisites explicit rather than forcing the
task into a brittle single-agent path.

Trust rule:

Routing output should always include:

- chosen mode
- short rationale
- missing prerequisites
- approval posture when `swarm` is selected

## Evidence

Primary sources:

- an internal build record (not shipped)
- an internal build record (not shipped)
- an internal build record (not shipped)

## Edges

- `implements` the PM-agent posture by turning the advisory role into repeatable
  routing signals.
- `bounded_by` swarm governance because routing never overrides approval.

## Notes

This playbook captures the reusable signal set, not the full implementation details of
one trial runner.
