---
id: "knowledge-data-system-example-canon-core-doctrine"
aliases: ["knowledge-data-system-example-canon-core-doctrine", "data-system-example-core-doctrine"]
type: "Knowledge"
namespace: "data-system-example"
lifecycle_state: "research"
summary: "Compressed first-principles synthesis for a Data System namespace: layers, metric primitive, starter implementation posture, and source-of-truth rules."
confidence: 0.85
retrieval_class: "identity"
export_class: "internal"
verified_at: "2026-05-30"
verified_by: "scaffold-build-agent"
edges:
  - target: "[[metric-example-order-count]]"
    relation: "derived_from"
    confidence: 0.9
  - target: "[[source-contract-example-orders-api]]"
    relation: "derived_from"
    confidence: 0.9
  - target: "[[metric-primitive-schema]]"
    relation: "implements"
    confidence: 0.95
  - target: "[[namespace-profiles]]"
    relation: "implements"
    confidence: 0.9
created: "2026-05-30"
---

A Data System namespace documents a single data flow: from one or more source APIs,
through raw extraction, transform logic, warehouse models, and into metric definitions
that agents and dashboards consume. The namespace is the authoritative description of
that flow. The live data itself stays in the warehouse; the namespace holds the reasoning
and the contracts.

In a starter repo, that authority begins at the semantic layer even if the bespoke data
engineering does not yet exist. The metric definitions, source contracts, and implementation
posture still belong here.

## The five-layer model

Every data system this namespace describes has five layers, each with a distinct job:

1. **Source contract**: what the external API or upstream system provides, at the field
   level, with type, nullability, and the operator's interpretation. Changes here
   cascade downstream.
2. **Pipeline**: how raw records arrive (schedule, trigger, credentials reference,
   destination table). Does not hold transform logic.
3. **Transform**: the business logic that reshapes or enriches raw records. SQL or
   equivalent. Each transform maps to exactly one model or intermediate state.
4. **Model**: the warehouse table or view that consumers query. Carries schema, refresh
   cadence, and the transform it depends on.
5. **Metric**: a named, typed, and stable business quantity. Carries the metric primitive
   (see below). The metric is what a human or agent asks for by name; it sits above model
   and depends on one or more models.

Agents navigating a data question should load in this order: metric, then model, then
transform, then source contract. This is the lineage direction: follow `depends_on` edges
upstream to find the root cause of any anomaly.

## The metric primitive

Every metric node in this namespace uses the shared metric primitive defined in
[[metric-primitive-schema]]. The key rule: define a metric once, reference it everywhere.
The Data System namespace owns the definition and the lineage. The Operating Library
namespace that diagnoses this metric references the same `metric_id`. Neither namespace
duplicates the definition.

Required metric fields: `type: "Metric"`, `metric_id`, `format`, `polarity`,
`aggregation`, `expression`, `depends_on`. Optional: `derived_from` edges to the model
node, plus starter-posture fields such as `instrumentation_status`, `implementation_path`,
and `implementation_owner`.

## Starter implementation posture

A starter Data System should be thin, not absent. The minimum useful starter shape is:

1. canonical metrics with stable `metric_id`
2. source contracts that say what the metric expects to read from
3. playbooks that say how the metric becomes live
4. explicit implementation posture per metric: `live`, `manual`, or `not-wired`

The default implementation path may be a managed substrate such as your data-platform CLI. A
non-Example Co user may map their own data into the same contracts instead. What the starter
must not do is redefine the metric semantics for each implementation path.

## Source of truth rules

- The source contract is the authoritative record of what the upstream system provides.
  If the API documentation and the contract disagree, the contract wins until the operator
  resolves the discrepancy.
- The model schema is the authoritative record of what warehouse consumers see. If a
  transform changes the shape of a model, the model node must be updated in the same
  commit.
- The metric definition is the authoritative statement of business meaning. If two teams
  calculate the same concept differently, that is a dispute tracked in `synthesis/`, not
  two valid metric nodes with the same name.

## What belongs in this namespace and what does not

Belongs here: source contracts, pipeline cadences, transform logic references, model
schemas, metric definitions, lineage edges, and the reasoning behind design decisions.
In starter form, it also belongs here to say whether the metric is hydrated by Example Co,
by a client-managed adapter, or not yet wired.

Does not belong here: live data, refresh logs, pipeline execution status, alert
thresholds (those are operational state in the app layer), or dashboard layout.

## Changelog

- 2026-05-30: Initial scaffold version authored by sprint build agent.
