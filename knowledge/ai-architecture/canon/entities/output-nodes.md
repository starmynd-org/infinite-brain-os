---
id: "knowledge-ai-architecture-canon-entity-output-nodes"
aliases: ["knowledge-ai-architecture-canon-entity-output-nodes", "ai-architecture-entity-output-nodes", "entity-output-nodes"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Canon for the Output node: a produced artifact stored in outputs/ with lineage frontmatter linking back to the workflow or agent that made it, the ephemeral deliverable distinct from durable understanding."
confidence: 0.9
retrieval_class: "domain"
export_class: "internal"
verified_at: "2026-05-31"
verified_by: "operator-pending"
edges:
  - target: "[[system-overview]]"
    relation: "part_of"
    confidence: 0.9
  - target: "[[core-doctrine]]"
    relation: "derived_from"
    confidence: 0.88
  - target: "[[workflows]]"
    relation: "produced_by"
    confidence: 0.82
  - target: "[[projects]]"
    relation: "related_to"
    confidence: 0.8
created: "2026-05-31"
---

## What it is

An **Output node** is a produced artifact. It lives in `outputs/` with lineage frontmatter
that links back to the workflow or agent that produced it. An output is the deliverable a
piece of work emits: a drafted report, a generated page, a rendered deck. It is ephemeral by
retrieval class, distinct from the durable understanding the work leaves behind. Output is
first-class: a namespace whose canon drives no outputs is suspect.

## When to use it (and when not)

Create an output node for any produced artifact that should be tracked with its lineage, so
the artifact can be traced to what made it. Do not put durable reading or interpretation in
`outputs/` alone: a best-current-reading note, a contradiction map, or a canon-candidate
package belongs in a namespace `synthesis/` folder. The `outputs/` artifact is the
deliverable; the `synthesis/` node is the understanding the work leaves behind. Use both
ends when a project produces both.

## Required shape

- **Folder**: `outputs/`.
- **Frontmatter**: standard node fields plus `type: "Output"`, with lineage edges
  (`produced_by`) back to the [[workflows|workflow]] or [[agents|agent]] that created it.
  `retrieval_class` is usually `ephemeral`.
- **Body**: describe the artifact, where it lives if it is large or binary, and the work
  that produced it.

## How it relates to the other entity types

An output node is produced by a [[workflows|workflow]], an [[agents|agent]], or a
[[workflow-loops|workflow loop]], and is named by a [[projects|project]] as one of its
deliverables. It pairs with the namespace `synthesis/` layer: outputs are deliverables,
synthesis is durable understanding. Output linkage is also a namespace-level surface: each
namespace `INDEX.md` names what its canon drives, and outputs are where that lands.

## Governing rules and doctrine

The reasoning that every namespace answers what outputs its canon drives, and that output is
first-class, is in [[core-doctrine]] (output linkage). The operative output-linkage review
rules live in `_system/output-linkage-review-rules.md`. The deliverable-versus-synthesis
split is the discipline that keeps durable understanding out of the ephemeral outputs layer.
See [[system-overview]] for how output nodes sit in the entity set.
