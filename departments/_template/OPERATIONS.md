---
id: "department-template-operations"
type: "Doc"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Template operations register for department recurring and callable task contracts."
confidence: 0.88
retrieval_class: "identity"
export_class: "internal"
created: "2026-06-10"
---

# Department Operations Register Template

This file is the reusable task register template for a department's recurring and callable operations
contract. Keep it contract-only: no live run state, no checkboxes, no "done today" markers.

Use `entities/rules/trigger-taxonomy.md` for the trigger field vocabulary and
`_system/department-runtime-contract.md` for the durable-versus-runtime boundary.

| Task | Trigger | Implementing workflow or playbook or skill | Owner agent | Output target | Receipt requirement | Hard flags |
|---|---|---|---|---|---|---|
| Daily department update | `scheduled: daily` | `workflows/department-daily-update.md` | `<department-head-agent>` | `outputs/departments/<department-slug>/daily-update/<YYYY-MM-DD>.md` | Append-only receipt under `departments/<department-slug>/receipts/` keyed to the emitted update or rollup id | `external: false; canon-touching: false` |
| Weekly department summary | `scheduled: weekly` | `workflows/weekly-review.md` | `<department-head-agent>` | Weekly rollup packet for the fleet coordinator and the executive-brief path | Append-only receipt under `departments/<department-slug>/receipts/` keyed to the weekly summary id | `external: false; canon-touching: false` |
| `<Domain recurring task>` | `scheduled: monthly` | `<existing workflow, playbook, or skill>` | `<department-head-agent or specialist>` | `<named output artifact or destination>` | `<what receipt must be written and where>` | `external: <true|false>; canon-touching: <true|false>` |
| `<Lifecycle task>` | `lifecycle: on-startup` | `<existing workflow, playbook, or skill>` | `<department-head-agent or specialist>` | `<named output artifact or destination>` | `<what receipt must be written and where>` | `external: <true|false>; canon-touching: <true|false>` |
| `<Condition task>` | `condition: <criteria match>` | `<existing workflow, playbook, or skill>` | `<department-head-agent or specialist>` | `<named output artifact or destination>` | `<what receipt must be written and where>` | `external: <true|false>; canon-touching: <true|false>` |
| `<Callable task>` | `on-call: <allowed caller>` | `<existing workflow, playbook, or skill>` | `<department-head-agent or specialist>` | `<named output artifact or destination>` | `<what receipt must be written and where>` | `external: <true|false>; canon-touching: <true|false>` |

## Notes

- Every row carries exactly one trigger field.
- Use existing workflows, playbooks, or skills. Do not restate their internal steps here.
- The minimum scheduled set in every real department is the daily update and the weekly summary.
- Receipts are audit artifacts. Runtime queue state stays outside git.
