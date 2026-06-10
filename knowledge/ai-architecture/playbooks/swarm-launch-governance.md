---
id: "playbook-ai-architecture-swarm-launch-governance"
aliases: ["playbook-ai-architecture-swarm-launch-governance", "ai-architecture-swarm-governance"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Repeatable contract for routing a canonical task into a swarm sprint, enforcing approval, and writing back bounded closeout truth."
confidence: 0.96
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[knowledge-ai-architecture-planning-to-execution-ladder]]"
    relation: "implements"
    confidence: 0.94
  - target: "[[decision-ai-architecture-pm-agent-posture]]"
    relation: "constrains"
    confidence: 0.87
created: "2026-05-29"
---

# AI Architecture Swarm Launch Governance

## Summary

Swarm execution is allowed only as a governed routing path from a canonical parent
task into a specialized sprint package, with human approval and bounded closeout
writeback.

## Content

Required launch posture:

1. canonical task exists and is structurally valid
2. `execution_mode: swarm` is explicit
3. approval block exists on the task
4. file-backed approval receipt exists
5. receipt is human-granted, fingerprint-matched, and not expired

Operator outcomes:

- `blocked` when the task is not yet launchable
- `denied` when approval explicitly rejects launch
- `launched` only after the gate validates fully

Launch writes only bounded routing metadata and sprint linkage. Closeout writes back
only distilled planning truth:

- task status
- completion date
- sprint status
- latest summary path
- closeout outcome and evidence

This pattern keeps `swarms/Sprints` durable and useful without making sprint folders
the canonical planner.

## Evidence

Primary sources:

- an internal build record (not shipped)
- an internal build record (not shipped)
- an internal build record (not shipped)
- an internal build record (not shipped)

## Edges

- `implements` the planning ladder by showing how the parent task remains the anchor.
- `constrains` the PM-agent posture because routing may recommend swarm but may not
  bypass the launch gate.

## Notes

Keep this node focused on the reusable contract. Example task IDs, sprint IDs, and
receipt paths are evidence, not the doctrine itself.
