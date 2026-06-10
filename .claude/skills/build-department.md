---
id: "skill-build-department"
aliases: ["skill-build-department", "build-department"]
type: "Skill"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Build a real AI shadow department assembly with a head agent, intake boundary, core namespaces and workflows, human review layer, and daily update posture."
confidence: 0.92
retrieval_class: "domain"
export_class: "internal"
description: "Use this skill when an operator wants to create or upgrade a department under departments/, including the assembly surface, ownership model, linked execution surfaces, and platform or intake implications."
edges:
  - target: "[[department-model]]"
    relation: "depends_on"
    confidence: 0.93
  - target: "[[department-assembly-rules]]"
    relation: "depends_on"
    confidence: 0.94
  - target: "[[department-runtime-contract]]"
    relation: "depends_on"
    confidence: 0.88
  - target: "[[workflow-build-department]]"
    relation: "paired_with"
    confidence: 0.9
  - target: "[[skill-build-agent]]"
    relation: "uses"
    confidence: 0.86
created: "2026-05-31"
---

# build-department

Use this skill to create or upgrade a real department under `departments/`.

The output is not a new ontology primitive. It is a durable operating assembly surface over
existing entities: intake, namespaces, agents, workflows, tools, metrics, projects, and
human review gates, plus a charter that states what the department is optimizing for.

## Use when

- a business or operating function should become a first-class AI shadow department
- an existing department scaffold needs real ownership, workflows, tools, or handoffs
- a shared platform capability should become an explicit department instead of being
  redefined in every domain team

## Do not use when

- the operator actually needs a knowledge namespace; use [[build-knowledge-base]]
- the work is only to add one agent or one workflow inside an existing department
- the function is too small or too vague to deserve its own assembly surface

## Build steps

1. State the department's business function and owned result.
2. Decide whether it is a domain department, a platform department, or a stewardship
   department.
3. Decide the external scope posture:
   - `shared-platform`
   - `internal-product`
   - `client-scoped`
   - `brand-scoped`
   - `multi-party`
4. If externally scoped, declare `party_slugs`, plus `client_slug` and `brand_slug` when one
   primary commercial scope dominates.
5. Define the intake boundary.
6. Define the head-of-department agent.
7. Link the core namespaces, workflows, tools, and review gates.
8. For every KPI set, decide the data posture:
   - backed by a department-owned Data System namespace
   - backed by a shared Data System namespace
   - or explicitly provisional with `live`, `manual`, or `not-wired` status per metric
9. Decide whether the department should consume a shared platform department instead of
   owning its own GitHub, CI/CD, or observability stack.
10. Write `CHARTER.md` with mission, north star, owned outcomes, goals, KPIs, constraints,
   related entities, escalation rules, and reporting cadence.
11. Define the daily update and rollup posture.
12. State the current open gaps honestly.
13. If the department lacks a head agent or workflow pattern, create them.
14. Copy `departments/_template/INDEX.md` and `CHARTER.md`; include the explicit Runtime Mapping block
    (the 10 `_system/department-runtime-contract.md` fields) so the Paperclip projection has one source.
15. Split the work into two named projects up front: `projects/<dept>-buildout/PLAN.md` (durable
    artifacts to the ceiling) and `projects/<dept>-activation/PLAN.md` (operator values, live
    human-in-loop, Paperclip projection, L1 pilot). See [[build-out-a-department]] for the split and the
    builder gotchas.

## Quality checks

- the department owns one clear function
- the assembly surface is explicit in `departments/<slug>/INDEX.md`
- if externally scoped, `scope_class`, `party_slugs`, and any primary `client_slug` or `brand_slug`
  are explicit and match the relevant `parties/` records
- the charter is explicit in `departments/<slug>/CHARTER.md` with `type: "Charter"`
- the head-of-department agent is defined or explicitly deferred, and its `tools` match what it actually
  does (add Bash or Task if it runs workflows or delegates), with its owned entities linked by wikilink
- the head reports to the fleet coordinator by default (`reports_to: fleet-coordinator` in the Runtime
  Mapping; `reportsTo: fleet-coordinator` in the Paperclip projection), so the department is wired into
  the fleet apex. The chief-of-staff is the only exception: a protected peer reporting to the operator,
  syncing with the fleet coordinator, never commanded by it. See
  `entities/rules/department-head-reporting-contract.md`.
- the Runtime Mapping block (10 fields) is explicit in the INDEX
- tools and workflows are linked, not implied; shared doctrine is referenced by full path or wikilink,
  never a bare relative path from `departments/`
- the intake boundary is explicit
- the KPI layer either links to a Data System or names the instrumentation gap explicitly
- shared platform dependencies are not reinvented unnecessarily
- the per-department acceptance gate is run (architecture conformance, end-to-end function, runs on
  Paperclip at L1, written built-but-not-working gap list) or explicitly deferred into the activation
  project, per [[build-out-a-department]]. Built does not equal working.
