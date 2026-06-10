---
id: "knowledge-ai-architecture-planning-to-execution-ladder"
aliases: ["knowledge-ai-architecture-planning-to-execution-ladder", "ai-architecture-planning-ladder"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "The Infinite Brain planning ladder and how specialized execution layers hang off the canonical parent task."
confidence: 0.95
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[knowledge-ai-architecture-infinite-brain-control-model]]"
    relation: "supports"
    confidence: 0.92
  - target: "[[playbook-ai-architecture-swarm-launch-governance]]"
    relation: "anchors"
    confidence: 0.94
created: "2026-05-29"
---

# AI Architecture Planning To Execution Ladder

## Summary

The Infinite Brain keeps one canonical planning ladder, then routes execution from
the task layer into specialized runtimes without changing the ontology.

## Content

Canonical ladder:

1. `initiative`
2. `project`
3. `task`

Specialized execution layers:

- workflow definition
- run
- swarm sprint
- wave

Key rule: the parent task remains the planning anchor even when work routes to
`manual`, `workflow`, `agent`, or `swarm`.

Clarification added for durable swarm governance: a sprint gets exactly one canonical
`parent_task` anchor. Any additional touched tasks, projects, departments, repos, namespaces,
tools, or surfaces are additive cross references, not co-equal parents.

That preserves:

- project intent in canon
- acceptance criteria and blockers on the task
- reusable execution packaging in the appropriate runtime or sprint substrate

Anti-patterns this concept rejects:

- making each swarm sprint a canonical project
- creating a second backlog in `swarms/Sprints`
- letting a cockpit surface redefine the planning ladder

## Evidence

Primary sources:

- an internal build record (not shipped)
- an internal build record (not shipped)
- an internal build record (not shipped)

## Edges

- `supports` the control-model pillar by naming the canonical anchor.
- `anchors` swarm governance because launch and closeout always bind to the parent
  task.

## Notes

If a future planning pass adds another canonical level above initiative, this node
should be revised carefully rather than casually patched by downstream runtime work.
