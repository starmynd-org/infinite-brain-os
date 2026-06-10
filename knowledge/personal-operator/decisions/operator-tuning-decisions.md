---
id: "knowledge-personal-operator-operator-tuning-decisions"
aliases: ["knowledge-personal-operator-operator-tuning-decisions", "operator-tuning-decisions"]
type: "Knowledge"
namespace: "personal-operator"
lifecycle_state: "research"
summary: "The five operator-set values that tune the priority model and the surfacing policy: prioritization weights, the stakes-by-reversibility auto-handle cutoffs, the shadow-mode match threshold N, who may create or edit surfacing rules, and the daily-review cadence. The structure is fixed; every value is operator-input-required and holds its safe default until the operator sets it."
confidence: 0.4
retrieval_class: "identity"
export_class: "internal"
edges:
  - target: "[[personal-operator-core-doctrine]]"
    relation: "part_of"
    confidence: 0.85
  - target: "[[knowledge-personal-operator-operator-profile]]"
    relation: "depends_on"
    confidence: 0.85
  - target: "[[rule-priority-model]]"
    relation: "tunes"
    confidence: 0.85
  - target: "[[rule-surfacing-policy]]"
    relation: "tunes"
    confidence: 0.85
created: "2026-06-03"
---

# Operator Tuning Decisions

The five values the operator sets that tune the priority model (`[[rule-priority-model]]`)
and the surfacing policy (`[[rule-surfacing-policy]]`). The structure is fixed and
load-bearing; the values are operator-input-required. Until set, the safe defaults below
hold and the membrane runs at L1 with surfacing learning OFF, which needs no value to run
safely.

## The five values

1. **Prioritization weights** for the score `w_u*urgency + w_d*dependency + w_c*charter +
   w_s*stakes - w_e*effort`. Default: all weights equal (1.0). Operator value: Unknown
   until the operator sets it (operator input required).
2. **Stakes-by-reversibility auto-handle cutoffs**: which combinations count as safe
   enough to auto-handle. Default: none (nothing auto-handles at L1). Operator value:
   Unknown until the operator sets it (operator input required).
3. **Shadow-mode match threshold N**: how many times a candidate surfacing rule must match
   the operator's actual decision before it goes live. Default: not applicable while
   learning is OFF. Operator value: Unknown until the operator sets it (operator input
   required).
4. **Rule-edit authority**: who may create or edit surfacing rules, operator-only or
   system-proposes-and-operator-approves. Default: operator-only. Operator value: Unknown
   until the operator sets it (operator input required).
5. **Daily-review cadence**: when the batch action feeds (the morning and evening review
   times). Default: batch surfaces at the next explicit review the operator runs. Operator
   value: Unknown until the operator sets it (operator input required).

## Why these are deferred, not blocking

At L1 with learning OFF, nothing auto-handles and everything batches to the operator, so
none of these values is needed to run the membrane safely. They are filled when the
operator is ready to let the system earn auto-handle, which is the move toward L2. Filling
them is a logged operator decision; each change is a correction that tunes the rules per
``operator-priority-and-surfacing-model``.

## Notes

Do not invent these values. They encode how much autonomy the operator grants and what the
operator is willing to not see; only the operator sets them.
