---
id: "knowledge-ai-architecture-canonize-a-namespace"
aliases: ["knowledge-ai-architecture-canonize-a-namespace", "ai-architecture-canonize-a-namespace", "canonize-a-namespace"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Procedure to build or refresh a namespace canon: gather source nodes, synthesize compressed first-principles doctrine, set load order, get operator approval, record changelog and provenance."
confidence: 0.9
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[canon-layer]]"
    relation: "implements"
    confidence: 0.92
  - target: "[[promote-support-to-canon]]"
    relation: "related_to"
    confidence: 0.85
  - target: "[[canon-changelog-rules]]"
    relation: "bounded_by"
    confidence: 0.88
created: "2026-05-30"
---

# Canonize A Namespace

## Summary

Canon is the compressed, operator-approved, first-principles reasoning layer a future
agent loads before it expands into the deeper graph. This playbook builds canon for a
new namespace or refreshes it for an existing one. The output is small relative to the
graph it sits over, it cites what it derives from, and it never carries open questions
as permanent residents.

## When to run

Run this when a serious namespace has enough pillars, concepts, and decisions to
synthesize a stable core, when a synthesis node is proposed for promotion into canon,
or when accumulated edits have drifted the existing core-doctrine away from current
truth. Thin namespaces still get a thin canon, not an empty ritual. Starter and example
namespaces get no canon and say so in their `INDEX.md`.

## Procedure

1. Confirm the namespace warrants canon. Check the registry entry `canon_posture`. If
   it is `full`, produce `canon/README.md`, `canon/core-doctrine.md`, and
   `canon/agent-load-order.md`. If it is `thin`, produce a short core-doctrine plus the
   two navigational files. If it is `none`, stop and note why in `INDEX.md`.

2. Gather the source set. Read every pillar, concept, and decision in the namespace,
   plus any promoted synthesis nodes and relevant archive synthesis. Build a candidate
   list of the load-bearing claims. See [[canon-layer]] for what qualifies as canon
   material versus deeper-graph detail.

3. Synthesize, do not paraphrase. Compress the source set into first-principles
   doctrine: the few claims an agent must reason from. Do not copy `pillars/` node by
   node. Resolve tensions where you can; route genuinely unresolved tensions to
   `synthesis/`, not into canon.

4. Write `canon/core-doctrine.md` as a full knowledge node. Add `derived_from` edges to
   each pillar, concept, decision, and archive synthesis it compresses. Add `verified_at`
   and `verified_by` frontmatter. End the body with a `## Changelog` section.

5. Write `canon/agent-load-order.md`. State what to load first for this namespace and
   why: core-doctrine first, then the top three to five files for the most common query
   classes. This file is navigational and carries no node frontmatter.

6. Write `canon/README.md`. State what canon means here, how it was approved, and how to
   update it. This file is navigational and carries no node frontmatter.

7. For a stateful namespace such as `example-marketing`, add `canon/current-truth.md`
   for live-but-canonical facts such as current offer or current positioning. Keep
   durable doctrine out of it.

8. Request operator approval. Canon is not canon until the operator approves it.
   Present the core-doctrine, the source set it derives from, and what changed. Hold the
   node at `lifecycle_state: candidate` until approval lands.

9. On approval, record the revision. Append one changelog line with the date and a
   one-line reason per [[canon-changelog-rules]]. Set the relevant nodes to their
   approved lifecycle state and update the namespace `INDEX.md` `Load first` section to
   point at the new canon.

10. Re-run `bash _system/validate.sh`. Fix any missing canon files, broken links, or
    frontmatter errors before closing.

## Promotion path

The path into canon is: raw source, then `support/` with provenance recorded, then
`synthesis/` as a derived reading, then a canon-candidate, then operator-approved canon.
This playbook owns the last two hops. [[promote-support-to-canon]] owns the move from a
recorded support or synthesis artifact into a canon candidate.

## Quality checks

- Core-doctrine is materially smaller than the sum of its sources.
- Every claim in core-doctrine traces to a `derived_from` edge.
- No open questions live permanently in canon.
- `agent-load-order.md` names real files that resolve.
- The operator approval and the changelog line both exist before the node leaves
  candidate state.

## Notes

Keep canon disciplined. The failure mode is canon that grows into a second copy of the
graph. If core-doctrine starts paraphrasing pillars node by node, cut it back and push
detail down. The model for canon depth is the synthesized Boyd HTML docs, not a thin
loader and not a full transcript.
