---
id: "skill-build-project-and-task"
aliases: ["skill-build-project-and-task", "build-project-and-task"]
type: "Skill"
namespace: "personal-operator"
lifecycle_state: "research"
summary: "Build project anchors and task structures that respect the personal-versus-shared planning split and choose the right execution mode."
confidence: 0.95
retrieval_class: "domain"
export_class: "internal"
description: "Use this skill when scoping work into projects and tasks and deciding when the work should remain personal, become shared, or become swarm-shaped."
edges:
  - target: "[[skill-shape-ai-work]]"
    relation: "paired_with"
    confidence: 0.85
  - target: "[[intake-fabric-namespace]]"
    relation: "references"
    confidence: 0.8
  - target: "[[process-namespace-intake]]"
    relation: "references"
    confidence: 0.8
created: "2026-05-29"
---

# build-project-and-task

Use this skill to create or refine a project plan and its tasks.

## Use when

- work needs a scoped container
- tasks, blockers, and execution posture need to be made explicit

## Personal versus shared rule

- keep work in local `projects/{name}/PLAN.md` when it is still exploratory or single-operator
- move to shared canonical `initiative -> project -> task` when the work needs multi-role execution, durable contracts, or governance

## Build steps

1. Write the project objective and scope.
2. Break work into tasks with clear acceptance notes.
3. Decide whether each task is `manual`, `workflow`, `agent`, or `swarm`.
4. Mark blockers or dependencies explicitly.
5. If the project materially belongs to external commercial scope, add `party_slugs` and any
   primary `client_slug` or `brand_slug`.
6. If the work is swarm-shaped, move the execution anchor into the shared canonical task path.

## Intake and synthesis linkage (V2)

A project often consumes inbound items and produces durable understanding. Wire both
ends so the work does not strand its inputs or its outputs.

- When a project draws on captured items, link the project to their processed receipts
  in `intake/processed/<source>/`. The processed receipt records what came in and why
  it mattered; the project's lineage points back to it. See [[intake-fabric-namespace]]
  for why intake is a root layer and [[process-namespace-intake]] for how an item moves
  from a receipt into durable work.
- When a project produces durable reading or interpretation rather than a one-off
  artifact, route that output into the relevant namespace `synthesis/` folder, not into
  `outputs/` alone. A best-current-reading note, a contradiction map, or a
  canon-candidate package belongs in `knowledge/<namespace>/synthesis/`. An `outputs/`
  artifact is the deliverable; a `synthesis/` node is the durable understanding the
  project leaves behind.
- Keep the routing explicit in the project plan: name which intake receipts the project
  consumes and which synthesis or output nodes it produces. This is the project-side of
  the output-linkage surface.

## Human task rule

Do not create a separate human-task primitive by default.

Represent human execution through:

- owner
- approval posture
- `blocked_by`
- `waiting_on`
- `execution_mode`

## Quality checks

- tasks are scoped enough to choose an execution mode
- swarm mode is not assigned casually
- approval boundaries are visible
- party scope is explicit when the work materially belongs to a client, brand, vendor, partner,
  or other external party
