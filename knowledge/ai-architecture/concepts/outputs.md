---
id: "knowledge-ai-architecture-outputs"
aliases: ["knowledge-ai-architecture-outputs", "outputs", "outputs-concept"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Outputs are first-class produced artifacts in the entity graph: emitted by workflows, agents, and swarms, bounded by lineage, and promoted into memory, synthesis, canon, or planning truth when they change understanding."
confidence: 0.93
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[core-doctrine]]"
    relation: "derived_from"
    confidence: 0.92
  - target: "[[entity-output-nodes]]"
    relation: "extends"
    confidence: 0.93
  - target: "[[correction-loop-absorption]]"
    relation: "feeds"
    confidence: 0.88
  - target: "[[surface-boundary]]"
    relation: "bounded_by"
    confidence: 0.88
  - target: "[[session-ledger-root-layer]]"
    relation: "related_to"
    confidence: 0.76
  - target: "[[department-assembly-model]]"
    relation: "supports"
    confidence: 0.8
created: "2026-06-01"
---

# Outputs

## Summary

Outputs are the entity layer where work becomes a produced artifact. They are the emitted files a
workflow, agent, deterministic run, or swarm creates: updates, briefs, drafts, reports, packets,
and other bounded deliverables. They are first-class because the architecture should expose what
canon and execution actually produce. They are bounded because the artifact is not the same thing
as the durable truth the system reasons from later. This concept extends [[entity-output-nodes]]
from the entity-catalog view into a whole-system view.

## Place in the entity graph

Outputs sit downstream of execution and upstream of correction:

- namespaces and canon inform [[workflows]], [[agents]], and decisions
- workflows, agents, commands, and swarms produce outputs
- outputs feed `memory/`, synthesis, rules, project truth, and canon revisions when the artifact
  changes understanding

That makes Outputs a bridge entity. They connect knowing to doing and doing back to knowing.

## Output is not support and not synthesis

The same work can produce all three, but they are different things:

- An output shows what was produced.
- Support preserves provenance, source context, or migration evidence.
- Synthesis states the durable interpretation that remains after reading, comparison, or review.

Confusing them creates second sources of truth. A generated report left only in `outputs/` is not
yet durable understanding. A source-preserving research note stored in `outputs/` is misrouted
support. A best-current-reading note stored only in `outputs/` is misrouted synthesis.

## Why Outputs are first-class

The architecture insists that canon should drive action, not become a museum. Outputs are one of
the visible proofs of that claim. A namespace `INDEX.md` names what its canon drives, and one
common answer is an output family or concrete output artifact. This is why output linkage matters:
the graph should show which knowledge actually produces operational artifacts. The operative review
for that relationship lives in `_system/output-linkage-review-rules.md`.

## Why Outputs are bounded

The artifact should remain traceable to its producer and its inputs, but authoritative meaning must
move to the surface that owns it. The [[surface-boundary]] applies here:

- `outputs/` may keep the artifact
- `memory/` may keep reusable lessons
- `knowledge/<namespace>/synthesis/` may keep the durable interpretation
- canon, `_system`, projects, or other governed homes may keep the settled truth

Nothing durable and authoritative should live only in `outputs/`.

## Lineage and promotion

Outputs need lineage because otherwise they are just files in a folder. The minimum answerable
questions are:

- what produced this
- when it was produced
- what it drew on
- which local operating surface it belongs to

Once those answers exist, the correction loop can work. A useful output can become:

- memory, if it teaches a reusable lesson
- synthesis, if it changes understanding
- a rule, workflow edit, canon change, or project update, if it changes structure or planning

The artifact can stay. The meaning gets promoted. This is the Outputs-side entry into
[[correction-loop-absorption]].

## Department and swarm implications

Departments need recurring outputs so the AI-first operating loop is visible: daily updates,
rollups, reviews, and other emitted operating surfaces. Swarms need outputs so execution produces
bounded receipts, analysis packets, and closeout evidence rather than disappearing into chat. In
both cases, the output is a delivery surface, not the only durable home of truth.

## Operative contract

The top-level placement contract is `outputs/README.md`. The operative builder rule is
`_system/outputs-placement-rules.md`. The namespace-level forward and backward review of what canon
drives lives in `_system/output-linkage-review-rules.md`.
