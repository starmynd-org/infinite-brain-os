---
id: "rule-signal-vocabulary"
aliases: ["rule-signal-vocabulary", "signal-vocabulary"]
type: "Rule"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "The nine domain-free signals every work item and human-bound item carries, computed brain-side, that the priority model and the surfacing policy both read. The shared scoring substrate built once and used by every department head and the chief-of-staff membrane."
confidence: 0.85
retrieval_class: "domain"
export_class: "internal"
description: "Apply this rule whenever an item is scored, ordered, or routed: every item carries these nine signals so the priority model and the surfacing policy act on one shared vocabulary. Computed in the brain; Paperclip stores only priority, status, labels, executionState."
edges:
  - target: "[[rule-priority-model]]"
    relation: "read_by"
    confidence: 0.85
  - target: "[[rule-surfacing-policy]]"
    relation: "read_by"
    confidence: 0.85
created: "2026-06-03"
---

# Rule: Signal Vocabulary

Every item, whether a work item a head orders or a human-bound item the membrane routes, carries the
same nine domain-free signals. Each department maps its specific items onto these. This is the shared
substrate built once: the priority model (`[[rule-priority-model]]`) and the surfacing policy
(`[[rule-surfacing-policy]]`) both read it. It is the operative form of the signal layer in
``operator-priority-and-surfacing-model`` and the residual carried forward in the result-and-escalation contract.

## The nine signals

| Signal | Values | Used by |
|---|---|---|
| stakes | low, medium, high, critical | both |
| reversibility | reversible, costly, irreversible | both; decisive for surfacing |
| urgency | none, soon, deadline, decaying | both |
| dependency-unblocking | count of items this completing unblocks | prioritization |
| effort | rough size or token cost (small, medium, large) | prioritization |
| confidence | the scoper's or worker's confidence in its own output, 0.0 to 1.0 | surfacing |
| charter-alignment | how well it serves the owning department's north star (low, medium, high) | both |
| external | boolean hard flag: touches the outside world (send, deploy, spend, publish) | surfacing, always surfaces |
| canon-touching | boolean hard flag: proposes a change to canon | surfacing, always surfaces |

## Where the signals live

Computed brain-side and attached to the git item definition. A Paperclip issue stores only `priority`,
`status`, labels, and `executionState`, so the full vocabulary informs Paperclip ordering and the
surfacing routing without being native Paperclip fields. The vocabulary is brain-owned and
human-tunable; Paperclip executes the resulting order.

## Hard-flag semantics

`external` and `canon-touching` are not weighted; they are gates. Any item with either flag always
surfaces to the operator, regardless of every other signal. `confidence` below the operator-set
threshold also always surfaces. These three override the score.

## Discipline

A department that emits items must populate all nine signals (a missing signal defaults conservative:
unknown reversibility is treated as costly-or-irreversible, unknown stakes as high). Adding or removing a
signal is a contract change to this rule, not a per-department improvisation.
