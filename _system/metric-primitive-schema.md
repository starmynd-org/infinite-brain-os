# Metric Primitive Schema (Operative)

This file is the operative schema for a metric node: the exact frontmatter a builder
writes and the rules the linter checks. The "why" the primitive exists, the problem of a
metric defined three times that drifts, lives in [[metric-primitive]] under
`knowledge/ai-architecture/concepts/`. This file carries no node frontmatter (it lives
under `_system/`).

A metric is one shared typed node, not three private definitions scattered across
namespaces. It is keyed by `metric_id`, defined once, and cross-linked. A change to the
calculation is made in one place and every reference updates because every reference
points back by `metric_id`.

## Metric node frontmatter

A metric node carries the standard knowledge-node frontmatter (`id`, `namespace`,
`lifecycle_state`, `summary`, `confidence`, `retrieval_class`, `export_class`, `created`,
`edges`) with `type: "Metric"` PLUS these typed metric fields:

```yaml
---
id: "metric-<slug>"
aliases: ["metric-<slug>", "<short>"]
type: "Metric"
namespace: "<data-system-or-operating-library-namespace>"
lifecycle_state: "research"
summary: "one-line: what the metric means"
confidence: 0.9
retrieval_class: "domain"
export_class: "internal"
metric_id: "<stable-id>"
format: "currency"
polarity: "higher-better"
aggregation: "ratio-of-sums"
expression: "sum(revenue) / sum(ad_spend)"
depends_on: ["<metric_id>", "<metric_id>"]
instrumentation_status: "live"
implementation_path: "example-co-cli"
implementation_owner: "example-co-managed"
edges:
  - target: "[[<source-contract-node>]]"
    relation: "derived_from"
    confidence: 0.9
created: "2026-05-30"
---
```

Field rules:

- `type`: always the literal `"Metric"`.
- `metric_id`: the stable id every reference uses to point at this metric. Kebab-case.
  Distinct from the file `id`, which carries the `metric-` type prefix; in practice
  `metric_id` is the `id` without the prefix. This is the join key across namespaces.
- `format`: one of `percent | currency | ratio | count | duration`.
- `polarity`: one of `higher-better | lower-better | neutral`.
- `aggregation`: one of `sum | avg | last | ratio-of-sums | custom`.
- `expression`: the plain-language or SQL-ish definition of how the metric is computed.
  Required and non-empty for any metric above `lifecycle_state: scratch`.
- `depends_on`: the list of `metric_id` values this metric is derived from, so composite
  metrics trace to their components. Empty list for a base metric.
- `instrumentation_status`: optional but recommended in starter or mixed-maturity systems.
  One of `live | manual | not-wired`. Use it to say whether the metric is actually hydrated,
  manually maintained, or only semantically defined.
- `implementation_path`: optional but recommended when the semantic layer can resolve
  through more than one substrate. Typical values: `example-co-cli`, `byo-adapter`,
  `manual-sheet`.
- `implementation_owner`: optional short owner tag for who is expected to make the metric
  real. Typical values: `example-co-managed`, `client-managed`, `shared-platform`.

## The three faces and which namespace owns each

A metric presents three faces from a single definition. Each face is owned by exactly one
namespace; no face re-defines the metric.

- **Definition (semantic)**: what the metric means in plain terms. This is the face every
  other reference points back to. Owned in the Data System or Operating Library namespace
  that holds the metric node itself.
- **Lineage (into Data System)**: source, transform, model, refresh. Owned by the Data
  System namespace. It edges the metric node to its `source-contracts/`, `pipelines/`,
  `transforms/`, and `models/` nodes.
- **Diagnosis (Operating Library)**: what moves the metric, its failure modes, and the
  next action when it goes wrong. Owned by the Operating Library namespace. It edges the
  metric node to its `diagnostics/` and `decision-trees/` nodes.

Ownership rule: the Data System namespace owns lineage, the Operating Library namespace
owns diagnosis, both reference the same `metric_id`. Neither re-defines the metric; each
attaches its face to the one node by edge.

## Cross-link rules

- A metric is defined once and cross-linked. A dashboard node, a pipeline node, and a
  playbook node all link to the same metric by `metric_id` or by `[[metric-<slug>]]`
  wikilink; they do not restate the formula.
- In a starter repo, the metric node is still worth defining even before full automation
  exists. The semantic layer lands first, and the optional fields above state whether the
  number is live through your data-platform CLI, mapped by a client-owned adapter, manually
  maintained, or not yet wired.
- A Content Strategy, Doctrine, or any other namespace that mentions a number links to the
  metric node rather than copying its definition. A literal number copied into prose is
  not a metric reference and will drift.
- Cross-namespace edges to a metric follow [[cross-namespace-edge-rules]]: the edge
  resolves to the single metric node, not to a per-namespace copy.
- The test for whether a figure should become a metric node: a stable `metric_id` that two
  or more namespaces need to agree on. A one-off figure in a single document does not need
  to become a primitive.

## What the validator checks vs what a curator checks

- `validate.sh` (deterministic): a node with `type: "Metric"` carries `metric_id`,
  `format`, `polarity`, `aggregation`, and a non-empty `expression`; `format`, `polarity`,
  and `aggregation` hold values from their enums; `depends_on` and edge `[[wikilink]]`
  targets resolve; the em-and-en-dash ban holds. Profile lint adds: in a Data System
  namespace, a metric node has at least one lineage edge; in an Operating Library
  namespace, a referenced metric has a diagnosis node. See [[profile-lint-rules]].
- A curator agent (fuzzy): confirms the `expression` is semantically correct, that two
  namespaces referencing the same number actually share one `metric_id` rather than two
  near-duplicates, and that a copied literal number should be converted into a metric
  reference. This judgment cannot be made deterministically.
