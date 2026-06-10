---
id: "knowledge-ai-architecture-session-ledger-root-layer"
aliases: ["knowledge-ai-architecture-session-ledger-root-layer", "session-ledger-root-layer", "ai-architecture-session-ledger"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Sessions are a root OS layer for AI chat registration, transcript retention, and closeout reviews: a durable audit trail that feeds memory, tasks, swarms, and knowledge surfaces without becoming canon."
confidence: 0.91
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[surface-boundary]]"
    relation: "depends_on"
    confidence: 0.9
  - target: "[[correction-loop-absorption]]"
    relation: "depends_on"
    confidence: 0.86
  - target: "[[intake-fabric-namespace]]"
    relation: "related_to"
    confidence: 0.84
  - target: "[[open-and-close-ai-session]]"
    relation: "drives"
    confidence: 0.9
created: "2026-05-31"
---

# Session Ledger As A Root OS Layer

## Summary

AI chat sessions are too valuable to leave trapped in vendor UIs or terminal scrollback, but
they are too noisy to treat as canon. The resolution is a root `sessions/` layer: register
the session, keep the transcript, close it out, and promote only the distilled signal.

## Content

The session layer exists because AI work now happens through chat surfaces: Codex, Claude
Code, phone apps, browser chats, and future clients. Those sessions generate valuable audit
material:

- reasoning paths
- token and cost receipts
- tool calls and outputs
- wrong turns
- confusion that later became clarity
- decisions and follow-up ideas

Losing that history wastes learning and breaks handoff. But loading raw transcript history as
default context would make retrieval worse, not better. So sessions get their own root layer.

The session layer is not a knowledge namespace. It is closer to intake: a durable upstream
trail that feeds better structure elsewhere. A session can produce:

- a `memory/` node when it surfaces a reviewed learning
- a task or project update when it creates follow-up work
- a swarm proposal when the work is multi-lane and needs explicit packaging
- a support or synthesis note when it surfaces provenance or interpretation worth keeping
- a rule, playbook, skill, workflow, or canon revision when repeated correction becomes structure

What it cannot produce directly is canon by mere existence. The transcript is evidence and
provenance, not settled truth.

## Why a root layer is the right home

Putting sessions under a namespace would wrongly imply the transcript already belongs to one
knowledge domain. Often the exact opposite is true: a session starts broad, crosses
namespaces, and only at closeout becomes classifiable. The root layer keeps that audit trail
available without forcing premature categorization.

## Retrieval posture

The retrieval path is:

1. session record
2. session closeout review
3. raw transcript only on demand

That keeps retrieval sharp while still preserving exact history when needed for audit,
debugging, or handoff recovery.

## Relationship to swarm sprints

When a session is operating inside a swarm sprint, it updates both `sessions/` and
an internal build record (not shipped), but for different reasons. `sessions/` keeps the conversation trail,
tool traces, and closeout extraction. The sprint folder keeps the execution-facing artifacts
and receipts the sprint itself needs. That is an intentional dual-write boundary, not a
failure to integrate. Forcing one surface to do both jobs would either pollute the sprint
package with transcript sludge or make the conversation archive shoulder sprint-planning
responsibilities it should not own.

The two surfaces should also cross-link. The session record should name the sprint path, and
the sprint README or sprint-facing note should point back to the session record or closeout
review. That makes handoff and audit recovery much easier without changing the source-of-
truth split.

## Boundaries

- `sessions/` is durable audit trail, not live queue state.
- `sessions/` is not default context for ordinary knowledge questions.
- `sessions/` stores raw logs; ontology surfaces store the meaning extracted from them.
- usage and cost originate in the runtime or observability layer, but their settled receipt belongs
  in session closeout.
- session closeout is mandatory because unclosed transcripts are just another backlog.

## Notes

The session ledger solves two problems at once: losing valuable chat history and polluting
the knowledge graph with transcript sludge. Keep everything. Promote selectively.

Automatic usage capture is the preferred posture whenever the runtime permits it. The implementation
patterns for direct, SDK-derived, gateway-derived, and provider-side usage capture are in
[[implement-session-usage-capture]], with current runtime-specific facts held in
`terminal-session-usage-capture-reference`.
