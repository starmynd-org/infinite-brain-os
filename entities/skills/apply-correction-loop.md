---
id: "skill-apply-correction-loop"
aliases: ["skill-apply-correction-loop", "apply-correction-loop"]
type: "Skill"
namespace: "personal-operator"
lifecycle_state: "research"
summary: "Absorb a recurring human correction into durable structure (rule, playbook, decision, or canon revision) using the three questions and the third-time test."
confidence: 0.9
retrieval_class: "domain"
export_class: "internal"
description: "Use this skill when the operator corrects the same class of mistake a second or third time, so the fix becomes structure that future sessions read instead of a correction re-paid in chat."
edges:
  - target: "[[correction-loop-rules]]"
    relation: "governed_by"
    confidence: 0.92
  - target: "[[correction-loop-absorption]]"
    relation: "informed_by"
    confidence: 0.9
  - target: "[[promotion-path-rules]]"
    relation: "depends_on"
    confidence: 0.78
  - target: "[[skill-cross-synthesize-corpus]]"
    relation: "related_to"
    confidence: 0.65
  - target: "[[skill-review-output-linkage]]"
    relation: "related_to"
    confidence: 0.65
  - target: "[[rule-voice-and-style]]"
    relation: "governed_by"
    confidence: 0.8
created: "2026-05-30"
---

# apply-correction-loop

Turn a recurring correction into durable structure so the same mistake stops costing
operator attention every session. The reasoning, the three-question test, and the
third-time threshold come from [[correction-loop-absorption]] (the why) and
[[correction-loop-rules]] (the operative procedure). This skill is the technique an agent
runs to absorb one correction into the right layer.

## Use when

- the operator has corrected the same class of mistake a second or third time
- a correction you complied with this turn will not persist into the next session because
  no durable structure changed
- you notice an instruction the operator keeps re-issuing across sessions
- a session retro surfaces a repeated correction that was never absorbed

## Do not use when

- the correction is a one-off specific to this single task (comply and move on; absorbing
  one-offs bloats the rule layer)
- the correction is genuinely new information for a knowledge node rather than a behavior
  fix (route it as intake or a node edit)
- the fix is large derived thinking across namespaces (use
  [[skill-cross-synthesize-corpus]])

## Goal

Absorb the recurring correction into exactly one durable home so the next session reads
the corrected behavior by default, and leave a record of what was absorbed and why.

## Required outputs

1. A recorded answer to the three questions (below) for this correction.
2. A change in exactly one durable layer: a rule update, a playbook step, a decision node,
   or a canon revision, chosen by the routing table in [[correction-loop-rules]].
3. A one-line note of what was absorbed and where, so the absorption itself is auditable.

## Build steps

1. Confirm the third-time test. Has this class of correction occurred at least the
   threshold number of times stated in [[correction-loop-rules]] (the recurrence bar, not
   a single instance)? If not at threshold, comply for the turn and log the instance; do
   not absorb yet.
2. Answer the three questions from [[correction-loop-absorption]]:
   - What is the general rule behind this specific correction?
   - Where should that rule live so the right agent reads it at the right time?
   - What is the smallest durable change that prevents the next recurrence?
3. Route to one layer using the [[correction-loop-rules]] table: behavior and style fixes
   go to a rule; procedure fixes go to a playbook step; a choice with reasoning goes to a
   decision node; a shift in first-principles understanding goes to a canon revision (with
   a changelog entry).
4. Make the smallest correct edit. Do not over-generalize a single correction into a
   sweeping rule. Keep the change scoped to the actual recurring pattern.
5. If the change is a canon revision, add a `## Changelog` entry with date and one-line
   reason per [[canon-layer-schema]]; canon edits are operator-approved, so mark the
   approval state.
6. Record the absorption. Note what was corrected, the general rule, and the file that now
   carries it, so a later review can confirm the loop closed.

## Quality checks

- the correction met the recurrence threshold before absorption (no premature
  rule-bloat from one-offs)
- the change landed in exactly one layer, not duplicated across rule and playbook and
  canon
- the durable change is the smallest one that prevents recurrence
- a canon revision carries a changelog entry and an approval state
- run `bash _system/validate.sh` after the edit
- the absorption note names the file that now carries the corrected behavior

## Anti-patterns

- complying with the correction this turn and changing nothing durable (the loop stays
  open and the next session repeats the error)
- absorbing a one-off into a permanent rule
- writing the same fix into two layers so they drift
- generalizing one narrow correction into a broad rule that overreaches
- editing canon without an operator-approved changelog entry
