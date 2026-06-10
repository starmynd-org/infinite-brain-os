---
id: "knowledge-ai-architecture-canon-entity-knowledge-namespaces"
aliases: ["knowledge-ai-architecture-canon-entity-knowledge-namespaces", "ai-architecture-entity-knowledge-namespaces", "entity-knowledge-namespaces"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Canon for the Knowledge namespace: the knowledge/<namespace>/ unit that declares one of eight profiles over a shared base of INDEX, canon, playbooks, support, and synthesis, organized namespace-first rather than type-first."
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
  - target: "[[namespace-profiles]]"
    relation: "references"
    confidence: 0.88
  - target: "[[required-namespace-surfaces]]"
    relation: "references"
    confidence: 0.88
  - target: "[[knowledge-nodes]]"
    relation: "related_to"
    confidence: 0.85
created: "2026-05-31"
---

## What it is

A **Knowledge namespace** is the unit of the knowledge graph: a `knowledge/<namespace>/`
folder that holds its own typed nodes, its `canon/` synthesis, its `synthesis/` derived
thinking, and its `support/` provenance. The graph is organized namespace-first, not
type-first: each namespace is one physical home for browsing, partial sharing, and
migration. A namespace declares one of eight profiles that adds folders to a shared base
without forking the ontology.

## When to use it (and when not)

Create a namespace when several related nodes should share one identity and a governance
boundary larger than a single node, or when a legacy corpus needs structured migration. Do
not create a namespace when one standalone node is enough, when the source material is too
fuzzy to define boundaries, or when the inbound material is unprocessed (route it through
the root `intake/` fabric first). Do not build an Intake Fabric namespace under
`knowledge/`; intake is a root OS layer.

## Required shape

- **Folder**: `knowledge/<namespace>/` with the shared base (`INDEX.md`, `canon/`,
  `playbooks/`, `support/`, `synthesis/`) plus profile-additive folders. Starter and
  example namespaces may carry a reduced base and must say so in their `INDEX.md`.
- **Registry**: an entry at `_system/namespaces/<slug>.md` declaring `profile`,
  `canon_posture`, `freshness_posture`, `archive_posture`, and `expected_folders`. A namespace
  may also declare optional `party_slugs`, `client_slug`, and `brand_slug` when external
  commercial scope materially shapes the namespace.
- **INDEX.md**: a retrieval router (not a folder list) with the required sections in order:
  purpose, profile, load-first, query classes, stable-vs-stateful, open disputes, what it
  drives, archive and provenance, common misreadings, and the map.

## How it relates to the other entity types

A namespace contains [[knowledge-nodes]] (pillars, concepts, decisions, playbooks),
[[metrics]], and, for stateful namespaces, a `canon/current-truth.md`. Its `canon/`
compresses its nodes; its `synthesis/` holds derived thinking; its `support/` holds
provenance. [[projects]], [[workflows]], and [[agents]] read namespaces, and the root
`intake/` fabric feeds distilled signal into them. The eight profiles map to the same
ontology, so an agent that knows the base can read any namespace.

External scope is not the same thing as namespace identity. A namespace may link to one or more
party records under `parties/` through `party_slugs`, `client_slug`, or `brand_slug`, but those
fields annotate scope rather than replacing the namespace boundary.

## Governing rules and doctrine

The namespace-first topology reasoning is in [[core-doctrine]] and the
knowledge-graph-namespace-first-topology decision; the shared base is in
[[required-namespace-surfaces]] and the eight profiles in [[namespace-profiles]]. The
operative folder schemas and the registry posture fields live in `_system/`
(`namespace-profiles`, `namespace-index-schema`); the base-surface and full-canon checks
are enforced by `validate.sh`. See [[system-overview]] for how namespaces sit in the entity
set.
