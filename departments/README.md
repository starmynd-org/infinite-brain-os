---
id: "departments-readme"
type: "Doc"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Root overview for the departments assembly layer in the Infinite Brain OS."
confidence: 0.87
retrieval_class: "identity"
export_class: "internal"
created: "2026-05-31"
---

# Departments: The Operating Assembly Layer

This folder is the operating assembly layer for AI shadow departments.

A department is not a new low-level entity type. It is a grouping surface over the existing
ontology: intake, knowledge namespaces, skills, agents, workflows, tools, metrics, projects,
and human review gates. The department layer makes those pieces legible as one business
function.

Use this folder for:

- one index or start-here guide per department
- one charter per department
- the head-of-department agent link
- the department's core namespaces and execution surfaces
- the department's materially related repos
- the department's daily update and rollup surfaces
- subdepartment maps when a function is broad enough to split

Most business departments should not each own a completely separate GitHub, CI/CD, secret,
deployment, and observability stack. Shared platform capabilities usually belong in a
standalone platform department, with domain departments owning only their local adaptation
layer.

Do not use this folder as the durable home of doctrine. Doctrine still belongs in
`knowledge/`. This folder is the assembly and routing surface.

Within this folder:

- `INDEX.md` = assembly, routing, and operating topology
- `CHARTER.md` = mission, north star, outcomes, KPIs, constraints, and reporting cadence

See:

- `knowledge/ai-architecture/canon/department-model.md`
- `knowledge/ai-architecture/concepts/department-assembly-model.md`
- `knowledge/ai-architecture/playbooks/translate-business-function-into-ai-shadow-department.md`
- `_system/department-charter-rules.md`
- `_system/repo-registry-rules.md`

Start from `_template/INDEX.md` when shaping a new department.

For reusable creation logic, see:

- `entities/skills/build-department.md`
- `entities/commands/build-department.md`
- `workflows/build-department.md`
