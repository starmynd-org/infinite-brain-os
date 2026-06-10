---
id: "knowledge-ai-architecture-what-canon-means"
aliases: ["knowledge-ai-architecture-what-canon-means", "ai-architecture-what-canon-means"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "The operator's definition of canon: the thing you reason from, closer to a synthesized document than to a loader, distinct from pillars, support, and synthesis."
confidence: 0.9
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[canon-layer]]"
    relation: "related_to"
    confidence: 0.92
  - target: "[[core-doctrine]]"
    relation: "references"
    confidence: 0.85
created: "2026-05-30"
---

## Summary

Canon is the thing you reason from. The operator's definition is deliberately stronger
than "the file an agent loads first": canon is closer to a synthesized document, dense
first-principles writing, than to a thin loader or a table of contents. This node states
that definition and draws the lines that separate canon from the three layers it is most
often confused with. The folder mechanics and required files live in [[canon-layer]].

## The operator's definition

Canon is the compressed first-principles understanding a future AI should think from
before it touches the rest of the graph. The reference point is the synthesized Boyd
docs in `zz_archived/Resources/PKM/john-boyd/docs`: those documents reason, they do not
merely index. A future agent should be able to load a namespace's canon, hold the load-
bearing claims in working context, and reason about a new question without first reading
the whole corpus.

This sets a quality bar. Canon is written to be reasoned from, so it states claims,
their grounds, and their limits. It is not a list of pointers, and it is not a paraphrase
of the underlying nodes one by one. If a canon file reads like a folder map, it is not
canon yet.

## How canon differs from pillars

Pillars are atomic doctrine: one foundational truth per node, stated cleanly, with
`retrieval_class: identity`. Canon is synthesis: it reasons across the pillars, concepts,
and decisions to produce the compressed first-principles reading. A pillar answers "what
is true." Canon answers "how these truths fit together and what an agent should conclude
from them." Canon cites pillars through `derived_from`; it does not replace them, and a
healthy namespace keeps both.

## How canon differs from support

Support is provenance and migration only: where a claim came from, what was reorganized,
which source has priority, what receipt records a move. Support is mechanical and
historical. Canon is the approved current reading. The two never overlap: a `derived_from`
edge points from canon into the sources whose provenance support records, but canon
states the conclusion while support states the lineage. Putting a synthesized reading
into `support/` hides it from the agent that needs it; putting a migration receipt into
canon pollutes the reasoning layer with bookkeeping.

## How canon differs from synthesis

Synthesis is in-progress derived thinking: contradiction maps, best-current-reading
notes, what-changed reviews, and canon-candidate packages. Synthesis is current and
interpretive but not yet settled. Canon is settled: operator-approved, provenance-bearing,
and stable until a recorded changelog revision moves it. The promotion path is
directional: raw source, then support, then synthesis, then canon-candidate, then canon.
A claim that is still being argued belongs in synthesis. A claim the operator has
approved as the reading to reason from belongs in canon. Open questions never live
permanently in canon.

## Edges

- `related_to` [[canon-layer]]: that node owns the folder contract and required files;
  this node owns the operator's definition.
- `references` [[core-doctrine]]: the canon file where this definition is put to work.

## Notes

The shortest test: if you would reason from it, it is a canon candidate. If you would
cite it for where a claim came from, it is support. If you are still arguing it, it is
synthesis. If it is a single atomic truth, it is a pillar. Canon is the settled,
synthesized, reason-from layer, and nothing else.
