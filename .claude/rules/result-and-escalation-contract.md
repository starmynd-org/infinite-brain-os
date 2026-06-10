---
id: "rule-result-and-escalation-contract"
aliases: ["rule-result-and-escalation-contract", "result-and-escalation-contract"]
type: "Rule"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "The structured result every department head and the fleet coordinator emit when finishing a unit of work or hitting a decision point. Escalation is the only path to the human and it goes through the chief-of-staff membrane, never around it. Implemented on Paperclip primitives."
confidence: 0.84
retrieval_class: "domain"
export_class: "internal"
description: "Apply this rule whenever a head completes work or reaches a decision point. Emit a structured result with an explicit disposition: done via the accepted path, or escalate through the membrane. Never message the operator directly; never silently finish."
edges:
  - target: "[[rule-signal-vocabulary]]"
    relation: "depends_on"
    confidence: 0.88
  - target: "[[rule-surfacing-policy]]"
    relation: "feeds"
    confidence: 0.85
created: "2026-06-03"
---

# Rule: Result and Escalation Contract

The producer side of the membrane. When a head finishes work, it does not message the operator directly
and it does not silently finish: it emits a structured result with an explicit disposition. Escalation
is the only path to the human, through the chief-of-staff membrane.

## The result envelope

Every emitted result carries: `result_id`, `producer` (head or the fleet coordinator plus the
originating task or sprint), `work_product` (artifact or link), `outcome` (success, denied, escalated,
halted, no_op), the nine signals from `[[rule-signal-vocabulary]]`, an `escalation` block when it
escalates (item_class, recommended_option, counterargument, prepared context link), and a `receipt_ref`.

## The conservative escalation policy

A head decides done-vs-escalate by the same hard rules the surfacing policy uses:

- always escalate if the result is `external` or `canon-touching`, regardless of other signals
- always escalate if `confidence` is low
- escalate if stakes are high or critical, or reversibility is costly or irreversible, unless a matching
  pre-approval or learned rule clearly applies
- escalate as `blocked` if the head cannot proceed; as `assumption` if it made a consequential
  assumption needing sign-off
- conservative default: if no rule clearly says the work product is safe to complete without the
  operator, escalate it (the membrane then batches or surfaces it). At L1, everything that touches the
  human escalates and batches; nothing auto-completes.

## Paperclip mapping

A completed work product ready for acceptance maps to a Paperclip issue set to `in_review` with the work
product attached. Human acceptance is a typed `approvals` record linked via `issue_approvals`, decided by
a human (`decidedByUserId`), before the issue moves to `done`. No head or agent self-approves canon or its
own work product. Every consequential action writes an append-only receipt to
`departments/<slug>/receipts/`.

## Relationship

This rule is the producer side; `[[rule-surfacing-policy]]` and the operator human-queue contract are the
membrane side that aggregates and routes the escalations. All read `[[rule-signal-vocabulary]]`.
