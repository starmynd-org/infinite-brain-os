---
id: "department-example-studio-ops-charter"
aliases: ["department-example-studio-ops-charter"]
type: "Charter"
namespace: "emberline-studio"
lifecycle_state: "research"
summary: "Charter for the example studio-ops department: mission, north star, owned outcomes, signals, constraints, and cadence."
confidence: 0.85
retrieval_class: "identity"
export_class: "public"
edges:
  - target: "[[department-example-studio-ops-index]]"
    relation: "supports"
    confidence: 0.9
created: "2026-06-11"
---

# Charter: Example Studio Ops

The INDEX answers what this department contains; this charter answers what it
optimizes and how success is measured.

## Mission

Run Emberline Candle Studio's operations so the maker can spend her hours making.
The department handles inbound triage, listing copy, order visibility, and the
weekly review loop, and surfaces every real decision to a human.

## North Star

Every order shipped on time with honest materials and a voice customers trust.

## Owned Outcomes

- Collections launch on schedule, photographed before listing
- Orders are visible weekly by SKU, stockouts caught before they bite
- Every customer-facing word passes [[rule-studio-brand-voice]]

## Key Goals

- Launch the autumn collection per [[project-example-autumn-collection]]
- Keep the weekly review running every week without exception
- Reduce inbox items needing human routing to genuine decisions only

## KPIs / Metrics

Three measurable signals, all read from the order digest and the weekly review:

1. **On-time ship rate**: orders shipped within 2 business days, target 95 percent.
   Data posture: department Data node, [[data-orders-ledger]].
2. **Stockout days per collection**: days any SKU is dark, target under 3.
   Data posture: department Data node, [[data-orders-ledger]].
3. **Voice-rule pass rate**: new listings passing the brand-voice check on first
   review, target 90 percent. Data posture: provisional, `not-wired`, counted by
   hand in the weekly review.

## Targets and Review Posture

On-time ship rate is the safety metric: if it drops, everything else waits. Targets
are reviewed in the weekly studio review and reset per collection.

## Core Constraints

- Never spend money, set prices, or accept wholesale terms without a human decision
- Never publish a listing that has not passed the brand-voice rule
- Never store live order numbers in git; pointers only
- Conservative default: when unsure whether a decision is human-bound, surface it

## Related Entities

Namespace `emberline-studio`; head agent [[agent-studio-inbox-triage]]; doctrine
[[knowledge-emberline-studio-brand-essentials]] and
[[knowledge-emberline-studio-seasonal-collection]]; owned data
[[data-orders-ledger]]; produced outputs such as [[output-spring-collection-brief]];
execution surface listed in [[department-example-studio-ops-index]].

## Human Review / Escalation

The human owns final acceptance of pricing, new scents, wholesale terms, and listing
publish. The human tunes the reorder threshold and the review cadence. Inbox
classification and the weekly digest are fully AI-routed.

## Reporting Cadence

Daily studio note; weekly rollup through [[workflow-weekly-studio-review]]; a
per-collection retrospective at each season close.

## Open Gaps

- The voice-rule pass rate is hand-counted; no automated check exists yet.
- The daily note has no automation; it depends on session discipline.
