---
id: "knowledge-ai-architecture-namespace-profiles"
aliases: ["knowledge-ai-architecture-namespace-profiles", "ai-architecture-namespace-profiles"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Eight namespace profiles over one ontology: a shared base plus additive folders, each tagged Stable or Provisional, with watch-items against premature merges."
confidence: 0.9
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[profile-aware-knowledge-graph-design]]"
    relation: "depends_on"
    confidence: 0.9
  - target: "[[namespace-profile-set-v1]]"
    relation: "explains"
    confidence: 0.9
  - target: "[[namespace-profiles]]"
    relation: "explains"
    confidence: 0.88
  - target: "[[metric-primitive]]"
    relation: "related_to"
    confidence: 0.82
created: "2026-05-30"
---

## Summary

One ontology, eight profiles. Every serious namespace shares a single base surface set
and then adds profile-specific folders. A profile never removes a base surface and never
forks the ontology. This node is the "why" behind profiles. The operative registry, the
authoritative folder schema a builder follows, is [[namespace-profiles]] under `_system`.
That file shares this node's name but lives in a different folder: the `_system` copy is
the contract, this `concepts` copy is the reasoning.

## The shared base

Every serious namespace, regardless of profile, carries the same base: `INDEX.md`,
`canon/`, `playbooks/`, `support/`, and `synthesis/`. "Serious" means a namespace meant
for real agent retrieval. Starter and example namespaces such as `personal-operator` and
the `knowledge/_examples/*` scaffolds may carry a reduced base and say so in their
`INDEX.md`. The base is what makes profiles composable: an agent that knows the base can
read any namespace, and a profile only adds reach, never a new grammar.

## The eight profiles

- **Doctrine / Conceptual Canon** (Stable): durable concepts, principles, decisions, and
  reusable doctrine. Adds `pillars/`, `concepts/`, `decisions/`, and `archive/` when
  full-source preservation matters. This namespace, `ai-architecture`, is a Doctrine
  profile.
- **Tool Contract** (Provisional): tell an agent exactly how to call a tool or API
  correctly. Adds `operations/`, `concepts/`, `decisions/`, `references/`, `examples/`.
  Canon file of record is `canon/core-contract.md`.
- **Data System** (Provisional, highest near-term value): document data flow from source
  APIs through transforms, warehouse layers, metric definitions, and dashboards. Adds
  `architecture/`, `source-contracts/`, `pipelines/`, `transforms/`, `models/`,
  `metrics/`, `references/`. Uses the shared [[metric-primitive]].
- **Design System** (Provisional): approved visual and stylistic canon. Adds `pillars/`,
  `tokens/`, `assets/`, `examples/`, `references/`.
- **Component Library** (Provisional): approved reusable implementation patterns plus
  deployment and usage rules. Source code stays in its implementation repo; the namespace
  approves, constrains, and links. Adds `components/`, `patterns/`, `examples/`,
  `deployment/`, `references/`.
- **Content Strategy** (Provisional): themes, positions, angles, and how they connect to
  marketing, product, doctrine, and evidence. Adds `pillars/`, `concepts/`, `angles/`,
  `examples/`, `references/`. Cross-links heavily to `example-marketing`.
- **Operating Library** (Provisional): how to execute recurring work and how to diagnose
  problems. Adds `procedures/`, `diagnostics/`, `decision-trees/`, `examples/`,
  `references/`, and `metrics/` when tied to metric diagnosis via the [[metric-primitive]].
- **Intake Fabric** (Stable as a root layer): receive inbound items from many sources,
  preserve source context, track processing and routing, move high-signal items into
  durable homes. Lives at repo root under `intake/`, not under `knowledge/<namespace>/`.

## Stable vs Provisional

A maturity tag governs trust. **Stable** means at least one real namespace exists and the
schema is trusted in practice. **Provisional** means the schema was defined from analysis
and must be validated against the first real namespace of that type before it is trusted.
Six of the eight profiles are Provisional. Each Provisional profile carries an explicit
"validate on first real namespace" note and ships as a reference scaffold in
`knowledge/_examples/`, so the second and third reference implementations exist before
breadth is committed.

## Watch-items: do not pre-merge

Some profiles share DNA but stay distinct on purpose.

- Design System and Component Library both describe "approved reusable artifacts." Keep
  them separate: one governs visual and stylistic canon, the other governs implementation
  patterns and deployment.
- Tool Contract, Data System, and Operating Library all carry "executable contract plus
  diagnostics" DNA. Keep them separate: they answer different questions (how to call,
  where data flows, how to run and diagnose) even where they touch the same metric.

The rule is to revisit a merge only if two real namespaces prove the collapse, not to
pre-merge on a structural hunch. A deferred Image / Multimodal profile is handled inside
Design System for now and revisited when an image storage and embedding strategy exists.

## Edges

- `depends_on` the pillar [[profile-aware-knowledge-graph-design]]: profiles are the
  concrete expression of that design thesis.
- `explains` the decision [[namespace-profile-set-v1]] and the operative registry
  [[namespace-profiles]] under `_system`.
- `related_to` [[metric-primitive]]: the shared node Data System and Operating Library
  both consume.

## Notes

Profile is declared once, in the `_system/namespaces/<ns>.md` registry entry via
`profile:`, and surfaced in the namespace `INDEX.md`. An agent reads profile to know
which additive folders to expect; it never has to learn a new ontology per namespace.
