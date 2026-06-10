---
id: "knowledge-doctrine-example-canon-core-doctrine"
aliases: ["knowledge-doctrine-example-canon-core-doctrine", "doctrine-example-core-doctrine", "core-doctrine"]
type: "Knowledge"
namespace: "doctrine-example"
lifecycle_state: "research"
summary: "Compressed first-principles synthesis for the doctrine-example namespace. Shows what a Doctrine profile canon node looks like."
confidence: 0.85
retrieval_class: "identity"
export_class: "internal"
verified_at: "2026-05-30"
verified_by: "the-operator"
edges:
  - target: "[[example-discipline-pillar]]"
    relation: "derived_from"
    confidence: 0.9
  - target: "[[namespace-profiles]]"
    relation: "references"
    confidence: 0.8
created: "2026-05-30"
---

This node demonstrates what a Doctrine profile `canon/core-doctrine.md` looks like. It
is an example, not real doctrine. In a real namespace, this file compresses the best
current first-principles understanding across all pillars, concepts, and decisions in
the namespace.

## Shape of first-principles discipline (example)

A first-principles discipline starts with one claim that cannot be further reduced. All
other doctrine in the namespace derives from that claim. The foundational pillar names
the claim; concepts elaborate it; decisions apply it to real choices.

Canon compresses this chain. An agent reading `core-doctrine.md` should be able to
reason correctly about the domain without first reading every pillar and concept. The
deeper graph is for confirmation, lineage, and edge cases, not for primary reasoning.

## What this means in practice (example)

Three operational rules follow from the foundational claim in a first-principles
discipline:

- Derive before deciding. Before choosing a direction, trace it back to the foundational
  claim. If the direction contradicts the claim, reject it or revise the claim explicitly.
- Compress before communicating. Synthesis is never raw archive. It is the minimum
  representation that retains the operative content.
- Record the chain. Every canon node records where it comes from, so an operator can
  audit whether the synthesis is still valid when sources change.

These rules are enacted by the `playbooks/` folder and tested by the `synthesis/` folder
when disputes emerge.

## Boundary notes (example)

This canon does not address: applications of the discipline to specific domains
(those live in `concepts/` and `decisions/`), the full source corpus (that lives in
`archive/` or `support/`), or contested readings (those live in `synthesis/`).

## Changelog

- 2026-05-30: Initial example scaffold created by build agent for the V2 namespace
  architecture sprint.
