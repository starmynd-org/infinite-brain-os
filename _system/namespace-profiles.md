# Namespace Profiles (Operative Registry)

This file is the authoritative operative schema for the eight namespace profiles. It is
what `build-namespace` and the linter read to know which folders a namespace of a given
profile must carry. It is the contract: the field-by-field "what." The reasoning, the
"why" a builder reads to understand the design, lives in [[namespace-profiles]] under
`knowledge/ai-architecture/concepts/`. This file shares that node's name and lives in a
different folder on purpose: the `_system` copy is the contract, the `concepts` copy is
the doctrine. Where the two disagree, this file is the operative authority and the
concept node should be corrected to match.

This file carries no node frontmatter. It is an operative reference doc, exempt from
`validate.sh` node-frontmatter checks because it lives under `_system/`. The per-namespace
profile declaration is a separate thing: it lives in each `_system/namespaces/<ns>.md`
registry entry via the `profile:` field, and those registry files DO carry frontmatter.

## The shared base (every serious namespace)

Every serious namespace, regardless of profile, carries exactly this base surface set.
A profile adds folders on top. A profile never removes a base surface and never forks the
ontology.

- `INDEX.md`: the retrieval router and agent operating brief. Schema in
  [[namespace-index-schema]].
- `canon/`: the compressed first-principles reasoning layer the agent loads first. Schema
  in [[canon-layer-schema]].
- `playbooks/`: repeatable procedures for the namespace.
- `support/`: provenance and migration only, mechanical and historical.
- `synthesis/`: within-namespace derived thinking, interpretive and current.

"Serious" means a namespace meant for real agent retrieval. Starter and example
namespaces (`personal-operator`, `knowledge/_examples/*`) may carry a reduced base and
MUST declare the reduction in their own `INDEX.md`. A missing base surface with no
declaration is a defect, not a reduction.

`validate.sh` enforces (deterministic): a serious namespace missing any of `INDEX.md`,
`canon/`, `playbooks/`, `support/`, `synthesis/` is an error. The starter-reduction
declaration in `INDEX.md` is enforced by a curator agent (fuzzy), because the validator
cannot tell an intentional starter from a gap without reading the declaration.

## Profile slug enum

A namespace declares exactly one of these slugs in its registry `profile:` field. The
slug is the join key between the registry, this schema, and the linter.

```text
doctrine | tool-contract | data-system | design-system |
component-library | content-strategy | operating-library | intake-fabric
```

## The eight profiles

Each profile below states: slug, job, the shared base folders (always the five above),
the profile-additive folders, the canon file of record, the lint emphasis, and maturity.

### doctrine

- Slug: `doctrine`
- Job: hold durable concepts, principles, decisions, and reusable doctrine.
- Shared base: `INDEX.md`, `canon/`, `playbooks/`, `support/`, `synthesis/`.
- Additive folders: `pillars/`, `concepts/`, `decisions/`, `archive/` (only when
  full-source preservation matters).
- Canon file of record: `canon/core-doctrine.md`.
- Lint emphasis: every pillar has at least one inbound edge; decisions carry a rejected
  alternative; canon `derived_from` edges resolve to real pillar, concept, decision, or
  archive nodes.
- Maturity: Stable. Real namespaces: `ai-architecture`, `ooda-john-boyd`, `david-deutsch`,
  `garytan`, `example-marketing`.

### tool-contract

- Slug: `tool-contract`
- Job: tell an agent exactly how to call a tool or API correctly.
- Shared base: `INDEX.md`, `canon/`, `playbooks/`, `support/`, `synthesis/`.
- Additive folders: `operations/`, `concepts/`, `decisions/`, `references/`, `examples/`.
- Canon file of record: `canon/core-contract.md` (in place of or alongside
  `core-doctrine.md`).
- System-fit requirement: `canon/core-contract.md` must state how the tool fits into the
  wider OS, what it is allowed to own, what remains outside the tool boundary, and which
  fit class applies. Use one of:
  - `ai-architecture-component`: the tool materially shapes the operating model, control
    plane, surface boundary, or planning-to-execution posture. These namespaces should
    link back into `_system/` and `knowledge/ai-architecture/`.
  - `os-operational-tool`: the tool is shared OS infrastructure or an important
    cross-department operational dependency, but does not redefine architecture doctrine.
  - `client-or-external-delivery-tool`: the tool is primarily used to deliver client or
    external work and should stay bounded to that delivery surface.
  - `department-local-tool`: the tool is mainly for one or two departments and should
    name those consumers explicitly rather than pretending to be global infrastructure.
- Lint emphasis: each operation node has a payload example; endpoints carry a freshness
  date; parameter names are consistent across operations and examples; the core contract
  includes an explicit system-fit section, not just operation details; support notes
  should record which listed operations were live-tested, dry-run tested, or only
  doc-derived at build time.
- Maturity: Provisional. Validate on first real tool-contract namespace. Ships as a
  reference scaffold in `knowledge/_examples/`.

### data-system

- Slug: `data-system`
- Job: document data flow from source APIs through extraction, transforms, warehouse
  layers, metric definitions, and dashboard use.
- Shared base: `INDEX.md`, `canon/`, `playbooks/`, `support/`, `synthesis/`.
- Additive folders: `architecture/`, `source-contracts/`, `pipelines/`, `transforms/`,
  `models/`, `metrics/`, `references/`.
- Canon file of record: `canon/core-doctrine.md`.
- Metric primitive: owns metric lineage. Metric nodes in `metrics/` follow
  [[metric-primitive-schema]] and this namespace owns the `lineage` face.
- Starter posture: a free or lightweight starter repo may ship a thin Data System
  implementation rather than a full warehouse build. The minimum useful starter shape is:
  canonical metrics, source contracts, pull or adapter playbooks, reference datasets, and
  explicit instrumentation status per metric (`live`, `manual`, `not-wired`). The
  implementation default may point to a managed substrate such as your data-platform CLI; non-Example Co
  users may either map their own sources into the same contract or leave the metric
  intentionally `not-wired`.
- Starter reduction rule: when a namespace is explicitly marked as a starter-reduced Data
  System in its `INDEX.md` and registry notes, `architecture/`, `pipelines/`, `transforms/`,
  and `models/` may be thin stubs rather than full lineage docs. The semantic contract stays
  real: `metrics/`, `source-contracts/`, `references/`, and `playbooks/` should still be
  substantive.
- Lint emphasis: every metric node has source lineage edges; every model node has refresh
  logic stated; every pipeline node maps to a transform node.
- Maturity: Provisional, highest near-term value. Validate on first real data-system
  namespace. Ships as a reference scaffold in `knowledge/_examples/`.

### design-system

- Slug: `design-system`
- Job: hold approved visual and stylistic canon.
- Shared base: `INDEX.md`, `canon/`, `playbooks/`, `support/`, `synthesis/`.
- Additive folders: `pillars/`, `tokens/`, `assets/`, `examples/`, `references/`.
- Canon file of record: `canon/core-doctrine.md`.
- Credential boundary: protected external design systems, asset stores, or client brand tools may
  be described here, but credential references resolve through the root `secrets/` registry and
  the owning tool or surface, never as namespace-owned secret material.
- Lint emphasis: asset examples are present; each component usage maps to a token node.
- Maturity: Provisional. Validate on first real design-system namespace. Ships as a
  reference scaffold in `knowledge/_examples/`. The deferred Image / Multimodal candidate
  is handled inside this profile for now.

### component-library

- Slug: `component-library`
- Job: hold approved reusable implementation patterns plus deployment and usage rules.
  Source code stays in its implementation repo; the namespace approves, constrains, and
  links.
- Shared base: `INDEX.md`, `canon/`, `playbooks/`, `support/`, `synthesis/`.
- Additive folders: `components/`, `patterns/`, `examples/`, `deployment/`, `references/`.
- Canon file of record: `canon/core-doctrine.md`.
- Lint emphasis: each component node links to a usage playbook; deployment notes are
  present for each component.
- Maturity: Provisional. Validate on first real component-library namespace. Ships as a
  reference scaffold in `knowledge/_examples/`.

### content-strategy

- Slug: `content-strategy`
- Job: hold themes, positions, angles, and how they connect to marketing, product,
  doctrine, and evidence.
- Shared base: `INDEX.md`, `canon/`, `playbooks/`, `support/`, `synthesis/`.
- Additive folders: `pillars/`, `concepts/`, `angles/`, `examples/`, `references/`.
- Canon file of record: `canon/core-doctrine.md`.
- Cross-links: heavily into `example-marketing`, `ai-architecture`, and thinker
  namespaces. Use cross-namespace edges per [[cross-namespace-edge-rules]].
- Lint emphasis: each angle node links to a supporting evidence or doctrine node; each
  position node states what it argues against.
- Maturity: Provisional. Validate on first real content-strategy namespace. Ships as a
  reference scaffold in `knowledge/_examples/`.

### operating-library

- Slug: `operating-library`
- Job: hold how to execute recurring work and how to diagnose problems.
- Shared base: `INDEX.md`, `canon/`, `playbooks/`, `support/`, `synthesis/`.
- Additive folders: `procedures/`, `diagnostics/`, `decision-trees/`, `examples/`,
  `references/`, and `metrics/` (only when tied to metric diagnosis).
- Canon file of record: `canon/core-doctrine.md`.
- Metric primitive: owns the `diagnosis` face. Metric diagnosis nodes reference the same
  `metric_id` the Data System namespace defines; they do not re-define the metric. See
  [[metric-primitive-schema]].
- Lint emphasis: every SOP node has a trigger; every diagnostic node has a next action;
  every procedure node has an escalation condition.
- Maturity: Provisional. Validate on first real operating-library namespace. Ships as a
  reference scaffold in `knowledge/_examples/`.

### intake-fabric

- Slug: `intake-fabric`
- Job: receive inbound items from many sources, preserve source context, track processing
  and routing, move high-signal items into durable homes.
- Location: this is a root OS layer at `intake/`, not a `knowledge/<namespace>/`
  namespace. A thin `knowledge/<intake-name>/` namespace may hold only distilled doctrine,
  decisions, playbooks, and receipts.
- Shared base: applies to the thin knowledge namespace if one exists. The root `intake/`
  tree follows the intake scaffold (contract Part 5), not the standard base. Live queues
  and connectors stay in the operational app layer; no live queue state in git.
- Additive folders (root `intake/`): `sources/`, `processed/`, `routing/`, `playbooks/`,
  `namespaces/`, `schemas/`.
- Canon file of record: the thin knowledge namespace, if present, uses
  `canon/core-doctrine.md` for distilled intake doctrine. The root `intake/` tree has no
  `canon/`; its routing doctrine lives in `intake/routing/`.
- Lint emphasis: every processed receipt has a routing decision and a destination link; a
  receipt missing either is an error in the `intake/` tree.
- Maturity: Stable as a root layer. See [[intake-fabric-namespace]] for why intake is a
  root layer and not an ordinary knowledge namespace.

## Profile-selection decision guide

A builder picks exactly one profile per namespace by answering these questions in order.
Stop at the first match.

1. Is this a convergence point for inbound items from many sources (X, YouTube, web,
   repos, email, Slack, ideas, research) that get triaged and routed to other namespaces?
   Pick `intake-fabric`. It lives at root `intake/`, not under `knowledge/`.
2. Does the namespace exist to tell an agent how to call a specific tool or API correctly,
   with endpoints, payloads, and parameters? Pick `tool-contract`.
3. Does the namespace document a data flow from source APIs through transforms, warehouse
   models, and metric definitions to dashboards? Pick `data-system`. This profile owns
   metric lineage.
4. Does the namespace hold approved visual and stylistic canon (tokens, assets, visual
   patterns)? Pick `design-system`.
5. Does the namespace hold approved reusable implementation patterns plus deployment and
   usage rules, while the code itself lives elsewhere? Pick `component-library`.
6. Does the namespace hold themes, positions, and angles for marketing, product, or
   editorial work, cross-linked to evidence and doctrine? Pick `content-strategy`.
7. Does the namespace hold how to execute recurring work and how to diagnose operational
   problems (procedures, diagnostics, decision-trees)? Pick `operating-library`. This
   profile owns metric diagnosis.
8. Otherwise, if the namespace holds durable concepts, principles, decisions, and reusable
   doctrine, pick `doctrine`. This is the default for a knowledge-and-reasoning namespace.

Disambiguation rules:

- Tool Contract, Data System, and Operating Library all carry "executable contract plus
  diagnostics" DNA. They answer different questions: how to call (tool-contract), where
  data flows (data-system), how to run and diagnose (operating-library). Pick by the
  primary question the namespace answers, not by surface overlap.
- Design System and Component Library both describe "approved reusable artifacts." Design
  System governs visual and stylistic canon; Component Library governs implementation
  patterns and deployment. Do not pre-merge them.
- When a namespace touches a metric, it does not become Data System or Operating Library
  on that basis alone. It links to the metric node by `metric_id` (see
  [[metric-primitive-schema]]). Only the lineage owner is Data System and only the
  diagnosis owner is Operating Library.

## Maturity summary

| Profile | Slug | Maturity |
|---------|------|----------|
| Doctrine | `doctrine` | Stable |
| Tool Contract | `tool-contract` | Provisional |
| Data System | `data-system` | Provisional |
| Design System | `design-system` | Provisional |
| Component Library | `component-library` | Provisional |
| Content Strategy | `content-strategy` | Provisional |
| Operating Library | `operating-library` | Provisional |
| Intake Fabric | `intake-fabric` | Stable (root layer) |

A Provisional profile carries an explicit "validate on first real namespace" obligation
and ships as a reference scaffold in `knowledge/_examples/` so the second and third
reference implementations exist before breadth is committed. When a real namespace of a
Provisional profile is built and trusted, the operator promotes that profile to Stable
here and the curator updates the table.

## How this file is read

- `build-namespace` reads the additive-folder list for the chosen profile to scaffold the
  correct folder set on top of the shared base.
- The linter reads `expected_folders` from the registry entry (which is the shared base
  plus this profile's additive folders) and warns on folders present that are not in that
  set, per [[profile-lint-rules]].
- A profile change on an existing namespace is a structural migration governed by
  [[migration-compatibility-rules]]: add the new additive folders, do not delete existing
  ones in the same wave, and update `expected_folders` in the registry.
