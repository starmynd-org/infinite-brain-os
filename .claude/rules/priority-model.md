---
id: "rule-priority-model"
aliases: ["rule-priority-model", "priority-model"]
type: "Rule"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "The deterministic, explainable prioritization policy every department head uses to order its backlog: a weighted score over the signal vocabulary plus hard rules (deadline jumps, blocked never dispatched, dependency roots first), anti-starvation aging, and deterministic tie-breaks. Weights are operator-tunable."
confidence: 0.83
retrieval_class: "domain"
export_class: "internal"
description: "Apply this rule when ordering a backlog or choosing what to work on next. It produces an explainable ordering from the signal vocabulary; the head applies it, the operator tunes the weights."
edges:
  - target: "[[rule-signal-vocabulary]]"
    relation: "depends_on"
    confidence: 0.9
  - target: "[[skill-prioritize-backlog]]"
    relation: "applied_by"
    confidence: 0.85
created: "2026-06-03"
---

# Rule: Priority Model

The ordering policy. Deterministic and explainable: a weighted score over the signal vocabulary
(`[[rule-signal-vocabulary]]`) with hard rules on top. The head applies it; the operator tunes the
weights (operator-tuning-decision 1). Judgment lives in one reviewable rule, not a thousand improvised
calls.

## The score

```
score = w_u * urgency + w_d * dependency_unblocking + w_c * charter_alignment + w_s * stakes - w_e * effort
```

Weights `w_*` are operator-set and default to equal until tuned (see
`knowledge/personal-operator/decisions/operator-tuning-decisions.md`). The score orders items within a
backlog; it does not decide human surfacing (that is `[[rule-surfacing-policy]]`).

## Hard rules (layered on top of the score)

- an imminent deadline jumps the queue regardless of score
- a blocked item is never dispatched (it waits on its blocker)
- dependency roots run before their dependents
- anti-starvation: an aging term lifts old items over time so nothing rots in the queue forever
- ties break deterministically by age (oldest first) for reproducible ordering

## Explainability

The head can always state the choice in one line: "next is X because urgency is high and it unblocks
four others." If it cannot explain the order from the signals and these rules, the order is wrong.

## Boundary

This rule orders work and gates no human attention, so it is the lower-risk early ship. It reads the
signal vocabulary; it does not redefine it. Weights are reviewed on the operator's cadence.
