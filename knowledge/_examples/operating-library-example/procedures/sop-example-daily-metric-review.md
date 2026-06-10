---
id: "knowledge-operating-library-example-sop-example-daily-metric-review"
aliases: ["knowledge-operating-library-example-sop-example-daily-metric-review", "sop-example-daily-metric-review"]
type: "Knowledge"
namespace: "operating-library-example"
lifecycle_state: "research"
summary: "SOP for the daily metric review: check core metrics for anomalies, confirm data freshness, and escalate if a metric is outside its normal range."
confidence: 0.88
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[diag-example-order-count-drop]]"
    relation: "references"
    confidence: 0.9
  - target: "[[metric-example-order-count]]"
    relation: "references"
    confidence: 0.9
  - target: "[[knowledge-operating-library-example-canon-core-doctrine]]"
    relation: "grounded_in"
    confidence: 0.85
created: "2026-05-30"
---

## Trigger

Every weekday at 09:00 local time, after the overnight data pipeline is confirmed
complete. The pipeline confirmation signal is a green status on the data pipeline
dashboard (link to dashboard in your production namespace). Do not start this review
if the pipeline status is yellow or red; escalate to the data team immediately instead.

## Inputs

- Access to the metrics dashboard for the namespace this SOP covers.
- Familiarity with the normal range for each metric under review. Document the ranges
  in this file or in the relevant diagnostic nodes.
- A Slack channel or equivalent for posting the daily status summary.

## Steps

1. Open the metrics dashboard. Confirm the data freshness timestamp shows data from
   the previous calendar day (not older).
2. For each metric listed in the review set, check whether the current value is within
   its expected range. The review set for this example is: `metric-example-order-count`
   ([[metric-example-order-count]]).
3. If all metrics are within range, post a brief status summary to the designated Slack
   channel: date, all-green status, and the value for each metric reviewed.
4. If any metric is outside its expected range, do not continue the standard review.
   Load the diagnostic node for that metric and follow it. For `metric-example-order-count`,
   load [[diag-example-order-count-drop]].
5. After completing any diagnostic investigation, update the Slack status post with the
   finding and the action taken.

## Escalation

Escalate to the data team if:

- The pipeline status is not green at review start.
- A metric anomaly cannot be explained within 30 minutes of following the diagnostic.
- The diagnostic's next action requires a code change or schema fix.

Escalation target: the data team on-call (by role). Do not escalate to the same person
who runs the pipeline unless they are also the on-call.

## Completion check

The daily metric review is complete when:

- A status summary is posted to the Slack channel.
- Any anomaly found has a documented finding and a next action (either resolved or
  escalated with a ticket reference).
