# Projects

This folder holds the durable planning anchors for bounded work inside
`infinite-brain-os`.

Each project lives at:

```text
projects/<slug>/PLAN.md
```

The project file is the source of truth for intent and structure. A future modular UX may
project live state, dashboards, and rollups from these files plus runtime state, but the UX
must not invent a second planning system.

This README is the collection contract for project files.

## What a project is

A project is a scoped work container. It holds:

- the goal
- why the work matters
- scope and success criteria
- the owner and rollup home
- the task list
- links to swarms, outputs, departments, initiatives, repos, and related projects

The canonical ladder remains:

```text
initiative -> project -> task
```

Swarm sprints execute tasks. They do not replace the project as the planning anchor.

## Required file shape

Every project folder must contain:

```text
projects/<slug>/PLAN.md
```

Optional companion files may be added later if a project needs more depth, but `PLAN.md` is
the required anchor.

## Required frontmatter

Every `PLAN.md` must keep the node base and add the operational fields below.

Required node base:

```yaml
id: "project-<slug>"
type: "Project"
namespace: "<namespace>"
lifecycle_state: "research"
summary: "<one line>"
confidence: 0.9
retrieval_class: "domain"
export_class: "internal"
created: "YYYY-MM-DD"
```

Required operational fields:

```yaml
updated: "YYYY-MM-DD"
project_status: "active"
state_stored_at: "git://projects/<slug>/PLAN.md"
analytical_view: "none"
owner_department: "<dept-slug-or-none>"
owner_agent: "<agent-or-human-id>"
parent_initiative: "<initiative-slug-or-none>"
review_cadence: "weekly"
linked_swarm_id: "<sprint-id-or-none>"
```

## Relationship rules

Use flat fields for one-and-controlling anchors:

- `owner_department`
- `owner_agent`
- `parent_initiative`
- `state_stored_at`
- `analytical_view`
- `linked_swarm_id`

Use `edges:` for many-to-many links:

- supporting departments
- related projects
- executing swarms
- touched repos
- touched namespaces
- touched tools
- touched surfaces
- produced outputs

Example:

```yaml
edges:
  - target: "[[department-infinite-brain-ops-index]]"
    relation: "owned_by"
    confidence: 0.9
  - target: "[[project-legacy-swarms-migration]]"
    relation: "depends_on"
    confidence: 0.85
  - target: "[[sprint-2026-05-31-meta-operating-layer-hardening]]"
    relation: "executed_by"
    confidence: 0.88
  - target: "[[repo-swarms]]"
    relation: "touches"
    confidence: 0.8
```

## Required body sections

Use these sections in this order:

```markdown
# Project: <name>

## Goal
## Why this matters
## Scope
## Success criteria
## Ownership and rollup
## Dependencies and links
## Swarms
## Tasks
## Outputs
## Notes
## Change log
```

These sections are the stable modular-UX slots. Do not reorder them casually.

## Task shape

At T1 and T2, tasks live inline in `PLAN.md`. Each task should follow this shape:

```markdown
- [ ] `task-<slug>` Short task title
  - mode: manual | workflow | agent | swarm
  - status: proposed | ready | active | blocked | done
  - depends_on: <task-id or none>
  - blocks: <task-id or none>
  - acceptance: <one line, verifiable>
  - anchored_sprint: <sprint-slug or none>
```

Task ids must be unique within the project and addressable as:

```text
<project-slug>#<task-id>
```

## Initiative posture

Some current projects are really initiative-shaped. Until the initiative layer is fully built,
use:

- `parent_initiative: "none"` when a project stands alone
- `parent_initiative: "<slug>"` when the project belongs to a larger initiative

When initiative files exist, they should live at:

```text
initiatives/<slug>/INIT.md
```

## Modular-UX readiness checklist

A project file is modular-UX-ready when:

- all required frontmatter fields are present
- body sections follow the standard order
- each task has mode, status, dependency, and acceptance fields
- owner and initiative anchors are explicit
- many-to-many links are expressed through `edges:`
- no planning meaning lives only in prose when it can live in a stable field

## Do not do this

- Do not treat a swarm sprint as the canonical project.
- Do not create a second backlog in a UI or runtime surface.
- Do not store the only authoritative task meaning in Paperclip or another runtime store.
- Do not duplicate many-to-many relationships as both flat fields and `edges:`.
- Do not collapse `lifecycle_state` and `project_status`; they are different axes.

## Template

Use:

```text
projects/_template/PLAN.md
```

when creating a new project.
