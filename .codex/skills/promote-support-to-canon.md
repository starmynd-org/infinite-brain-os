---
id: "skill-promote-support-to-canon"
aliases: ["skill-promote-support-to-canon", "promote-support-to-canon"]
type: "Skill"
namespace: "personal-operator"
lifecycle_state: "research"
summary: "Walk a node along the promotion path from raw source through support, synthesis, and canon-candidate to operator-approved canon, preserving provenance at each step."
confidence: 0.9
retrieval_class: "domain"
export_class: "internal"
description: "Use this skill to move knowledge up the promotion path: support provenance becomes derived synthesis, synthesis becomes a canon-candidate, and an approved canon-candidate becomes canon."
edges:
  - target: "[[promotion-path-rules]]"
    relation: "implements"
    confidence: 0.95
  - target: "[[canon-layer-schema]]"
    relation: "depends_on"
    confidence: 0.9
  - target: "[[correction-loop-rules]]"
    relation: "references"
    confidence: 0.82
  - target: "[[correction-loop-absorption]]"
    relation: "informed_by"
    confidence: 0.85
  - target: "[[canon-layer]]"
    relation: "informed_by"
    confidence: 0.85
  - target: "[[skill-canonize-namespace]]"
    relation: "paired_with"
    confidence: 0.9
  - target: "[[skill-detect-contradictions]]"
    relation: "paired_with"
    confidence: 0.8
  - target: "[[rule-voice-and-style]]"
    relation: "governed_by"
    confidence: 0.8
created: "2026-05-30"
---

# promote-support-to-canon

Use this skill to move a piece of knowledge along the promotion path: raw source, then
support (provenance recorded), then synthesis (derived reading), then canon-candidate,
then canon (operator-approved). Each step adds interpretation and provenance; no step
skips ahead. The operative rules are in [[promotion-path-rules]]; the canon contract the
final step must satisfy is in [[canon-layer-schema]]; the reason repeated correction
should climb this path rather than recur in chat is in [[correction-loop-absorption]].

## Use when

- a `support/` provenance note now carries a stable derived reading worth synthesizing
- a `synthesis/` note has matured into a canon-candidate worth proposing
- a recurring correction (per [[correction-loop-rules]]) should become durable structure
- the operator approved a canon-candidate and it needs to land in `canon/`

## Do not use when

- the material is still contested; resolve it in `synthesis/` first, or surface the
  conflict via [[skill-detect-contradictions]]
- you want to write canon from scratch across a whole namespace; use
  [[skill-canonize-namespace]]
- the item is raw inbound; route it through the intake fabric first
- there is no operator decision for the canon step; stop at canon-candidate

## Goal

Promote a node one or more steps up the path with provenance preserved at each step, so
the trail from raw source to canon is auditable and no link is broken on the way up.

## Required outputs

1. the node at its new path stage (support, synthesis, canon-candidate, or canon)
2. preserved provenance: edges back to the prior stage and the original source
3. for a canon step: a recorded operator-approval line and a `## Changelog` entry on
   `canon/core-doctrine.md`
4. updated `aliases` or a `supersedes` stub if the file moved or was renamed (G8)
5. an updated INDEX.md `## Load first` or `## Open disputes` reference if the stage changed

## Build steps

1. Identify the node's current stage and the next legal stage per [[promotion-path-rules]].
   The path is one-directional: support, synthesis, canon-candidate, canon.
2. For support to synthesis: write the derived reading in `synthesis/`, add a
   `derived_from` edge to the support note, and keep the support provenance intact (do
   not delete it; synthesis and support are different homes per G11).
3. For synthesis to canon-candidate: package the synthesis as a proposal, name what it
   would change in canon, and add edges to the pillars and concepts it compresses.
4. For canon-candidate to canon: present it to the operator. Stop at the approval gate.
   On approval, fold it into `canon/core-doctrine.md` per [[skill-canonize-namespace]],
   add the `derived_from` edges, and append a `## Changelog` entry.
5. Preserve links on any move: add the old id to the new file's `aliases`, or leave a
   stub with a `supersedes` pointer (G8).
6. Update the INDEX.md if the promotion changed what loads first or what is still disputed.

## Quality checks

- the node moved exactly one legal stage, or a recorded chain of stages, never a skip
- provenance edges back to the prior stage and original source are present
- the canon step honored the operator-approval gate and recorded a changelog entry
- no link broke on a move (alias or supersedes stub added)
- support provenance was not destroyed when synthesis was derived from it
- no em dashes, no en dashes

## Anti-patterns

- promoting raw source straight into canon
- deleting the support provenance once a synthesis exists
- landing canon without an operator decision
- moving a file without preserving the old id as an alias or stub
- promoting contested material to canon to end an argument
