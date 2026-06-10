---
id: "rule-operator-human-queue-contract"
aliases: ["rule-operator-human-queue-contract", "operator-human-queue-contract", "human-queue-contract"]
type: "Rule"
namespace: "personal-operator"
lifecycle_state: "research"
summary: "The chief-of-staff human-queue contract on the brain plus Paperclip. Defines the durable shape of a human-bound item, the append-only and only-the-membrane-moves-state discipline, the producers-route-never-wait rule, the completed-log decision capture, and the VERIFY-HUMAN vs VERIFY-AI escalation taxonomy. Live queue state lives in Paperclip; git holds the contract and the audit trail."
confidence: 0.83
retrieval_class: "domain"
export_class: "internal"
description: "Apply this rule for any human-bound item in the chief-of-staff queue. It is the durable item shape and the membrane discipline; live state lives in Paperclip, the durable record is this contract plus the git audit trail of decisions."
edges:
  - target: "[[rule-surfacing-policy]]"
    relation: "depends_on"
    confidence: 0.88
  - target: "[[rule-result-and-escalation-contract]]"
    relation: "depends_on"
    confidence: 0.85
  - target: "[[decision-ai-architecture-paperclip-boundary]]"
    relation: "bounded_by"
    confidence: 0.82
created: "2026-06-03"
---

# Rule: Operator Human-Queue Contract

The membrane side of the queue. The chief-of-staff membrane owns it: this contract is the canonical
definition of how human-bound items reach the operator on the brain plus Paperclip.

## The item shape

Each human-bound item carries: `item_id`, `summary`, `source` (the originating head or the fleet
coordinator plus task or sprint), `item_class` (review, approval, blocker, assumption, fyi), the nine
signals from `[[rule-signal-vocabulary]]`, `priority` (P0, P1, P2; derived from
`[[rule-priority-model]]`, not hand-set), `blocking`, `recommended_option` plus counterargument,
`prepared_context_link`, `status` (queued, in-progress, waiting-external, done), `disposition` (the
surfacing action taken), `decision`, `promotion_event`, `added`, optional `eta`.

## Discipline

- **Append-only; only the membrane moves state.** Producers append items. Only the chief-of-staff
  membrane or the operator changes `status`, `disposition`, or `decision`. A producing head never sets
  another's status.
- **Producers route, never execute or wait.** A head that discovers human-bound work routes it into the
  queue and continues independent work; it does not block waiting for the operator, and it does not
  perform the human task itself.
- **The completed-log captures the decision and routes it back.** When the operator decides, the
  decision and the `promotion_event` it produced are recorded, and the decision propagates back to the
  originating head as a visible promotion event.
- **Conservative default and anti-capture.** When unsure whether the operator needs an item, surface
  it. The raw unfiltered queue stays accessible to the operator at any time; everything auto-handled
  (later) is reviewable on demand. The mis-surface rate is the safety metric.

## Escalation taxonomy

- `verify-ai`: testable by automated browser or CLI checks. The org handles these; they do not enter the
  human queue.
- `verify-human`: needs human judgment (does this look right, is this data correct, real OAuth flows,
  copy and tone). Every unresolved `verify-human` item becomes a queue item with class review or
  approval.

## Where state lives (surface boundary)

- live queue state (pending items, ordering, in-flight approvals): the Paperclip runtime. An item
  awaiting the operator maps to a Paperclip issue in `in_review` with a typed `approvals` record decided
  by a human.
- the durable record: this contract plus the audit trail of decisions, written back to git as promotion
  events. Git never holds a mutable live-queue file.

## Routing actions and L1 posture

Items route via `[[rule-surfacing-policy]]` and `[[skill-triage-human-items]]`. At L1, learning is OFF:
everything batches to the operator or escalates-urgent; nothing auto-handles.
