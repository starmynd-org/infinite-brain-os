---
id: "skill-build-namespace"
aliases: ["skill-build-namespace", "build-namespace"]
type: "Skill"
namespace: "personal-operator"
lifecycle_state: "research"
summary: "Build or migrate an Infinite Brain namespace with explicit boundary rules, canon-selection logic, target node map, and provenance-aware source handling."
confidence: 0.96
retrieval_class: "identity"
export_class: "internal"
description: "Use this skill when a new namespace must be created or a legacy corpus must be migrated into a namespace without collapsing the source material into a few summary notes."
edges:
  - target: "[[skill-build-knowledge-node]]"
    relation: "paired_with"
    confidence: 0.88
  - target: "[[skill-build-swarm-sprint]]"
    relation: "paired_with"
    confidence: 0.82
  - target: "[[namespace-profiles]]"
    relation: "depends_on"
    confidence: 0.92
  - target: "[[namespace-index-schema]]"
    relation: "depends_on"
    confidence: 0.9
  - target: "[[canon-layer-schema]]"
    relation: "depends_on"
    confidence: 0.88
  - target: "[[infinite-brain-namespace-architecture-v2]]"
    relation: "informed_by"
    confidence: 0.9
  - target: "[[required-namespace-surfaces]]"
    relation: "informed_by"
    confidence: 0.88
created: "2026-05-29"
---

# build-namespace

Use this skill when creating a new namespace or migrating a corpus into one. A namespace
built today is V2-compliant by default: it declares a profile, carries the shared base
surfaces, ships a disciplined canon, ships within-namespace synthesis, exposes an
INDEX.md retrieval router, and registers its posture fields in `_system/`. The older
canon-selection and provenance rules below still apply; V2 adds the profile model, the
physical canon and synthesis surfaces, and the registry posture fields on top of them.

## Use when

- the work needs a governance bucket larger than a single node
- several related nodes should share one namespace identity
- a legacy PKM corpus needs structured migration into Infinite Brain
- namespace boundaries, canon rules, and source provenance matter
- a namespace must be born V2-compliant (declared profile, shared base, canon,
  synthesis, INDEX.md router, registry posture fields)

## Do not use when

- one standalone node is enough
- the source material is still too fuzzy to define namespace boundaries
- the work is mostly runtime state or secrets
- the inbound material is unprocessed and should land in the root `intake/` fabric
  first; route it through [[process-namespace-intake]] before it earns a namespace home

## Goal

Produce a namespace that is structurally sound, provenance-aware, profile-declared, and
explicit about:

- which of the eight profiles it is and why
- what belongs in the namespace
- what does not
- what becomes compressed canon (synthesis, not paraphrase)
- what stays as within-namespace synthesis (derived thinking)
- what stays as support material (provenance and migration) or raw-source archive
- which agents and outputs the canon should improve (output linkage)

## Required outputs

1. registry entry under `_system/namespaces/<ns>.md` with V2 posture fields (`profile`,
   `v2_status: upgraded` for a born-V2 namespace, `canon_posture`, `freshness_posture`,
   `archive_posture`, `expected_folders`) plus optional `party_slugs`, `client_slug`, and
   `brand_slug` when commercial scope materially shapes the namespace, and the `## Profile and folders` and
   `## Review posture` body sections
2. registry index update in `_system/namespaces/INDEX.md`
3. namespace `INDEX.md` retrieval router following [[namespace-index-schema]]
4. the shared base surfaces: `canon/`, `playbooks/`, `support/`, `synthesis/`
5. profile-additive folders for the chosen profile
6. canon files matching `canon_posture` (`canon/README.md`, `canon/core-doctrine.md`,
   `canon/agent-load-order.md` for full canon)
7. source manifest and namespace boundary rules
8. node briefs or migration briefs
9. a passing `bash _system/validate.sh` run

## The V2 namespace model

A serious namespace is one ontology expressed through one of eight profiles. The profile
adds folders to a shared base; it never removes a base surface and never forks the
ontology. The operative profile registry is [[namespace-profiles]] in `_system/`; the
reasoning behind the model is [[profile-aware-knowledge-graph-design]] and
[[infinite-brain-namespace-architecture-v2]] in `ai-architecture`.

### Choose one of the eight profiles

Pick the profile by the namespace job, then confirm against [[namespace-profiles]]:

- **doctrine** (Stable): durable concepts, principles, decisions, reusable doctrine.
  Profile-additive folders: `pillars/`, `concepts/`, `decisions/`, `archive/` when
  full-source preservation matters. Examples: `ai-architecture`, `ooda-john-boyd`,
  `david-deutsch`, `garytan`, `example-marketing`.
- **tool-contract** (Provisional): tell an agent exactly how to call a tool or API.
  Additive: `operations/`, `concepts/`, `decisions/`, `references/`, `examples/`. Canon
  file of record is `canon/core-contract.md`.
- **data-system** (Provisional, highest near-term value): document data flow from source
  APIs through extraction, transforms, warehouse layers, metric definitions, dashboards.
  Additive: `architecture/`, `source-contracts/`, `pipelines/`, `transforms/`,
  `models/`, `metrics/`, `references/`. Uses the [[metric-primitive]]. For a starter or
  lightweight repo, prefer a thin Data System first: real metrics, source contracts,
  pull or adapter playbooks, reference datasets, and explicit `live | manual | not-wired`
  status per metric. Point the implementation at your data-platform CLI when appropriate rather than
  forcing a bespoke warehouse build on day one.
- **design-system** (Provisional): approved visual and stylistic canon. Additive:
  `pillars/`, `tokens/`, `assets/`, `examples/`, `references/`.
- **component-library** (Provisional): approved reusable implementation patterns plus
  deployment and usage rules. Source code stays in its implementation repo. Additive:
  `components/`, `patterns/`, `examples/`, `deployment/`, `references/`.
- **content-strategy** (Provisional): themes, positions, angles and how they connect to
  marketing, product, doctrine, evidence. Additive: `pillars/`, `concepts/`, `angles/`,
  `examples/`, `references/`.
- **operating-library** (Provisional): how to execute recurring work and diagnose
  problems. Additive: `procedures/`, `diagnostics/`, `decision-trees/`, `examples/`,
  `references/`, plus `metrics/` when tied to metric diagnosis (uses the metric
  primitive).
- **intake-fabric** (Stable, root layer): receives inbound items, preserves source
  context, tracks routing. Lives at repo root under `intake/`, not under
  `knowledge/<namespace>/`. See [[intake-fabric-namespace]]. Do not build an
  intake-fabric namespace with this skill; build the root scaffold instead.

If two profiles seem to fit, keep them distinct and pick the one matching the primary
job. Design System and Component Library share "approved reusable artifact" DNA; Tool
Contract, Data System, and Operating Library share "executable contract plus
diagnostics" DNA. Do not pre-merge them.

### Shared base surfaces (every serious namespace)

Required regardless of profile, per [[required-namespace-surfaces]]:

- `INDEX.md`: the retrieval router (see the INDEX contract below)
- `canon/`: the compressed reasoning layer
- `playbooks/`: repeatable procedures
- `support/`: provenance and migration only
- `synthesis/`: within-namespace derived thinking

Starter and example namespaces (`personal-operator`, `knowledge/_examples/*`) may carry
a reduced base and must say so in their `INDEX.md`.

### The canon requirement and canon_posture

Canon is compressed, operator-approved, provenance-bearing first-principles synthesis. It
is what a future agent loads first and reasons from before expanding into the deeper
graph. It is closer to the synthesized Boyd HTML docs than to a one-line loader. Canon
synthesizes and compresses; it does not paraphrase `pillars/` node by node, and it is not
a parking lot for open questions. The operative rules are [[canon-layer-schema]]; the
reasoning is [[canon-layer]] and [[what-canon-means]].

Set `canon_posture` to one of:

- **full**: `canon/README.md` (navigational), `canon/core-doctrine.md` (a knowledge node
  with full frontmatter, plus `verified_at`, `verified_by`, `derived_from` edges, and a
  `## Changelog`), and `canon/agent-load-order.md` (navigational). Stateful namespaces
  add `canon/current-truth.md`. Use full for namespaces meant for real, deep retrieval.
- **thin**: `canon/README.md` plus a short `canon/core-doctrine.md` plus
  `canon/agent-load-order.md`. Use thin for small or early namespaces; a thin canon is a
  short disciplined synthesis, not an empty ritual.
- **none**: starter and template only (`personal-operator`); say so in `INDEX.md`.

### The synthesis requirement

`synthesis/` holds derived thinking that is neither raw archive nor settled canon node:
contradiction maps, best-current-reading notes, what-changed reviews, and canon-candidate
packages for that namespace. The promotion path is: raw source (archive or intake) ->
support (provenance recorded) -> synthesis (derived reading) -> canon-candidate -> canon
(operator-approved). Do not put synthesis in `support/`; do not put migration receipts in
`synthesis/` (see the support vs synthesis boundary in the Provenance rule below).

### The INDEX.md router contract

`INDEX.md` is the agent operating brief and retrieval router, not a folder list. It stays
rich markdown without node frontmatter (`validate.sh` exempts it). Follow
[[namespace-index-schema]]. Required sections in order:

1. `# <namespace>` title and a one-paragraph purpose
2. `## Profile` (the declared profile and a one-line why)
3. `## Load first` (canon entry points and the top three to five files, each with a
   one-line reason)
4. `## Query classes` (the common query types this namespace answers, each with the files
   to load)
5. `## Stable vs stateful` (durable doctrine versus what needs freshness review)
6. `## Open disputes` (contested questions and where they are tracked in `synthesis/`)
7. `## What this namespace drives` (the outputs, projects, or decisions this canon should
   improve)
8. `## Archive and provenance` (how to use `archive/` and `support/`, when present)
9. `## Common misreadings` (repeated failure modes)
10. `## Map` (the folder map, last, as reference)

### Set the registry posture fields

In `_system/namespaces/<ns>.md`, add to the existing frontmatter:

- `profile`: one of the eight profile slugs
- `v2_status: upgraded` for a born-V2 namespace
- `canon_posture`: `full | thin | none`
- `freshness_posture`: `review-on-edit | periodic | live` (scope freshness to where state
  decays; stable doctrine is `review-on-edit`)
- `archive_posture`: `archive-bearing | none`
- `expected_folders`: the base plus profile folders for this namespace

Add the `## Profile and folders` and `## Review posture` body sections. Keep the existing
`## Use for`, `## Do not use for`, `## Promotion path`, and `## Notes` sections.

### External party scope

Not every namespace should carry party metadata, but many client-facing or brand-facing namespaces
should. When external commercial scope materially shapes retrieval or delivery, add:

- `party_slugs`: broad external-party linkage
- `client_slug`: one primary client scope when applicable
- `brand_slug`: one primary brand scope when applicable

Do not create a namespace solely because a party exists. First ask whether the namespace has enough
retrieval value to justify a real boundary. If yes, add the party metadata to the namespace
registry and keep the corresponding identity record in `parties/`.

## Build steps

1. Confirm the source set.
2. Identify the corpus classes.
3. Choose the profile against [[namespace-profiles]] and record why.
4. Define the namespace boundary (what belongs, what does not).
5. Decide the namespace group, initial lifecycle posture, and the three posture fields
   (`canon_posture`, `freshness_posture`, `archive_posture`).
6. Decide whether the namespace needs `party_slugs`, `client_slug`, or `brand_slug`.
7. Scaffold the shared base (`canon/`, `playbooks/`, `support/`, `synthesis/`) plus the
   profile-additive folders, and record them in `expected_folders`.
8. If the profile is `data-system`, decide whether this is:
   - a full lineage namespace
   - a starter-thin semantic namespace backed by your data-platform CLI
   - or a starter-thin semantic namespace awaiting a client-owned adapter
9. Define canon, synthesis, support, and raw-source rules along the promotion path.
10. Map target node classes and paths.
11. Write the canon files to match `canon_posture` (full, thin, or none).
12. Seed `synthesis/` with at least a `README.md` and any known contradiction maps or
    best-current-reading notes.
13. Write the namespace `INDEX.md` router following the section order above.
14. Create the registry entry with V2 posture fields and `v2_status: upgraded`, plus any needed
    party metadata, then
    update `_system/namespaces/INDEX.md`.
15. Create the initial node set or migration packet.
16. Run `bash _system/validate.sh` and fix errors before proceeding.

## Provenance rule

Do not rely only on short source-name mentions in body text when the source set is
large or migration-heavy.

Prefer explicit provenance patterns such as:

- full source paths in manifests
- cited source sections in sprint artifacts
- node-level source posture notes that name the primary source set clearly

Keep the support versus synthesis boundary sharp. `support/` holds provenance, migration
receipts, source-priority tables, and reorganization maps: mechanical and historical
material. `synthesis/` holds derived intellectual work: interpretive and current. Derived
thinking goes in `synthesis/`, never in `support/`.

## Full-inclusion migration rule

If the migration requires full inclusion, represent the whole corpus deliberately.

Allowed forms:

- canonical knowledge nodes
- support notes
- manifests
- source-archive subtrees
- structured raw-source folders

Preferred archive pattern:

- `knowledge/<namespace>/archive/legacy-pkm-corpus/` for preserved copied source trees
- `knowledge/<namespace>/archive/manifest.tsv` for file-level auditability
- `knowledge/<namespace>/archive/README.md` for preservation notes and totals

Validator posture:

- preserved source archives under `knowledge/<namespace>/archive/` are archive material, not canonical nodes
- they should be excluded from node frontmatter validation
- do not try to retrofit full Infinite Brain frontmatter onto copied legacy corpus files

Not allowed:

- replacing the corpus with summaries only

## Quality checks

- the profile is declared and matches the namespace job
- the shared base surfaces are present (`INDEX.md`, `canon/`, `playbooks/`, `support/`,
  `synthesis/`) unless this is a declared starter or example namespace
- profile-additive folders match `expected_folders`
- canon files match `canon_posture`, and `canon/core-doctrine.md` carries `derived_from`
  edges, `verified_at`, `verified_by`, and a `## Changelog`
- canon synthesizes; it does not paraphrase `pillars/` node by node
- `INDEX.md` follows [[namespace-index-schema]] section order and names what the
  namespace drives
- registry posture fields are set (`profile`, `v2_status`, `canon_posture`,
  `freshness_posture`, `archive_posture`, `expected_folders`)
- namespace boundary and out-of-scope material are explicit
- lifecycle posture is explicit
- canon versus synthesis versus support versus raw-source rules are explicit
- provenance is strong enough for later audit
- `bash _system/validate.sh` passes

## Anti-patterns

- inventing a namespace before source boundaries are known
- building a namespace without declaring a profile
- skipping `canon/` or `synthesis/` on a serious namespace
- writing canon that paraphrases `pillars/` instead of compressing it
- parking open questions in canon instead of `synthesis/` or `intake/`
- putting derived thinking in `support/`, or migration receipts in `synthesis/`
- turning a giant corpus into a few pillar notes and calling it complete
- mixing volatile launch facts into stable doctrinal nodes (use `canon/current-truth.md`
  for live-but-canonical facts)
- treating the namespace `INDEX.md` as a folder list instead of a retrieval router
- building an `intake-fabric` namespace under `knowledge/` instead of the root `intake/`
  scaffold
- validating preserved source archives as if they were native Infinite Brain nodes
