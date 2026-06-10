# Department Assembly Rules

`departments/` is the operating assembly layer for AI shadow departments. A department is
not a new low-level ontology primitive. It is a named business-function surface that
gathers the existing primitives needed to run that function as an AI-first operating unit:
intake, namespaces, agents, workflows, tools, metrics, projects, and human review gates.

The doctrine that explains why this layer exists is:

- `knowledge/ai-architecture/canon/department-model.md`
- `knowledge/ai-architecture/concepts/department-assembly-model.md`
- `knowledge/ai-architecture/playbooks/translate-business-function-into-ai-shadow-department.md`

This file is the operative contract for how departments are represented in this repo.

## Required shape

Each real department lives at:

```text
departments/<department-slug>/INDEX.md
departments/<department-slug>/CHARTER.md
```

The `INDEX.md` is the department's durable start-here and assembly surface. It must define:

1. the business function the department owns
2. the head-of-department agent
3. the intake surfaces that should hit AI first
4. the core namespaces the department reasons from
5. the core execution surfaces (skills, workflows, tools, projects, metrics)
6. the human approval and escalation layer
7. the daily update surface and rollup target
8. any subdepartments and current gaps
9. any materially related repos outside `infinite-brain-os`
10. its owned projects and active swarms, when they exist

When a department is materially scoped to one or more external parties, the `INDEX.md` should also
state:

- `scope_class`: `shared-platform | internal-product | client-scoped | brand-scoped | multi-party`
- `party_slugs`: the stable external-party keys that matter to the department
- `client_slug` and `brand_slug` when one primary commercial scope clearly dominates

The `CHARTER.md` is the department's operating-intent surface. It must define the mission,
north star, owned outcomes, KPI set, constraints, related entities, and reporting cadence.

For any department that declares KPIs in `CHARTER.md`, the `INDEX.md` should also make one
of these true:

- link the Data System namespace that defines the KPI lineage
- link the shared Data System namespace the department consumes
- state explicitly that the KPI set is provisional because no Data System namespace exists yet

Do not leave KPI ownership implicit. A department may consume a shared or Example Co-backed
Data System rather than owning bespoke pipelines, but it must say which posture it uses.

Do not store department doctrine in `departments/`. The durable reasoning belongs in
`knowledge/ai-architecture/`. `departments/` is the operating assembly and routing layer.

## Required links

Every real department `INDEX.md` should link directly to:

- its head-of-department agent under `entities/agents/`
- at least one core namespace under `knowledge/`
- at least one workflow under `workflows/`
- at least one intake path or intake playbook under `intake/`

If the department materially depends on other repos under
`<legacy-root>`, it should also link to the relevant entries under
`repo-registry/`.

If a department does not yet have one of these, state the gap explicitly under `Open Gaps`.

If a department is materially client- or brand-scoped, it should also link to the relevant
`parties/` records.

## Department ownership model

Each department should have exactly one primary head-of-department agent. That agent owns:

- first-pass triage for department intake
- orchestration across specialist agents and workflows
- escalation to human review when thresholds are hit
- the department's daily update
- the department's contribution to a wider daily rollup

Specialist agents may exist beneath it, but the department should not be an unowned pile of
components.

## Optional frontmatter guidance

When a node, workflow, agent, or skill is clearly owned by one or more departments, it may
declare:

```yaml
departments: [personal-health]
```

This field is optional. It is a cross-reference aid, not the source of truth. The source of
truth for department membership is the department `INDEX.md`, because that assembly surface
is explicit, reviewable, and portable across Obsidian, Paperclip, Claude Code, and Codex.

The same posture applies to party scope. Optional metadata such as:

```yaml
party_slugs: [acme, drift]
client_slug: "acme-crm"
brand_slug: "drift"
```

may be used on nodes that materially tie to an external commercial scope, but the durable source
of truth for department scope remains the department `INDEX.md` and the corresponding `parties/`
records.

Do not rely on `departments:` alone to define a department. Tags and metadata can assist
queries or generated indexes later, but the department must still have a written assembly
surface.

## Intake boundary

Departments do not own intake as a separate knowledge namespace. They consume the root
`intake/` fabric. A department may have:

- source-specific intake paths that often route to it
- intake playbooks tailored to its domain
- destination receipts under `intake/destinations/<department-or-namespace>/`

But the intake system itself remains root OS infrastructure.

## Tool and runtime boundary

Department indexes may reference runtime tools, data systems, and adapters. They should not
store live operational state. If a department needs a runtime map for Paperclip or another
surface, that mapping should be documented as a contract, not mixed into doctrine or hidden
in UI-only configuration.

See `department-runtime-contract.md`.

## Shared platform functions

Do not assume every department owns its own full software-delivery and runtime substrate.
Cross-cutting platform capabilities usually belong in a shared platform department, such as:

- GitHub standards
- CI/CD
- deployment posture
- secrets and environment management
- observability and rollback

Domain departments should usually own only their local adaptation layer on top of that
shared platform. Create a standalone platform department when the capability is truly
cross-cutting and standardization matters more than domain isolation.

## First implementation guidance

When building a first live department:

1. start from the highest-value business function that already has a meaningful namespace
2. bind one head-of-department agent
3. bind one daily update workflow
4. bind one rollup workflow target
5. state the current tool and intake gaps honestly instead of pretending they are built

The first department should prove the assembly model before the repo carries many of them.
