---
id: "knowledge-ai-architecture-metric-primitive"
aliases: ["knowledge-ai-architecture-metric-primitive", "ai-architecture-metric-primitive"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "A metric is one shared typed node keyed by metric_id with three faces: semantic definition, lineage into Data System, and diagnosis in Operating Library."
confidence: 0.9
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[metric-primitive-schema]]"
    relation: "explains"
    confidence: 0.9
  - target: "[[namespace-profiles]]"
    relation: "related_to"
    confidence: 0.85
created: "2026-05-30"
---

## Summary

A metric is one shared typed node, not three private definitions scattered across
namespaces. It is keyed by `metric_id`, defined once, and cross-linked. This node is the
"why" behind the metric primitive. The operative schema, the exact frontmatter a builder
writes, lives in [[metric-primitive-schema]] under `_system`.

## The problem the primitive solves

Without a shared primitive, a single metric like ROAS gets defined three times: once in
a data pipeline as a column, once in a dashboard as a formula, and once in an operating
playbook as a thing to watch. The three drift. An agent asked to trace a number cannot
tell which definition is authoritative, and a change to the calculation does not
propagate to the diagnosis. The metric primitive collapses this into one node that every
namespace references by `metric_id`, so there is exactly one place the metric is defined
and exactly one identity it carries across the graph.

## The three faces

A metric node presents three faces from a single definition.

- **Definition (semantic)**: what the metric means in plain terms. Owned in a Data
  System or Operating Library namespace. This is the face every other reference points
  back to.
- **Lineage (into Data System)**: source, transform, model, and refresh. The Data System
  namespace owns lineage and edges the metric node to its source-contract, pipeline,
  transform, and model nodes.
- **Diagnosis (Operating Library)**: what moves the metric, its failure modes, and the
  next action when it goes wrong. The Operating Library namespace owns diagnosis and
  edges the metric node to its diagnostics and decision-trees.

The Data System owns lineage, the Operating Library owns diagnosis, and both reference
the same `metric_id`. Neither re-defines the metric; they attach their face to the one
node.

## Frontmatter additions

A metric node carries the standard node frontmatter plus these typed fields, specified
in full in [[metric-primitive-schema]]:

- `type: "Metric"`
- `metric_id`: the stable id that every reference uses to point at this metric.
- `format`: one of `percent`, `currency`, `ratio`, `count`, `duration`.
- `polarity`: one of `higher-better`, `lower-better`, `neutral`.
- `aggregation`: one of `sum`, `avg`, `last`, `ratio-of-sums`, `custom`.
- `expression`: the plain or SQL-ish definition of how the metric is computed.
- `depends_on`: the `metric_id` values this metric is derived from, so composite metrics
  trace to their components.

The node also edges to its Data System lineage nodes and its Operating Library diagnosis
nodes, which is how the three faces stay connected without duplication.

## Defined once, cross-linked

The discipline is one definition, many references. A dashboard node, a pipeline node, and
a playbook node all link to the same metric by `metric_id`; they do not restate the
formula. When the calculation changes, the operator edits one node and every face updates
in place. This is the metric-level expression of the single-source-of-truth rule that
governs the whole architecture: `_system` and the owning namespace hold the definition,
and consumers reference it.

This also makes the starter-repo posture possible. A free or lightweight repo can ship the
metric semantics before it ships a full warehouse. The metric node may say that the number is
currently live through your data-platform CLI, manually maintained in a sheet, or not yet wired. The
semantics stay stable while the implementation path changes.

## Edges

- `explains` the operative schema [[metric-primitive-schema]] under `_system`: this node
  is the reasoning, that file is the field contract.
- `related_to` [[namespace-profiles]]: the metric primitive is the bridge that the Data
  System and Operating Library profiles share.

## Notes

Two profiles touch metrics: Data System for lineage and Operating Library for diagnosis.
A Content Strategy or Doctrine namespace that mentions a number should link to the metric
node rather than copy its definition. The test for a metric node is a stable `metric_id`
that two or more namespaces need to agree on; a one-off figure in a single document does
not need to become a primitive.
