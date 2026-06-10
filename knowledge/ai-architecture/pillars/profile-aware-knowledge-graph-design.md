---
id: "knowledge-ai-architecture-profile-aware-knowledge-graph-design"
aliases: ["knowledge-ai-architecture-profile-aware-knowledge-graph-design", "ai-architecture-profile-aware-design", "profile-aware-knowledge-graph-design"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "One ontology, several profiles, shared canon and review rules: why profiles beat both one-shape-for-all and a snowflake schema per namespace."
confidence: 0.93
retrieval_class: "identity"
export_class: "internal"
edges:
  - target: "[[namespace-profiles]]"
    relation: "depends_on"
    confidence: 0.93
  - target: "[[namespace-profile-set-v1]]"
    relation: "implements"
    confidence: 0.91
  - target: "[[infinite-brain-namespace-architecture-v2]]"
    relation: "supports"
    confidence: 0.92
created: "2026-05-30"
---

## Summary

The Infinite Brain uses one ontology and several profiles. A profile is a named folder
set for one kind of namespace, layered on a shared base, governed by shared canon and
shared review rules. This pillar argues why a profile model is the right middle path
between two failures: forcing every namespace into one identical shape, and letting
each namespace invent its own shape from scratch.

## One ontology, several profiles

There is one ontology across the whole graph. Node types, frontmatter schema, edge
relations, lifecycle states, and the canon contract are the same in every namespace.
A profile does not change the ontology. It declares which folders a given kind of
namespace carries on top of the shared base. A doctrine namespace carries `pillars/`,
`concepts/`, and `decisions/`. A Data System namespace carries `pipelines/`,
`transforms/`, `models/`, and `metrics/`. Both speak the same node and edge language;
they differ only in folder shape. The profile catalog and the additive rule live in
[[namespace-profiles]]; the eight profiles chosen for V1 are recorded in
[[namespace-profile-set-v1]].

## Shared canon and shared review rules

Every profile shares the canon contract and the review machinery. Canon means the same
thing in a Tool Contract namespace as in a thinker canon: compressed, operator-approved,
provenance-bearing first-principles synthesis, loaded first, small relative to the
graph. Freshness review, contradiction review, link validation, and orphan detection
run the same way everywhere, with cadence scoped by how fast a namespace's state
decays rather than by its profile alone. Profiles differ in what they emphasize at lint
time. A Data System namespace lints that every metric has source lineage; a Design
System namespace lints that every component maps to a token. The checks differ; the
contract and the review discipline do not.

## Why profiles beat one-shape-for-all

A single folder shape applied to every namespace fails in one of two ways. If the
shape is rich enough for a data pipeline, then a thinker canon carries empty
`pipelines/`, `transforms/`, and `metrics/` folders that signal structure it does not
have, and an agent wastes retrieval steps confirming they are empty. If the shape is
trimmed down enough for a thinker canon, then it cannot express source lineage,
refresh logic, or metric definitions, so the data namespace either smuggles that
structure into mislabeled folders or loses it. One shape cannot fit a domain of
durable concepts and a domain of source-to-dashboard data flow at the same time.
Profiles let each domain carry exactly the folders its work needs.

## Why profiles beat a snowflake per namespace

The opposite temptation is to let every namespace invent its own folder layout to fit
its quirks. That produces a graph where no two namespaces look alike, where a
retrieving agent must learn each namespace from scratch, where `build-namespace` has
no template, and where `validate.sh` cannot make structural assertions because there
is no expected shape to check against. Snowflakes destroy the shared-base promise that
lets an agent enter a namespace it has never seen. A small fixed set of profiles keeps
variety bounded: a finite catalog the tooling can scaffold, the validator can check,
and an agent can learn once and reuse.

## Profiles are declared, not inferred

A namespace declares its profile in the `_system` registry entry and surfaces it in its
`INDEX.md`. Declaration matters: it lets the validator pick the right profile-aware
checks, lets a retrieving agent know what folders to expect, and lets the builder
scaffold correctly. An undeclared or wrong profile makes a namespace illegible to the
tooling even if its content is good.

## Profiles carry maturity tags

A profile is tagged Stable or Provisional. Stable means at least one real namespace
exists and the schema is trusted. Provisional means the schema was defined from
analysis and must be validated against the first real namespace of that type before it
is trusted. Provisional profiles ship as reference scaffolds in `knowledge/_examples/`
so the second and third reference implementations exist before the schema is relied
on. This keeps the breadth of a full profile set honest about which shapes are proven
and which are still candidates.

## What this drives

Profile-aware design is the reason `build-namespace` asks which profile fits before it
scaffolds, the reason the registry carries a `profile` field, and the reason the
validator runs different folder checks per profile. It is the structural half of the
V2 architecture; [[infinite-brain-namespace-architecture-v2]] holds the topology, and
this pillar holds the rationale for varying shape without varying ontology.

## Notes

Keep this pillar about the design principle. The concrete folder lists for each
profile belong to [[namespace-profiles]] and the chosen V1 set belongs to
[[namespace-profile-set-v1]]. If a profile's folders change, this node should not need
to change.
