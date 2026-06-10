---
id: "skill-detect-contradictions"
aliases: ["skill-detect-contradictions", "detect-contradictions"]
type: "Skill"
namespace: "personal-operator"
lifecycle_state: "research"
summary: "Surface contradictions across a namespace's nodes and archive, then record them as a synthesis contradiction-map with a current best resolution per node pair."
confidence: 0.9
retrieval_class: "domain"
export_class: "internal"
description: "Use this skill to find where nodes, canon, and archive disagree, then capture the conflicts as a contradiction-map in synthesis so the operator can resolve them deliberately."
edges:
  - target: "[[contradiction-review-rules]]"
    relation: "implements"
    confidence: 0.95
  - target: "[[promotion-path-rules]]"
    relation: "depends_on"
    confidence: 0.85
  - target: "[[canon-layer-schema]]"
    relation: "references"
    confidence: 0.82
  - target: "[[correction-loop-absorption]]"
    relation: "informed_by"
    confidence: 0.82
  - target: "[[canon-layer]]"
    relation: "informed_by"
    confidence: 0.8
  - target: "[[skill-promote-support-to-canon]]"
    relation: "paired_with"
    confidence: 0.85
  - target: "[[skill-lint-namespace]]"
    relation: "paired_with"
    confidence: 0.8
  - target: "[[rule-voice-and-style]]"
    relation: "governed_by"
    confidence: 0.8
created: "2026-05-30"
---

# detect-contradictions

Use this skill to surface contradictions across a namespace's nodes, canon, and archive,
and record them as a contradiction-map in `synthesis/`. Contradiction surfacing is fuzzy
work the validator cannot do (G5): the validator finds broken links and orphans, but
deciding that two nodes assert opposing claims is a reading judgment. The operative rules
are in [[contradiction-review-rules]]; the reason contradictions are first-class synthesis
artifacts rather than silent rot is in [[correction-loop-absorption]] and [[canon-layer]].

## Use when

- a namespace has grown enough that nodes may now disagree
- the contradiction-and-gap review workflow runs this skill on a namespace
- canon and a newer node appear to assert opposing claims
- the archive contains source material that conflicts with the current synthesis

## Do not use when

- the issue is a broken link, orphan, or missing frontmatter; that is `validate.sh`
- the issue is staleness, not disagreement; use [[skill-review-knowledge-freshness]]
- a contradiction is already mapped and only needs promotion; use
  [[skill-promote-support-to-canon]]
- the namespace is too small to hold contradictions yet

## Goal

Produce a contradiction-map in `synthesis/` that names each conflicting pair of claims,
cites both sources, states the current best resolution or marks it open, and links to
where resolution should land, so contradictions are tracked rather than absorbed silently.

## Required outputs

1. a `synthesis/contradiction-map.md` node (or dated update) with full frontmatter
2. one entry per conflict: the two claims, both source nodes, the conflict in one line
3. a current best resolution per conflict, or an explicit "open" marker
4. edges from the map to each node it cites
5. a pointer in the INDEX.md `## Open disputes` section for any unresolved conflict

## Build steps

1. Read the namespace canon, nodes, and the relevant archive synthesis. Read any prior
   `synthesis/contradiction-map.md`.
2. Compare claims pairwise where topics overlap. A contradiction is two nodes asserting
   opposing answers to the same question, not merely different scope. This is the fuzzy
   judgment the validator cannot make.
3. For each contradiction, record the two claims verbatim enough to be checkable, cite
   both source nodes, and write the conflict in one line.
4. State the current best resolution if one exists, citing which claim the synthesis
   currently favors and why. If unresolved, mark it open and note what evidence would
   settle it.
5. Add edges from the map node to every node it cites. Add a `## Open disputes` reference
   in the INDEX.md for each open conflict.
6. For conflicts where canon itself is wrong, do not edit canon here; route the
   correction through [[skill-promote-support-to-canon]] and the operator gate.

## Quality checks

- each entry names both source nodes and states the conflict precisely
- contradictions are distinguished from differences in scope or emphasis
- every open conflict appears in the INDEX.md `## Open disputes`
- the map lives in `synthesis/`, not in `support/` (G11) and not in canon
- canon is not silently edited to resolve a conflict; resolution goes through the gate
- no em dashes, no en dashes

## Anti-patterns

- flagging scope differences as contradictions and inflating the map
- resolving a contradiction by quietly editing canon
- recording a conflict without citing both sources
- parking contradictions permanently in canon instead of synthesis
- treating contradiction surfacing as a deterministic check the validator should own
