# Swarm Sprint Rules

This file is the operative contract for durable swarm governance inside
`infinite-brain-os`.

Doctrine lives in:

- `knowledge/ai-architecture/concepts/planning-to-execution-ladder.md`
- `knowledge/ai-architecture/playbooks/swarm-launch-governance.md`
- `knowledge/ai-architecture/concepts/surface-boundary.md`
- `knowledge/ai-architecture/playbooks/open-and-close-ai-session.md`

## Purpose

Use this rule file to answer:

- where new canonical swarm work lives
- what a valid sprint package must contain
- how a sprint records its single canonical parent-task anchor
- what launch approval is required before a sprint becomes active
- what closes back into planning truth when a sprint finishes
- what runtime state must stay out of git

## Canonical home

New canonical swarm work lives in:

```text
infinite-brain-os/swarms/Sprints/
```

Treat:

```text
<legacy-root>\swarms
```

as legacy source-material and historical reference only. Use it when a task explicitly needs
legacy swarm doctrine, legacy operating receipts, or source migration evidence. Do not treat
it as the canonical home for new swarm execution in this repo.

## Required sprint-package shape

Each sprint lives at:

```text
an internal build record (not shipped)<slug>/
```

Minimum required files:

- `README.md`
- `00-sprint-charter.md`
- `01-master-plan.md`
- `02-launch-sheet.md`
- `03-acceptance-gates.md`
- `SESSION-LINK.md`
- `waves/README.md`

Recommended additions when the sprint is approved or in flight:

- `APPROVAL-RECEIPT.md`
- `waves/BLOCKERS-AND-DECISIONS.md`
- closeout or completion summary artifacts

Write sprint outputs under `waves/` unless the artifact is a top-level charter, launch gate,
or closeout surface.

## README metadata anchor

`README.md` is the sprint's durable metadata anchor. It should carry frontmatter with:

```yaml
sprint_id: "sprint-YYYY-MM-DD-slug"
sprint_status: "scoped"
execution_mode: "swarm"
parent_task: "<project-slug>#<task-id>"
linked_project: "projects/<slug>/PLAN.md"
owning_department: "<department-slug>"
approval_receipt: "an internal build record (not shipped)"
cross_refs:
  - type: "project"
    target: "projects/<other>/PLAN.md"
  - type: "department"
    target: "departments/<slug>/INDEX.md"
```

Rules:

- `parent_task` is required and singular. It is the canonical anchor for control, ownership,
  approval, and closeout.
- `cross_refs` is additive only. Use it for touched tasks, projects, departments, repos,
  namespaces, tools, and surfaces that matter for context, dependency, or impact.
- `linked_project` should resolve to the project that owns the parent task.
- `owning_department` names the department that owns execution of the sprint itself.

## Sprint status model

Allowed durable statuses:

- `scoped`
- `ready`
- `active`
- `blocked`
- `complete`
- `needs_followup`
- `archived`

Use the README frontmatter `sprint_status` field as the durable lifecycle record. Do not build
live queue state, assignment state, approval workflow state, or event streams into git.

## Launch gate

Before a sprint may move to `sprint_status: active`, all of the following must be true:

1. `parent_task` resolves to exactly one task in a project file.
2. The parent task explicitly uses `mode: swarm`.
3. The sprint README records `execution_mode: swarm`.
4. A file-backed approval receipt exists.
5. The approval receipt reflects a human-granted launch decision.

The approval receipt may be concise. It should at minimum record:

- sprint id or path
- approver
- approval date
- scope approved
- notable guardrails or deferrals

The reusable launch doctrine is `knowledge/ai-architecture/playbooks/swarm-launch-governance.md`.
This file states the operative repo contract only.

## Sessions dual-write

If a chat is actively working inside a sprint, update both surfaces on purpose:

- `sessions/` for the conversation archive and closeout extraction
- an internal build record (not shipped) for sprint-facing execution state and artifacts

Every sprint should keep `SESSION-LINK.md` pointing at the active or closed session record.

## Closeout writeback

When a sprint closes, write back only bounded planning truth:

- parent-task status
- completion date
- sprint status
- latest summary or closeout path
- outcome and evidence

Do not write live task queues, in-flight approvals, terminal assignment state, or event
streams back into planning files.

`swarms/completed/COMPLETED-WORK.md` is the durable shipped-work ledger for this subtree.

## Historical backfill allowance

Some earlier sprints predate this contract and do not carry a recorded `parent_task` or
approval receipt. They may appear in the completed-work ledger with:

- `parent_task: pre-contract-unrecorded`
- `approval_receipt: pre-contract-unrecorded`

This allowance exists only for honest backfill. New sprints must follow the full contract.

## Runtime exclusion

Per `surface-boundary`, these never become authoritative git state here:

- live queue state
- in-flight approvals
- runtime event streams
- mutable multi-user assignment state
- cockpit-only derived views

Git keeps durable execution packaging and bounded writeback only.

## Deterministic versus curator split

`bash _system/validate.sh` may enforce deterministic checks such as:

- required sprint scaffold presence
- sprint README metadata presence when a sprint is on the new contract
- project-file required fields

The validator does not own fuzzy judgments such as:

- whether a sprint should have been routed to swarm
- whether approval reasoning was substantively good
- whether cross references are sufficient for human comprehension

Those stay with curator review and the human approval gate.
