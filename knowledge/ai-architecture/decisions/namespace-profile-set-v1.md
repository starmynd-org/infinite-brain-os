---
id: "decision-ai-architecture-namespace-profile-set-v1"
aliases: ["decision-ai-architecture-namespace-profile-set-v1", "namespace-profile-set-v1"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Adopt all eight namespace profiles now under the operator breadth directive, tagging Doctrine and Intake Fabric as Stable and the other six as Provisional, with Provisional schemas validated against the first real namespace of that type."
confidence: 0.93
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[namespace-profiles]]"
    relation: "implements"
    confidence: 0.9
  - target: "[[required-namespace-surfaces]]"
    relation: "depends_on"
    confidence: 0.85
  - target: "[[infinite-brain-namespace-architecture-v2]]"
    relation: "part_of"
    confidence: 0.88
  - target: "[[profile-aware-knowledge-graph-design]]"
    relation: "aligned_with"
    confidence: 0.84
created: "2026-05-30"
---

# Namespace Profile Set V1

## Summary

Define all eight namespace profiles now rather than demand-pulling schemas after two or
three reference namespaces exist. Tag Doctrine and Intake Fabric as Stable and the other
six as Provisional. A Provisional profile is not trusted until its schema is validated
against the first real namespace of that type.

## Decision

Adopt the V1 profile set as the single ontology for the knowledge graph. One ontology,
eight profiles, shared canon and review rules. Each profile adds folders to the shared
base; no profile replaces the base or forks the ontology.

Maturity tags:

- **Stable**: at least one real namespace exists and the schema is trusted. Doctrine is
  Stable because `ai-architecture`, `ooda-john-boyd`, `david-deutsch`, `garytan`, and
  `example-marketing` already prove it. Intake Fabric is Stable as a root layer because
  small connector apps and ingestion scripts prove the
  capture-and-route pattern in production, even though no `knowledge/` namespace carries
  it.
- **Provisional**: the schema is defined from analysis, not from a live namespace. Tool
  Contract, Data System, Design System, Component Library, Content Strategy, and
  Operating Library are Provisional. Each carries an explicit "validate on first real
  namespace" note and ships as a reference scaffold in `knowledge/_examples/`.

The validation rule for Provisional profiles: when the first real namespace of a
Provisional type is built, the operator checks the analysis-derived folder set against
what the real content needs, corrects the schema in `_system/namespace-profiles.md`, and
promotes the tag to Stable. The scaffold in `knowledge/_examples/` is the second and
third reference implementation the adversarial reviews asked for, so the Provisional tag
is a falsifiable claim, not a permanent caveat.

## Why this is the right call

- The operator confirmed namespace expansion is imminent. Breadth ahead of expansion
  lets new namespaces start V2-aligned by default instead of being retrofitted.
- The Stable versus Provisional split is honest about confidence. It tells a future
  agent which schemas to trust and which to treat as candidates.
- Defining the full set now forces the shared-base and additive-profile discipline to
  hold across types, which surfaces ontology collisions early. The watch-items note
  (Design System and Component Library share artifact DNA; Tool Contract, Data System,
  and Operating Library share contract-plus-diagnostics DNA) came out of defining all
  eight together.

## Rejected alternative

Adversarial demand-pull: define only Doctrine now, build two or three real namespaces,
then extract the remaining profiles from observed need. This is the conservative path
and it reduces the risk of shipping a wrong schema.

It was overridden by operator direction. Demand-pull is slower than imminent expansion
allows: it would force the next several namespaces to be built without a profile, then
re-typed once a profile is extracted, which is the retrofit cost breadth avoids. The
Provisional tag plus the `knowledge/_examples/` scaffolds capture most of the
demand-pull safety (real reference implementations, explicit validation gate) without
blocking expansion on them.

## Status

Locked for the V2 sprint. The operative profile registry lives in
`_system/namespace-profiles.md`; the reasoning lives in [[namespace-profiles]]. Promotion
of any Provisional profile to Stable happens at the first real namespace of that type and
is recorded in the registry, not here.

## Notes

This decision governs which profiles exist and their trust level. It does not define the
folder schema per profile (that is [[namespace-profiles]]) or the shared base every
namespace must carry (that is [[required-namespace-surfaces]]).
