---
id: "intake-slack-2026-05-20-attribution-article"
aliases: ["intake-slack-2026-05-20-attribution-article", "intake-stub-example"]
type: "intake-record"
namespace: "personal-operator"
source: "slack"
creator: "a colleague in #analytics-team"
original_ref: "slack:C0ANALYTICS/p1747739700000100 (example message id)"
received_at: "2026-05-20T11:15:00Z"
raw_capture: "inline (short captures may quote the raw content in the body instead of pointing to a file)"
summary: "Paper claiming last-click attribution overestimates search and underestimates display by 2-3x in most DTC contexts."
why_it_matters: "If the claim holds it contradicts the current attribution assumptions before the next Acme model review; cheap to read, possibly load-bearing."
lifecycle_state: "scratch"
confidence: 0.9
retrieval_class: "ephemeral"
export_class: "internal"
created: "2026-05-20"
---

# Intake: Article on Multi-Touch Attribution Accuracy

A worked manual (Tier 1) capture: one Slack message, recorded to the intake-record schema
at `schemas/intake-record.md`. Use it as the copy-from shape for hand-captured items.

## Source

- **From:** a colleague, shared in `#analytics-team`
- **Received:** 2026-05-20 at 11:15 UTC
- **Original:** the Slack message id in `original_ref` above

## Raw content

> "Interesting paper dropped this week on why last-click attribution overestimates
> search and underestimates display by a factor of 2-3x in most DTC contexts.
> Worth reading before we update the Acme model."
>
> Link: https://example.com/attribution-study-2026 (placeholder for this example)

## Extracted summary

The linked paper argues last-click attribution systematically misallocates credit between
search and display in DTC contexts. Relevant to any attribution methodology this
deployment maintains.

## What happens next (the worked triage)

This record is the capture receipt only. Routing and processing are separate records, and
the record itself never carries live queue status:

1. Read the linked article far enough to classify it.
2. Write a routing decision to the shape in `schemas/routing-decision.md`. This item is a
   genuinely ambiguous capture, the kind that lands below a routing threshold and goes to
   human review: it is either a knowledge candidate (an attribution-methodology concept
   node under `knowledge/personal-operator/concepts/`) or a task (read before the next
   model review, tracked the way `projects/_example/PLAN.md` tracks tasks).
3. Do the work, then write a processed receipt to the shape in
   `schemas/processed-receipt.md`, linking back to this record.
4. This record stays in git after routing so the capture trail is auditable; replace this
   example only once you have real captures of your own.
