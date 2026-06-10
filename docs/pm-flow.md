# PM Flow

This personal repo is not the shared execution anchor. It is where you draft, test, and refine work before promoting it.

## Default personal path

At T1 and T2, keep project tasks in `projects/{name}/PLAN.md` as a local checklist.

Use this repo when:

- the work is still exploratory
- the owner is still deciding scope
- no shared execution package is needed yet

## When to move into shared canonical planning

Move the planning anchor into the department or company repo when:

- multiple people or roles will execute the work
- the task needs a durable deliverable contract
- `execution_mode` matters for routing
- a swarm, workflow, or managed agent handoff is needed

The shared planning ladder is:

- `initiative -> project -> task`

Set `execution_mode` on the shared canonical task, not only in this personal repo.

## Swarm-backed task rule

Do not launch shared swarm work from a personal checklist alone.

Instead:

1. Shape the work here.
2. Create or update the canonical task in the shared repo.
3. Mark `execution_mode: swarm` there if the task needs multi-lane execution.
4. Keep launch human-gated and fail-closed.
