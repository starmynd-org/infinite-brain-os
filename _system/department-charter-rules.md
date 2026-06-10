# Department Charter Rules

Every serious department should carry a `CHARTER.md` alongside its `INDEX.md`.

The purpose of the charter is different from the index:

- `INDEX.md` is the assembly and routing surface
- `CHARTER.md` is the operating-intent and measurement surface

Without a charter, a department is only a topology. With a charter, it has a clear mission,
north star, owned outcomes, and declared metrics.

## Required shape

For each real department:

```text
departments/<department-slug>/INDEX.md
departments/<department-slug>/CHARTER.md
```

## Required frontmatter

Every department `CHARTER.md` is a node-bearing file and must carry frontmatter. Use:

```yaml
id: "department-<department-slug>-charter"
type: "Charter"
namespace: "<department namespace>"
lifecycle_state: "research"
summary: "<one line>"
confidence: 0.9
retrieval_class: "identity"
export_class: "internal"
created: "YYYY-MM-DD"
departments:
  - "<department-slug>"
```

Rules:

- `namespace` should match the department's `INDEX.md` namespace unless there is an explicit
  documented reason to diverge.
- `type` may be `Charter` for an operating-intent surface or `Knowledge` only if the file is
  intentionally absorbed into a broader knowledge-node pattern. Default to `Charter`.
- `departments` should contain the single department slug the charter belongs to.
- Keep operational detail such as mission, metrics, constraints, escalation, and reporting cadence
  in the charter body sections below rather than inventing ad hoc frontmatter fields.
- Optional scope metadata may be added when the charter is materially tied to one or more external
  parties:

```yaml
party_slugs: [acme, drift]
client_slug: "acme-crm"
brand_slug: "drift"
```

## Minimum charter sections

Each charter should define:

1. mission
2. north star
3. owned outcomes
4. key goals
5. KPI or metric set
6. targets, thresholds, or review posture for those metrics where possible
7. core constraints
8. related entities
   - parties when materially relevant
   - namespaces
   - agents
   - workflows
   - tools
   - projects if relevant
9. human review or escalation rules
10. reporting cadence
11. open gaps

## Metric posture

Departments should prefer explicit KPIs over vague activity reporting.

When a canonical metric definition already exists, the charter should reference that metric
instead of redefining it loosely. When no canonical metric exists yet, the charter may use a
provisional metric description and mark it as such.

## Relationship to daily updates

Department daily updates should report against the charter, not only against recent events.

That means the daily update should be able to answer:

- what happened today
- how that affects the department's owned outcomes
- whether any KPI moved, is blocked, or is at risk

## Relationship to builders

Any builder that creates a serious department should also create a charter or explicitly
state why one is deferred. A department without a charter is incomplete by default.
