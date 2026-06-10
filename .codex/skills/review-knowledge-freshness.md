---
id: "skill-review-knowledge-freshness"
aliases: ["skill-review-knowledge-freshness", "review-knowledge-freshness"]
type: "Skill"
namespace: "personal-operator"
lifecycle_state: "research"
summary: "Review a namespace for stale knowledge by its declared freshness posture, checking verified_at staleness against the posture window and proposing re-verify, revise, or archive actions."
confidence: 0.9
retrieval_class: "domain"
export_class: "internal"
description: "Use this skill to review knowledge freshness scoped by posture: only namespaces and nodes whose state decays get a staleness check, so stable doctrine is not churned needlessly."
edges:
  - target: "[[freshness-review-rules]]"
    relation: "implements"
    confidence: 0.95
  - target: "[[namespace-profiles]]"
    relation: "depends_on"
    confidence: 0.88
  - target: "[[canon-layer-schema]]"
    relation: "references"
    confidence: 0.82
  - target: "[[review-namespace-health]]"
    relation: "informed_by"
    confidence: 0.85
  - target: "[[canon-layer]]"
    relation: "informed_by"
    confidence: 0.8
  - target: "[[skill-lint-namespace]]"
    relation: "paired_with"
    confidence: 0.8
  - target: "[[skill-detect-contradictions]]"
    relation: "paired_with"
    confidence: 0.8
  - target: "[[rule-voice-and-style]]"
    relation: "governed_by"
    confidence: 0.8
created: "2026-05-30"
---

# review-knowledge-freshness

Use this skill to review a namespace for stale knowledge, scoped by its declared
`freshness_posture` (G10). Freshness review applies where state decays, not uniformly to
stable doctrine: a thinker's canon does not rot the way a current-offer node or a live
metric does. The operative rules and posture windows are in [[freshness-review-rules]];
the postures themselves (`review-on-edit`, `periodic`, `live`) are set in the registry per
[[namespace-profiles]]; the reason curation against rot is a first-class activity is in
[[canon-layer]] and [[review-namespace-health]].

## Use when

- a periodic or live freshness namespace is due for review
- a `canon/current-truth.md` node may no longer reflect current facts
- a Data System or Tool Contract namespace has nodes whose sources may have changed
- the weekly or monthly review routes a freshness pass for namespaces in scope

## Do not use when

- the namespace is `freshness_posture: review-on-edit` and nothing was edited; stable
  doctrine does not need a blanket staleness sweep
- the issue is a contradiction, not age; use [[skill-detect-contradictions]]
- the issue is structure, not staleness; use [[skill-lint-namespace]]
- the node carries no time-sensitive claim; freshness does not apply to it

## Goal

Produce a freshness report scoped to the right namespaces and nodes, listing each
time-sensitive node whose `verified_at` is past its posture window, with a proposed action
(re-verify, revise, or archive) and the evidence that would settle it.

## Required outputs

1. the set of namespaces and nodes in scope, derived from `freshness_posture`
2. a per-node staleness check: `verified_at` against the posture window from
   [[freshness-review-rules]]
3. a proposed action per stale node: re-verify, revise, or archive
4. for `canon/current-truth.md`: an explicit current-vs-recorded comparison
5. a short note of any node missing `verified_at` that should carry it

## Build steps

1. Read the registry for each candidate namespace and collect its `freshness_posture`.
   Skip `review-on-edit` namespaces unless an edit triggered the review.
2. For periodic and live namespaces, list the time-sensitive nodes (current-truth,
   metrics, source contracts, anything with a `verified_at` claim).
3. For each, compute staleness: today minus `verified_at` against the posture window in
   [[freshness-review-rules]]. The window is a deterministic threshold, but the
   re-verify-vs-revise-vs-archive judgment is fuzzy and stays with this skill (G5).
4. Propose an action per stale node and state the evidence that would re-verify it.
5. For `canon/current-truth.md`, compare each recorded fact to the current reality and
   flag drift. Route any canon revision through the operator gate via
   [[skill-promote-support-to-canon]] or [[skill-canonize-namespace]].
6. Flag time-sensitive nodes missing `verified_at` so they can be made reviewable.

## Quality checks

- only namespaces and nodes whose state decays are in scope (G10), stable doctrine is not churned
- staleness uses the posture window from [[freshness-review-rules]], not an invented threshold
- each stale node has a proposed action and the evidence that would settle it
- `current-truth.md` drift is compared fact by fact, not waved through
- canon revisions are routed through the operator gate, not edited inline here
- no em dashes, no en dashes

## Anti-patterns

- sweeping stable thinker doctrine for staleness it does not have
- treating every node as time-sensitive and flooding the report
- editing canon current-truth inline without the operator gate
- reporting a node stale without naming what would re-verify it
- duplicating the deterministic window check the validator could own while skipping the action judgment
