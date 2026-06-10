---
id: "skill-prioritize-backlog"
aliases: ["skill-prioritize-backlog", "prioritize-backlog"]
type: "Skill"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Apply the priority model to a backlog: compute the signal-weighted score, layer the hard rules and anti-starvation, break ties deterministically, and emit an explainable ordering with a one-line rationale per top item."
confidence: 0.82
retrieval_class: "domain"
export_class: "internal"
description: "Use this skill when a department head or the operator needs an ordered backlog. It applies the priority model deterministically and returns the order plus a one-line why for each top item."
edges:
  - target: "[[rule-priority-model]]"
    relation: "applies"
    confidence: 0.9
  - target: "[[rule-signal-vocabulary]]"
    relation: "depends_on"
    confidence: 0.85
created: "2026-06-03"
---

# Skill: Prioritize Backlog

Apply `[[rule-priority-model]]` to a set of items and return a deterministic, explainable ordering.

## Steps

1. Confirm each item carries the nine signals (`[[rule-signal-vocabulary]]`); fill missing signals with
   the conservative defaults.
2. Compute the weighted score using the operator-set weights (default equal until tuned).
3. Apply the hard rules: deadline jumps, blocked items held, dependency roots before dependents.
4. Apply the anti-starvation aging term so old items lift over time.
5. Break ties by age (oldest first).
6. Emit the ordered list, each top item with a one-line rationale ("next because urgency high, unblocks
   four").

## Output

An ordered backlog plus the per-item rationale. The ordering is reproducible: the same inputs and weights
produce the same order. The skill orders work; it does not gate human attention (that is
`[[skill-triage-human-items]]`).

## Boundary

Deterministic and explainable. If the order cannot be explained from the signals and rules, stop and
surface the gap rather than guessing.
