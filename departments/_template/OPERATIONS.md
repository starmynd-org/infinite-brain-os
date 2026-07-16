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
| Department session startup | `lifecycle: on-startup` | `entities/skills/manage-ai-session.md` and `knowledge/ai-architecture/playbooks/open-and-close-ai-session.md` | `<department-head-agent>` | Session record in `sessions/active/` and an initial-context note; scan `departments/<department-slug>/capture/` and open blockers before substantive work | Append-only receipt under `departments/<department-slug>/receipts/` keyed to the session id | `external: false; canon-touching: false` |
| Department session closeout | `lifecycle: on-closeout` | `workflows/session-closeout-review.md` | `<department-head-agent>` | Closeout review in `sessions/reviews/`; extract memory, PKM, follow-up, and swarm candidates; drain `departments/<department-slug>/capture/` into routed candidates | Append-only receipt under `departments/<department-slug>/receipts/` keyed to the closeout id | `external: false; canon-touching: false` |
| `<Domain recurring task>` | `scheduled: monthly` | `<existing workflow, playbook, or skill>` | `<department-head-agent or specialist>` | `<named output artifact or destination>` | `<what receipt must be written and where>` | `external: <true|false>; canon-touching: <true|false>` |
| `<Condition task>` | `condition: <criteria match>` | `<existing workflow, playbook, or skill>` | `<department-head-agent or specialist>` | `<named output artifact or destination>` | `<what receipt must be written and where>` | `external: <true|false>; canon-touching: <true|false>` |
| `<Callable task>` | `on-call: <allowed caller>` | `<existing workflow, playbook, or skill>` | `<department-head-agent or specialist>` | `<named output artifact or destination>` | `<what receipt must be written and where>` | `external: <true|false>; canon-touching: <true|false>` |

## Notes

- Every row carries exactly one trigger field.
- Use existing workflows, playbooks, or skills. Do not restate their internal steps here.
- The minimum set in every real department is the daily update, the weekly summary, and the two
  universal lifecycle rows (`on-startup` and `on-closeout`). The lifecycle rows are identical across
  departments except for the slug; copy them as-is. See
  `knowledge/ai-architecture/playbooks/department-operations-readiness.md`.
- Receipts are audit artifacts. Runtime queue state stays outside git.
- This register holds triggered tasks (when work starts). The department's SOP library at
  `departments/<slug>/sops/` holds the templated procedures themselves (how a repeatable task is
  run). A register row may name an SOP as its implementing procedure; do not inline SOP steps here.
