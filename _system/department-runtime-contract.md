# Department Runtime Contract

This file defines how a durable department assembly in `departments/` maps to runtime
surfaces such as Paperclip, Obsidian, and future orchestration layers.

The core rule is simple: `departments/<slug>/INDEX.md` is the durable assembly source of
truth. Runtime tools read from it or from a derived mapping. They do not define the
department.

## Durable versus runtime

| Layer | Purpose | Home |
|---|---|---|
| durable assembly | business function, ownership, linked components, rollup design | `departments/<slug>/INDEX.md` |
| doctrine | why departments exist and how to design them | `knowledge/ai-architecture/` |
| operative rules | what a department surface must contain | `_system/department-assembly-rules.md` |
| runtime mapping | the IDs and endpoints a tool like Paperclip needs | derived mapping or companion runtime doc |
| live state | queue contents, daily status, approvals, metrics state | runtime substrate, not markdown canon |

## Minimum runtime mapping fields

If a department is projected into Paperclip or another runtime surface, the mapping should
make these fields explicit:

- `department_id`
- `department_name`
- `head_agent`
- `owned_namespaces`
- `owned_workflows`
- `owned_tools`
- `primary_intake_sources`
- `daily_update_output`
- `daily_rollup_target`
- `human_review_gates`

These may live in:

- a runtime adapter file
- a generated JSON artifact
- a companion runtime note

But they must be derivable from the department `INDEX.md`.

## Obsidian

Obsidian sees `departments/` automatically because it reads the vault from disk. Wikilinks
and backlinks will work out of the box. Automatic rollups by department are optional and
should be treated as convenience, not as the core contract.

If metadata-driven rollups are later added, use the optional `departments:` frontmatter
field described in `department-assembly-rules.md`, but keep the written department `INDEX.md`
as the primary assembly surface.

## Paperclip

Paperclip is the most natural live runtime for departments:

- it can present the head-of-department agent view
- it can show intake queues and escalations
- it can display the department daily update
- it can roll department updates into a wider executive brief

Paperclip should treat the department as an operational cockpit over:

- root `intake/`
- `knowledge/`
- `entities/`
- `workflows/`
- `departments/`

It should not mutate the canonical node shape or hide the durable mapping only in runtime
state.

## Daily update pattern

Every real department should have:

- one daily update workflow that emits a department-level update
- one rollup target that receives that update

The update should answer, at minimum:

- what came in
- what was processed
- what changed
- what is blocked
- what needs human review
- what should happen next

## Future automation posture

The runtime mapping is intentionally light in this repo today. Start with explicit markdown
assembly and add generated adapters later. Do not wait for a perfect runtime to define
department structure correctly.
