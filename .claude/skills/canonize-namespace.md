---
id: "skill-canonize-namespace"
aliases: ["skill-canonize-namespace", "canonize-namespace"]
type: "Skill"
namespace: "personal-operator"
lifecycle_state: "research"
summary: "Build or refresh a namespace canon folder from its pillars, concepts, decisions, and archive as compressed first-principles synthesis, behind the operator-approval gate, with derived_from provenance and a changelog."
confidence: 0.9
retrieval_class: "domain"
export_class: "internal"
description: "Use this skill when a serious namespace needs its canon built or refreshed: compressed reasoning a future agent loads first, approved by the operator, citing what it derives from."
edges:
  - target: "[[canon-layer-schema]]"
    relation: "implements"
    confidence: 0.95
  - target: "[[canonize-a-namespace]]"
    relation: "implements"
    confidence: 0.92
  - target: "[[canon-layer]]"
    relation: "informed_by"
    confidence: 0.9
  - target: "[[promotion-path-rules]]"
    relation: "depends_on"
    confidence: 0.88
  - target: "[[namespace-index-schema]]"
    relation: "depends_on"
    confidence: 0.85
  - target: "[[skill-promote-support-to-canon]]"
    relation: "paired_with"
    confidence: 0.9
  - target: "[[skill-refine-namespace-index]]"
    relation: "paired_with"
    confidence: 0.85
  - target: "[[rule-voice-and-style]]"
    relation: "governed_by"
    confidence: 0.8
created: "2026-05-30"
---

# canonize-namespace

Use this skill to build or refresh a namespace `canon/` folder. Canon is the compressed,
operator-approved, first-principles reasoning layer a future agent loads before it
expands into the deeper graph. It synthesizes the pillars, concepts, decisions, and
archive; it does not paraphrase them node by node. The operative contract is in
[[canon-layer-schema]]; the procedure shape is in [[canonize-a-namespace]]; the reason
canon is first-class compressed knowledge rather than a thin loader is in [[canon-layer]].

This skill always stops at the operator-approval gate. Canon does not change without a
recorded operator decision.

## Use when

- a serious namespace has no `canon/` and its registry declares `canon_posture: full` or
  `thin`
- the underlying pillars, concepts, or decisions changed enough that canon is now stale
- a canon-candidate package in `synthesis/` is ready for promotion into canon
- a namespace passed an upgrade and needs its compressed reasoning written

## Do not use when

- the registry declares `canon_posture: none` (starter and example namespaces); say so in
  the INDEX.md instead
- the namespace has too few stable nodes to compress; build nodes first via
  [[skill-build-namespace]]
- the material is unresolved or contested; that belongs in `synthesis/`, not canon
- you do not have an operator decision to record; draft canon-candidate in `synthesis/`
  and route promotion through [[skill-promote-support-to-canon]] instead

## Goal

Produce a small, disciplined `canon/` that compresses the namespace's best current
first-principles understanding, cites what it derives from, carries verification and a
changelog, and is the declared load-first surface in the INDEX.md.

## Required outputs

1. `canon/README.md`: what canon means here, how it was approved, how to update it
   (navigational, no node frontmatter)
2. `canon/core-doctrine.md`: the compressed synthesis as a full knowledge node with
   `derived_from` edges, `verified_at`, `verified_by`, and a `## Changelog` section
3. `canon/agent-load-order.md`: what to load first for this namespace and why
   (navigational, no node frontmatter)
4. for stateful namespaces only: `canon/current-truth.md` (a node with frontmatter)
5. an updated `## Load first` block for the INDEX.md via [[skill-refine-namespace-index]]
6. a recorded operator-approval line with date and one-line reason

## Build steps

1. Read the namespace pillars, concepts, decisions, and any archive synthesis. Read the
   registry entry for `canon_posture` and `profile`.
2. Draft `core-doctrine.md` as compression: state the first-principles understanding in
   the namespace's own voice, not as a list of node summaries. Keep it small relative to
   the graph it sits over (G3). For Tool Contract profiles, use `canon/core-contract.md`
   as the file of record per [[canon-layer-schema]].
3. Add `derived_from` edges to every pillar, concept, decision, and archive synthesis the
   doctrine compresses. Add `verified_at` and `verified_by`.
4. Write `canon/agent-load-order.md` and `canon/README.md` as navigational files.
5. Present the draft canon to the operator. Stop here. Do not mark anything canon without
   an operator decision (the approval gate).
6. On approval, append a `## Changelog` entry to `core-doctrine.md` with the date and a
   one-line reason. Update the INDEX.md `## Load first` to point at canon.
7. Move any promoted canon-candidate out of `synthesis/` per [[promotion-path-rules]] and
   leave a provenance trail.

## Quality checks

- canon compresses, it does not paraphrase pillars node by node (G3)
- no open questions parked permanently in canon; they live in `synthesis/` or `intake/`
- `core-doctrine.md` carries `derived_from`, `verified_at`, `verified_by`, and a changelog
- canon is small relative to the namespace graph
- the operator-approval gate was honored and the decision is recorded
- INDEX.md `## Load first` points at canon after approval
- no em dashes, no en dashes

## Anti-patterns

- concatenating pillar summaries and calling it canon
- canonizing contested or unresolved material to make it look settled
- writing canon without the `derived_from` provenance chain
- skipping the operator-approval gate because the synthesis "looks done"
- letting canon grow until it is as large as the graph it should compress
