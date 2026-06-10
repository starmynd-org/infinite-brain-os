---
id: "rule-surfacing-policy"
aliases: ["rule-surfacing-policy", "surfacing-policy"]
type: "Rule"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "The policy that decides what reaches the operator versus what the org handles: each human-bound item routes to exactly one of auto-handle, surface-now, batch, or escalate-urgent, via a stakes-by-reversibility matrix gated by confidence and overridden by the external and canon-touching hard flags. Conservative by default; ships with learning OFF at L1."
confidence: 0.84
retrieval_class: "domain"
export_class: "internal"
description: "Apply this rule when deciding whether a human-bound item reaches the operator and how. Conservative by default: when no rule clearly says it is safe to auto-handle, batch it to the operator. At L1 learning is OFF and nothing auto-handles."
edges:
  - target: "[[rule-signal-vocabulary]]"
    relation: "depends_on"
    confidence: 0.9
  - target: "[[skill-triage-human-items]]"
    relation: "applied_by"
    confidence: 0.85
created: "2026-06-03"
---

# Rule: Surfacing Policy

For each human-bound item, route to exactly one of four actions. This is the membrane's attention gate
and the place the anti-capture guardrails live (``human-interaction-membrane``).

## The four actions

- **auto-handle**: the org decides and logs a receipt.
- **surface-now**: the operator should see it soon.
- **batch**: the operator should see it in the next daily review.
- **escalate-urgent**: high-stakes and time-critical, interrupt.

## The decision (stakes-by-reversibility, gated and flagged)

- auto-handle is allowed only when the item is low-stakes AND reversible AND high-confidence AND not
  external AND not canon-touching, AND a matching learned rule exists.
- anything `external` or `canon-touching` always surfaces, regardless of other signals.
- `confidence` below the operator-set threshold always surfaces.
- **conservative default**: if no rule clearly says the item is safe to auto-handle, it batches to the
  operator. The default action is to show the operator. Auto-handle is the earned exception, never the default.
- escalate-urgent requires high or critical stakes AND a deadline or decay.

## L1 posture (the initial build): learning OFF

At L1 nothing auto-handles. Every human-bound item routes to `batch` or, when high-stakes and
time-critical, `escalate-urgent`. The learned-rules registry and shadow-mode learning are downstream and
deliberately not enabled here, so there is no capture risk while the operator model is still a skeleton.

## Safety governor

The mis-surface rate (items auto-handled that the operator later flags should have been surfaced) is the safety
metric. When it rises, surfacing rules get more conservative immediately. The auto-handle rate may rise
over time, but never at the cost of the mis-surface rate. The raw unfiltered queue stays accessible to
the operator at any time, and everything auto-handled is reviewable on demand.

## Boundary

Reads the signal vocabulary; does not redefine it. Operator tunes the stakes-by-reversibility cutoffs and
the confidence threshold (operator-tuning-decisions 2 and 3). Rules are reviewed weekly.
