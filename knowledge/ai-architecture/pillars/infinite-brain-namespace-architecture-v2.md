---
id: "knowledge-ai-architecture-namespace-architecture-v2"
aliases: ["knowledge-ai-architecture-namespace-architecture-v2", "ai-architecture-namespace-v2", "infinite-brain-namespace-architecture-v2"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "The V2 topology: a namespace-first base with shared surfaces, additive profiles, and repo-level layers, chosen over type-first and one-schema-for-all."
confidence: 0.93
retrieval_class: "identity"
export_class: "internal"
edges:
  - target: "[[knowledge-graph-namespace-first-topology]]"
    relation: "depends_on"
    confidence: 0.94
  - target: "[[canon-layer]]"
    relation: "depends_on"
    confidence: 0.92
  - target: "[[namespace-profiles]]"
    relation: "depends_on"
    confidence: 0.92
  - target: "[[required-namespace-surfaces]]"
    relation: "implements"
    confidence: 0.9
created: "2026-05-30"
---

## Summary

The Infinite Brain knowledge graph is organized namespace-first. Every serious
namespace shares one base surface set, profiles add folders on top of that base
without forking it, and a few repo-level layers sit outside `knowledge/` to hold
work that no single namespace should own. This pillar states the V2 topology and
why it beats the two obvious alternatives: a type-first global layout and a single
schema applied uniformly to every namespace.

## The base is namespace-first

`knowledge/<namespace>/` is the unit of organization. A namespace is a domain of
knowledge with one owner, one ontology, and one canon. This is settled doctrine,
not a fresh choice: see [[knowledge-graph-namespace-first-topology]] for the
decision record. V2 keeps it and builds on it.

Namespace-first means a retrieving agent can load a whole domain by reading one
folder tree, and the namespace `INDEX.md` can route within that tree. The folder
boundary is the retrieval boundary. Cross-namespace work is the exception, handled
by explicit edges and the repo-level synthesis layer, not by a global type index.

## Shared base surfaces

Every serious namespace carries the same five base surfaces regardless of profile:

- `INDEX.md`: the retrieval router and agent operating brief, not a folder list.
- `canon/`: the compressed first-principles reasoning layer, loaded first.
- `playbooks/`: repeatable procedures the namespace owns.
- `support/`: provenance and migration only, mechanical and historical.
- `synthesis/`: within-namespace derived thinking that is neither raw nor canon.

A "serious" namespace is any namespace meant for real agent retrieval. Starter and
example namespaces may carry a reduced base and must say so in their `INDEX.md`. The
binding list of required surfaces and the serious-vs-starter distinction live in
[[required-namespace-surfaces]]. The canon contract lives in [[canon-layer]].

The shared base is the load-bearing promise of V2. An agent that knows the base
surfaces knows how to enter any namespace it has never seen. It loads canon first,
reads the INDEX router, and trusts that playbooks, support, and synthesis mean the
same thing everywhere.

## Profiles are additive

A profile is a named folder set layered on the shared base for one kind of
namespace. Doctrine namespaces add `pillars/`, `concepts/`, `decisions/`. A Data
System namespace adds `pipelines/`, `transforms/`, `models/`, `metrics/`. A Tool
Contract namespace adds `operations/`, `references/`, `examples/`. The profile
catalog and the rule that profiles add but never remove the base are owned by
[[namespace-profiles]].

The discipline is strict: a profile never removes a base surface, never invents a
competing ontology, and never renames a base folder. It only adds. That keeps the
base universal while letting each domain carry the structure its work demands.

## Repo-level layers outside `knowledge/`

Three layers sit at the repo root because they are cross-cutting or operational,
not domain knowledge:

- `intake/`: the root intake fabric. It receives inbound items from many sources,
  preserves source context, records routing decisions, and moves high-signal items
  into durable namespace homes. Intake never owns truth; the destination namespace
  does.
- `synthesis/` at root: cross-namespace synthesis that bridges two or more
  namespaces and should not belong to any one of them.
- `_system/`: the operative schema, rules, and namespace registry. It owns the
  "what" and "how to check." The `ai-architecture` namespace owns the "why."

These layers exist so that intake state, cross-domain reconciliation, and machine
rules do not get jammed into a single namespace where they would distort its
ontology.

## Why namespace-first beats type-first

A type-first layout would group all pillars across all domains under one
`pillars/`, all decisions under one `decisions/`, and so on. It reads cleanly on
paper and collapses in practice. Retrieval for a domain would have to fan out
across every type folder and reassemble the domain by filtering on a `namespace`
field. Canon could not be a folder; it would be a query. Ownership would blur
because every type folder mixes every owner. Namespace-first keeps the retrieval
boundary, the canon boundary, and the ownership boundary aligned on one folder
tree.

## Why namespace-first beats one-schema-for-all

The opposite failure is forcing every namespace into one identical folder shape. A
thinker canon and a data-pipeline namespace have almost nothing in common below the
base. One schema for all either bloats every namespace with empty folders it will
never use, or strips the schema down until it cannot describe a data pipeline or a
tool contract. Profiles solve this: one shared base for universal retrieval, plus a
profile that matches the real shape of each domain. See
[[profile-aware-knowledge-graph-design]] for the design argument in full.

## What this drives

This topology governs how `build-namespace` scaffolds a new namespace, how
`validate.sh` checks for missing base surfaces, and how every audit packet judges
whether an existing namespace is V2-compliant. It is the structural contract the
rest of the architecture assumes.

## Notes

This pillar describes structure, not the content rules. The canon contract,
profile catalog, and required-surface list each own their detail and are linked
above. Keep this node about topology so it survives changes to any single profile.
