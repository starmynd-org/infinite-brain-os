---
id: "knowledge-operating-library-example-diag-example-order-count-drop"
aliases: ["knowledge-operating-library-example-diag-example-order-count-drop", "diag-example-order-count-drop"]
type: "Knowledge"
namespace: "operating-library-example"
lifecycle_state: "research"
summary: "Diagnostic guide for a drop in order count (metric-example-order-count). Covers failure modes, what to check first, and next actions."
confidence: 0.87
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[metric-example-order-count]]"
    relation: "references"
    confidence: 0.95
  - target: "[[sop-example-daily-metric-review]]"
    relation: "references"
    confidence: 0.8
  - target: "[[knowledge-operating-library-example-canon-core-doctrine]]"
    relation: "grounded_in"
    confidence: 0.85
created: "2026-05-30"
---

This diagnostic covers an unexpected drop in `metric_id: metric-example-order-count`
([[metric-example-order-count]]). The metric is defined in the data-system-example
namespace. This node does not redefine it; it documents what to investigate when the
count falls below its expected range.

## What moves this metric

- **Platform demand**: fewer orders are placed by customers. This is a real business
  signal, not a data problem.
- **Pipeline failure**: the overnight pipeline did not run or did not complete, so
  yesterday's orders are not in the warehouse.
- **Transform failure**: the status normalization transform ran with an error, causing
  confirmed orders to be miscategorized.
- **Source API change**: the upstream API changed the `order_status` enum values,
  and the transform no longer maps them correctly.
- **Data freshness lag**: the pipeline ran but is delayed; the model reflects data from
  two days ago, not yesterday.

## Failure modes and checks

**Failure mode 1: pipeline did not run**
Check: open the pipeline monitoring dashboard and confirm the last successful run
timestamp. If it is older than 25 hours, the pipeline failed.
Next action: alert the data team on-call with the pipeline name and the last run
timestamp.

**Failure mode 2: status normalization dropped confirmed orders**
Check: query the raw orders table for `order_status LIKE '%CONFIRM%'` and compare the
raw count to the model count for the same date. If raw count is significantly higher
than model count, the transform is filtering too aggressively.
Next action: check the transform node ([[transforms/README]]) for recent changes to the
status enum mapping. Escalate to the data engineer who owns the transform.

**Failure mode 3: upstream API changed the status enum**
Check: load the source contract ([[source-contract-example-orders-api]]) and confirm
the raw status values in the `Status values` table match what is currently in the raw
orders table. A new value not in the mapping table will produce zero confirmed orders
for orders with that status.
Next action: update the source contract node with the new status value, update the
transform enum mapping, and rerun the transform for the affected date range.

**Failure mode 4: data freshness lag**
Check: confirm the data freshness timestamp in the metrics dashboard. If it shows
two days ago, the model has not been refreshed.
Next action: check whether the pipeline succeeded but the model refresh job failed.
Trigger a manual model refresh if appropriate, or escalate if the refresh job is in
an error state.

## What to check first

1. Check the pipeline run timestamp. This is the fastest check and rules out the most
   common cause.
2. Check the data freshness timestamp in the metrics dashboard.
3. Compare raw order count to model order count for the same date.

Do these three checks before investigating the source contract or the transform. Most
drops are explained by steps 1 or 2.

## Escalation

Escalate to the data team on-call if:

- The pipeline has not run in more than 48 hours.
- The raw-to-model count discrepancy is larger than 5% and has no obvious transform
  explanation.
- The source API has changed its enum values (this requires a code change).

After escalation, link the escalation ticket or message reference in the daily status
post per [[sop-example-daily-metric-review]].
