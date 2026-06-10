---
id: "knowledge-data-system-example-metric-example-order-count"
aliases: ["knowledge-data-system-example-metric-example-order-count", "metric-example-order-count"]
type: "Metric"
namespace: "data-system-example"
lifecycle_state: "research"
summary: "Count of distinct confirmed orders in a given reporting window. Example Metric node showing the metric primitive in full."
confidence: 0.9
retrieval_class: "domain"
export_class: "internal"
metric_id: "metric-example-order-count"
format: "count"
polarity: "higher-better"
aggregation: "sum"
expression: "COUNT(DISTINCT order_id) WHERE order_status = 'confirmed'"
depends_on: []
instrumentation_status: "live"
implementation_path: "example-co-cli"
implementation_owner: "example-co-managed"
edges:
  - target: "[[source-contract-example-orders-api]]"
    relation: "derived_from"
    confidence: 0.9
  - target: "[[metric-primitive-schema]]"
    relation: "implements"
    confidence: 0.95
  - target: "[[knowledge-data-system-example-canon-core-doctrine]]"
    relation: "grounded_in"
    confidence: 0.85
created: "2026-05-30"
---

**Order count** is the number of distinct confirmed orders placed in a reporting window.
It is the most basic demand signal in an orders data system. It counts an order once
regardless of the number of line items.

## Definition

- Unit: one order (not one line item, not one shipment).
- Filter: `order_status = 'confirmed'` at the time of aggregation. Cancelled or pending
  orders are excluded.
- Window: defined by the reporting context. Daily, weekly, and monthly windows are
  common. The metric does not carry a fixed window; the query or dashboard specifies it.
- Deduplication: `COUNT(DISTINCT order_id)`. Duplicate rows from the pipeline do not
  inflate the count.

## Source

The raw `order_id` and `order_status` fields come from the Orders API source contract
([[source-contract-example-orders-api]]). The pipeline lands them in the raw orders
table. The transform filters and normalizes status values. The warehouse model exposes
the clean `order_id` and `order_status` columns this metric counts.

## Lineage summary

Orders API raw feed
  pipeline lands records in `raw.orders`
  transform normalizes status to canonical enum
  model `mart.orders_confirmed` deduplicates and filters
  this metric counts `DISTINCT order_id` from `mart.orders_confirmed`

## Using this metric_id across namespaces

Any Operating Library namespace that diagnoses anomalies in order count references this
node by its `metric_id: "metric-example-order-count"`. The diagnosis node does not
redefine the metric; it describes what moves the number, what failure modes to check,
and what action to take.

## Starter implementation posture

This example metric is marked `live` through `implementation_path: "example-co-cli"`, which
means the semantic contract lives in the repo while the managed implementation resolves the
actual data. A non-Example Co client could keep the same `metric_id` and switch the
implementation path to `byo-adapter` without changing the metric's meaning.

## Known limitations

- Does not account for order amendments after confirmation. An amended order retains its
  original `order_id` and is still counted once.
- Requires that `order_status` normalization in the transform is complete before the
  model is queried.
