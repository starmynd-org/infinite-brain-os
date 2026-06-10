---
id: "knowledge-ai-architecture-canon-entity-projects"
aliases: ["knowledge-ai-architecture-canon-entity-projects", "ai-architecture-entity-projects", "entity-projects"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Canon for the Project entity: a scoped work container in projects/{name}/ with a single PLAN.md holding intent, scope, success criteria, lineage, and tasks, where the parent task stays the planning anchor and each task routes to an execution mode."
confidence: 0.9
retrieval_class: "domain"
export_class: "internal"
verified_at: "2026-05-31"
verified_by: "operator-pending"
edges:
  - target: "[[system-overview]]"
    relation: "part_of"
    confidence: 0.9
  - target: "[[core-doctrine]]"
    relation: "derived_from"
    confidence: 0.88
  - target: "[[planning-to-execution-ladder]]"
    relation: "aligned_with"
    confidence: 0.9
  - target: "[[workflows]]"
    relation: "related_to"
    confidence: 0.82
created: "2026-05-31"
---

## What it is

A **Project** is a scoped work container. It lives at `projects/{name}/` with one file,
`PLAN.md`, holding the intent, scope, success criteria, lineage, and (at T1 and T2) an
inline `## Tasks` checklist. At T3, when Paperclip is operational, tasks migrate into
Paperclip's Postgres and the checklist is removed from the plan. A project is the bucket
that holds work larger than a single node and routes each task to an execution mode.

## When to use it (and when not)

Use a project when work needs a scoped container and its tasks, blockers, and execution
posture must be made explicit. Keep it as a local `projects/{name}/PLAN.md` while the work
is exploratory or single-operator. Promote to the shared canonical `initiative -> project
-> task` path when the work needs multi-role execution, durable contracts, or governance.
Do not use a project when one standalone node, [[workflows|workflow]], or [[agents|agent]]
is enough, and do not assign swarm mode casually because the work sounds ambitious.

## Required shape

- **Folder**: `projects/{name}/PLAN.md`.
- **Frontmatter**: standard node fields plus `type: "Project"`. A Project node should
  declare `updated`, `project_status`, `state_stored_at`, `analytical_view`,
  `owner_department`, `owner_agent`, `parent_initiative`, `review_cadence`, and
  `linked_swarm_id` so its durable execution posture and rollup home are explicit. When the
  project materially belongs to external commercial scope, it may also declare optional
  `party_slugs`, `client_slug`, and `brand_slug`.
- **Body**: objective and scope, tasks with clear acceptance notes, an execution mode per
  task (`manual`, `workflow`, `agent`, or `swarm`), blockers and dependencies, and the
  intake and synthesis linkage (which processed receipts the project consumes and which
  synthesis or output nodes it produces).

Projects may also act as thin initiative containers when they live under `initiatives/` and
declare `project_role: initiative`. That is a planning role, not a twelfth entity type.

## How it relates to the other entity types

A project routes each task to a mode that calls a [[workflows|workflow]], an [[agents|
agent]], or a swarm; the parent task remains the planning anchor regardless of mode. A
project consumes inbound items through their `intake/processed/` receipts and produces
durable understanding into a namespace `synthesis/` folder plus deliverables as
[[output-nodes]]. Human execution is represented through owner, approval posture,
`blocked_by`, `waiting_on`, and `execution_mode`, not a separate human-task primitive.
Tasks should be addressable as `<project-slug>#<task-id>` so a swarm sprint can point back to
exactly one canonical parent task.

External-party linkage lets the same project roll up cleanly across department, namespace, and
commercial scope. Use plural `party_slugs` for broad relationship attachment and the singular
`client_slug` or `brand_slug` only when one primary scope matters.

## Governing rules and doctrine

The canonical planning ladder (`initiative`, `project`, `task`) and the rule that
specialized execution layers hang off the parent task without changing the ontology are in
[[planning-to-execution-ladder]] and [[core-doctrine]]. A project never becomes a second
backlog, and a swarm sprint is not a canonical project. The personal-versus-shared split
and the intake and synthesis linkage are the operating discipline; the operative project
pointers (`state_stored_at`, `analytical_view`) are checked by `validate.sh`. See
[[system-overview]] for how projects sit in the entity set.
