---
id: "departments-index"
aliases: ["departments-index"]
type: "Doc"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "The department map: every folder under departments/ with its disposition, so the live department set is unambiguous."
confidence: 0.9
retrieval_class: "identity"
export_class: "public"
created: "2026-06-10"
---

# Departments: The Department Map

One row per department folder with its current disposition, so a reader can tell at a glance
which lanes are live. This is a navigation surface, not the source of truth for any one
department's membership; each department's INDEX.md owns its own assembly.

| Department | Disposition | Notes |
|---|---|---|
| `_template/` | template | the assembly pattern every department starts from |
| `example-studio-ops/` | example | the worked example department for the starter walkthrough |

Assemble a new department by copying `_template/`, following `departments/README.md` and
`_system/department-assembly-rules.md`, then add a row here with disposition `live`.
