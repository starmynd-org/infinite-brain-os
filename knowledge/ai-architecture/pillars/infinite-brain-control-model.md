---
id: "knowledge-ai-architecture-infinite-brain-control-model"
aliases: ["knowledge-ai-architecture-infinite-brain-control-model", "ai-architecture-control-model"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "The stable Infinite Brain control model: one planning ladder, one source-of-truth split, and many bounded execution adapters."
confidence: 0.95
retrieval_class: "identity"
export_class: "internal"
edges:
  - target: "[[knowledge-ai-architecture-planning-to-execution-ladder]]"
    relation: "depends_on"
    confidence: 0.94
  - target: "[[knowledge-ai-architecture-surface-boundary]]"
    relation: "depends_on"
    confidence: 0.92
  - target: "[[playbook-ai-architecture-swarm-launch-governance]]"
    relation: "drives"
    confidence: 0.9
created: "2026-05-29"
---

# AI Architecture Infinite Brain Control Model

## Summary

The Infinite Brain AI architecture is built around one durable rule: planning,
governance, and durable knowledge stay canonical, while execution, queue state, and
tool-specific runtime state stay in the proper operational substrate.

## Content

The stable model has three layers:

1. git-backed canon for project intent, doctrine, rules, workflows, and durable
   summaries
2. operational state for live tasks, queues, approvals-in-flight, runs, and swarm
   fanout
3. analytical history for throughput, telemetry, and trend analysis

That split allows many AI-facing adapters to exist without creating a second source
of truth:

- Obsidian as a reading surface
- Claude Code and Codex as execution clients
- n8n as deterministic workflow runtime
- Paperclip as cockpit and operational projection
- swarm sprint folders as specialized execution packaging

The system stays coherent only if each adapter declares what it reads, what it may
write, and what remains outside its authority.

## Evidence

Primary sources:

- an internal build record (not shipped)
- an internal build record (not shipped)
- an internal build record (not shipped)
- an internal build record (not shipped)

## Edges

- `depends_on` the planning ladder because the control model needs a canonical anchor.
- `depends_on` the surface boundary because adapters only stay safe when their limits
  are explicit.
- `drives` swarm governance because launch and closeout rules are one implementation
  of the wider control model.

## Notes

This pillar should remain abstract enough to survive tool changes. Tool-specific
details belong in playbooks and decisions unless they change the model itself.
