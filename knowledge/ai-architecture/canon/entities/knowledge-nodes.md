---
id: "knowledge-ai-architecture-canon-entity-knowledge-nodes"
aliases: ["knowledge-ai-architecture-canon-entity-knowledge-nodes", "ai-architecture-entity-knowledge-nodes", "entity-knowledge-nodes"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Canon for the Knowledge node: an atomic durable claim, definition, decision, or procedure stored as pillars, concepts, decisions, or playbooks, distinct from canon synthesis and from synthesis derived thinking."
confidence: 0.91
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
  - target: "[[canon-layer]]"
    relation: "bounded_by"
    confidence: 0.85
  - target: "[[knowledge-namespaces]]"
    relation: "part_of"
    confidence: 0.85
created: "2026-05-31"
---

## What it is

A **Knowledge node** is an atomic unit of durable understanding: one claim, definition,
decision, or procedure. It lives in a profile-additive folder of a namespace and takes one
of four common forms: a **pillar** (a foundational truth), a **concept** (a definition,
model, or framework), a **decision** (a choice made and the reasoning behind it), or a
**playbook** (step-by-step process knowledge). A node is an atom. It is not canon (the
compressed synthesis over many nodes) and not synthesis (derived interpretive thinking).

## When to use it (and when not)

Create a node when durable understanding, a single atomic claim, definition, decision, or
metric definition belongs in a namespace. Do not create a node when the item is an
unresolved intake stub (route it through the root `intake/` fabric first), a task or project
anchor, a raw operational log, compressed synthesis over many nodes (that is canon), or
derived interpretive work such as a contradiction map or best-current-reading note (that
goes in `synthesis/`).

## Required shape

- **Folder**: a profile-additive folder, usually `pillars/`, `concepts/`, `decisions/`, or
  `playbooks/`.
- **Frontmatter**: `id: knowledge-<namespace>-<slug>` (or the decision and playbook id
  forms), `type: "Knowledge"`, `namespace`, `lifecycle_state`, `summary`, `confidence`,
  `retrieval_class`, `export_class`, `aliases` when id differs from filename, and `edges`
  with `relation` and `confidence`. Use `derived_from` for lineage when the node distills
  other material.
- **Body**: a one-paragraph lead, then `##` sections. `retrieval_class` is `identity` for
  pillar-level nodes an agent should almost always load, `domain` for detail nodes. A node
  above `scratch` carries no placeholder text.

## How it relates to the other entity types

Knowledge nodes are the atoms that a namespace `canon/` compresses and that `synthesis/`
reasons across. They are read by [[agents]], [[workflows]], and [[projects]]. A
[[metrics|metric]] is a typed knowledge node with extra fields. A node never holds live
quantitative state; that is a [[data-nodes|data node]] pointer. The promotion path moves
material from raw source to `support/`, to `synthesis/`, to a canon candidate, to canon, so
a node is usually the start of that path.

## Governing rules and doctrine

The canon-versus-node distinction and the promotion path are in [[canon-layer]] and
[[core-doctrine]]; a node is atomic, canon is synthesis, and synthesis is derived thinking.
The operative frontmatter and id rules live in `_system/` (`stable-id-and-alias-rules`,
`metric-primitive-schema` for metric nodes); the required-keys and alias checks are
enforced by `validate.sh`. The build method is the `build-knowledge-node` skill. See
[[system-overview]] for how knowledge nodes sit in the entity set.
