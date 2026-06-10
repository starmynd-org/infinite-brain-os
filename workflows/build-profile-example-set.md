---
id: "workflow-build-profile-example-set"
aliases: ["workflow-build-profile-example-set"]
type: "Workflow"
namespace: "personal-operator"
lifecycle_state: "research"
summary: "Generate or refresh the knowledge/_examples profile scaffolds, one reference namespace per profile."
confidence: 0.85
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[skill-build-profile-example-namespace]]"
    relation: "uses"
    confidence: 0.92
  - target: "[[namespace-profiles]]"
    relation: "depends_on"
    confidence: 0.9
  - target: "[[profile-lint-rules]]"
    relation: "governed_by"
    confidence: 0.88
  - target: "[[namespace-index-schema]]"
    relation: "depends_on"
    confidence: 0.85
  - target: "[[canon-layer-schema]]"
    relation: "depends_on"
    confidence: 0.82
  - target: "[[metric-primitive-schema]]"
    relation: "references"
    confidence: 0.7
created: "2026-05-30"
runtime: "agentic"
---

# Workflow: Build Profile Example Set

A reasoning pipeline that generates or refreshes the reference example namespace for each
of the eight profiles under `knowledge/_examples/`. These scaffolds are the second and
third reference implementations the architecture wants: they show what each profile's
shared base plus profile-specific folders look like in practice, and they let a
Provisional profile be validated against a concrete example before a real namespace
adopts it. The example set is reference material, not a real namespace, and every example
INDEX.md says so.

The deterministic structure checks (required base surfaces, expected-folder match,
frontmatter, link resolution) run via `_system/validate.sh`. The authoring work, writing
a credible scaffold that demonstrates the profile correctly, is the work of this workflow
and [[skill-build-profile-example-namespace]].

## When to run

- After a profile schema in [[namespace-profiles]] is added or changed, to keep the
  example in sync with the profile contract.
- When a Provisional profile needs a concrete reference before a real namespace adopts
  it.
- On a periodic refresh, so the examples do not drift from the current base and INDEX.md
  contracts.
- The operator may scope this to one profile or run it across all eight.

## Inputs

- The eight profile definitions in [[namespace-profiles]] (the operative profile
  registry and the authoritative home for the folder schemas).
- The shared base contract (every serious namespace: `INDEX.md`, `canon/`, `playbooks/`,
  `support/`, `synthesis/`).
- The canon contract in [[canon-layer-schema]], the index contract in
  [[namespace-index-schema]], and the metric primitive in [[metric-primitive-schema]]
  for the Data System and Operating Library examples.
- The lint contract in [[profile-lint-rules]], which states the per-profile checks each
  example must pass.
- The existing `knowledge/_examples/` tree, so a refresh updates rather than duplicates.
- The sprint's `Profile_Examples/` folder, which holds the example-authoring briefs.

## Pipeline

### Step 1: Determine the work set

List the eight profiles. For each, check whether an example namespace already exists under
`knowledge/_examples/`. Mark each as create (no example yet), refresh (exists but the
profile schema or contracts changed), or skip (current). Produce the work set.

### Step 2: Build or refresh each example

For each profile in the work set, apply [[skill-build-profile-example-namespace]]. The
skill scaffolds the shared base plus the profile-specific folders from
[[namespace-profiles]], writes a thin but real canon at the posture the example uses,
writes an INDEX.md to the [[namespace-index-schema]] contract that declares the profile
and states the namespace is an example, and seeds the profile-specific files the lint
rules require (for example, a metric node using [[metric-primitive-schema]] for the Data
System and Operating Library examples). Provisional profiles carry an explicit "validate
on first real namespace" note.

### Step 3: Run the per-profile lint

For each example, apply the checks in [[profile-lint-rules]]: the required base surfaces
present, the profile folders present and matching `expected_folders`, the profile's
emphasis checks satisfied (for example a Tool Contract example has payload examples; a
Data System example has a metric with source lineage). Record pass or fail per profile.

### Step 4: Run the deterministic validator

Run `bash _system/validate.sh`. Fix any error (frontmatter, dead links, dash ban,
missing base surface) before the example is considered done. The examples are exempt
from some node-frontmatter checks where they are navigational, but their core-doctrine
and substantive synthesis nodes still require full node frontmatter.

### Step 5: Produce the build Output

Save to `outputs/build-profile-example-set-{date}.md` with the work set (Step 1), what
was created or refreshed per profile, the per-profile lint results, and the validator
result.

Output frontmatter:
```yaml
---
id: "output-build-profile-example-set-{date}"
type: "Output"
namespace: "personal-operator"
lifecycle_state: "scratch"
produced_by: "[[workflow-build-profile-example-set]]"
created: "{date}"
---
```

## Output format

A single Output node at `outputs/build-profile-example-set-{date}.md`. Body sections, in
order: work-set table (profile, action, reason), per-profile build summary with the files
written, per-profile lint result, and the validator result.

## Notes

- The examples are reference scaffolds under `knowledge/_examples/`, not real namespaces.
  Each example INDEX.md states this so an agent never loads an example as if it were
  operator-approved canon.
- This workflow does not promote an example into a real namespace. Promotion is a
  separate decision: a real namespace is born via the build-namespace skill, informed by
  the matching example.
- A Provisional profile example exists precisely to be tested against the first real
  namespace of that type. When that real namespace lands and the profile holds, update
  the profile registry maturity tag from Provisional to Stable and refresh the example.
- The Data System and Operating Library examples must demonstrate the shared metric
  primitive: one `metric_id` defined once, with lineage on the Data System side and
  diagnosis on the Operating Library side.
