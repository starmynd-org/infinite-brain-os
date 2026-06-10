---
id: "knowledge-ai-architecture-canon-entity-metrics"
aliases: ["knowledge-ai-architecture-canon-entity-metrics", "ai-architecture-entity-metrics", "entity-metrics"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Canon for the Metric primitive: one shared typed node keyed by metric_id with three faces, semantic definition, lineage into Data System, and diagnosis in Operating Library, defined once and cross-linked so a number stays coherent across namespaces."
confidence: 0.9
retrieval_class: "domain"
export_class: "internal"
verified_at: "2026-05-31"
verified_by: "operator-pending"
edges:
  - target: "[[system-overview]]"
    relation: "part_of"
    confidence: 0.9
  - target: "[[core-doctrine]]"
    relation: "derived_from"
    confidence: 0.88
  - target: "[[metric-primitive]]"
    relation: "derived_from"
    confidence: 0.92
  - target: "[[data-nodes]]"
    relation: "related_to"
    confidence: 0.82
created: "2026-05-31"
---

## What it is

A **Metric** is the metric primitive: one shared typed node, not three private definitions
scattered across namespaces. It is keyed by `metric_id`, defined once, and cross-linked. A
metric presents three faces from a single definition: the semantic definition (what it
means), the lineage into the Data System namespace (source, transform, model, refresh), and
the diagnosis in the Operating Library namespace (what moves it, failure modes, next
actions). The Data System owns lineage, the Operating Library owns diagnosis, and both
reference the same `metric_id`. The full reasoning is in [[metric-primitive]].

## When to use it (and when not)

Create a metric when a number must agree across two or more namespaces, so that one
definition is authoritative and a calculation change propagates everywhere. Do not create a
metric for a one-off figure in a single document; a plain [[knowledge-nodes|knowledge node]]
or a [[data-nodes|data node]] pointer is enough. Do not redefine the same metric in two
namespaces; reference the shared `metric_id`.

## Required shape

- **Folder**: usually `metrics/` in a Data System or Operating Library namespace.
- **Frontmatter**: standard node fields plus `type: "Metric"`, `metric_id: <stable-id>`
  (id form `metric-<slug>`), `format` (`percent`, `currency`, `ratio`, `count`, or
  `duration`), `polarity` (`higher-better`, `lower-better`, or `neutral`), `aggregation`
  (`sum`, `avg`, `last`, `ratio-of-sums`, or `custom`), `expression` (the plain or SQL-ish
  definition), and `depends_on` (the `metric_id` values it derives from). Starter or
  mixed-maturity systems should also consider the optional posture fields
  `instrumentation_status`, `implementation_path`, and `implementation_owner`.
- **Edges**: to its Data System lineage nodes and its Operating Library diagnosis nodes, so
  the three faces stay connected without duplication.

## How it relates to the other entity types

A metric is a typed [[knowledge-nodes|knowledge node]] that the Data System and Operating
Library profiles both consume. [[data-nodes]] point at the live source the metric is
computed from; dashboards, pipelines, and playbooks reference the metric by `metric_id`
rather than restating the formula. A metric never holds live values; it holds the
definition and lineage. It is the bridge that keeps a data namespace and an operating
namespace talking about the same number.

In a starter repo, the metric layer should exist even when the live implementation is thin.
That is the point of the primitive: one semantic definition can later resolve through
your data-platform CLI, a client-owned adapter, or a manual sheet without changing the metric's
identity.

## Governing rules and doctrine

The metric primitive reasoning is in [[metric-primitive]]; the operative field contract is
`_system/metric-primitive-schema.md`, which a builder follows and `validate.sh` supports.
The single-source-of-truth discipline (one definition, many references) is the metric-level
expression of the control model in [[core-doctrine]]. See [[system-overview]] for how
metrics sit in the entity set.
