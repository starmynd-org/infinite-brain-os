---
id: "decision-ai-architecture-required-namespace-surfaces"
aliases: ["decision-ai-architecture-required-namespace-surfaces", "required-namespace-surfaces"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Every serious namespace must carry a shared base of INDEX, canon, playbooks, support, and synthesis, with profile-additive folders on top; starter and example namespaces may reduce the base and must declare the reduction in their INDEX."
confidence: 0.93
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[namespace-profiles]]"
    relation: "depends_on"
    confidence: 0.88
  - target: "[[canon-layer]]"
    relation: "depends_on"
    confidence: 0.86
  - target: "[[namespace-profile-set-v1]]"
    relation: "aligned_with"
    confidence: 0.85
  - target: "[[infinite-brain-namespace-architecture-v2]]"
    relation: "part_of"
    confidence: 0.88
created: "2026-05-30"
---

# Required Namespace Surfaces

## Summary

Every serious namespace shares one base surface set: `INDEX.md`, `canon/`, `playbooks/`,
`support/`, and `synthesis/`. Profiles add folders on top. Starter and example namespaces
may carry a reduced base, and when they do they must say so in their `INDEX.md`.

## Decision

The shared base is required in every serious namespace regardless of profile:

- `INDEX.md`: the retrieval router and agent operating brief, not a folder list.
- `canon/`: the compressed first-principles reasoning layer the agent loads first.
- `playbooks/`: repeatable procedures for the namespace.
- `support/`: provenance and migration only, mechanical and historical.
- `synthesis/`: within-namespace derived thinking, interpretive and current.

A profile is additive. It adds folders to the shared base and never removes a base
surface or invents a competing ontology. Doctrine adds `pillars/`, `concepts/`,
`decisions/`, and `archive/` when full-source preservation matters. Data System adds
`architecture/`, `source-contracts/`, `pipelines/`, `transforms/`, `models/`, `metrics/`,
and `references/`. The full per-profile folder set lives in [[namespace-profiles]].

"Serious" means a namespace meant for real agent retrieval. Starter and example
namespaces may reduce the base:

- `personal-operator` is a starter and template; it carries no `canon/`, says so in its
  `INDEX.md`, and stays minimal.
- `knowledge/_examples/*` are reference scaffolds; each declares which base surfaces it
  carries and which it omits, so an agent reading one knows it is a scaffold and not a
  trusted namespace.

The reduction must be explicit. A missing base surface with no declaration is a defect,
not a reduction. `validate.sh` flags a serious namespace that is missing a required base
surface as an error, and the declaration in `INDEX.md` is what distinguishes an
intentional starter reduction from a gap.

## Why this is the right call

- A shared base gives every agent the same entry contract: load `INDEX.md`, then
  `canon/`, then expand into profile folders. Without it, each namespace would teach the
  agent a new retrieval shape.
- Forcing `canon/` and `synthesis/` into the base, not into profiles, keeps the
  compressed-reasoning layer and the derived-thinking layer universal. Every serious
  namespace gets a first-thing-to-load surface and a home for contested current thinking.
- Requiring `support/` separately from `synthesis/` enforces the provenance-versus-derived
  split, so migration receipts do not bleed into interpretive work.

## Rejected alternative

Let each profile define its own complete folder set with no shared base. This is simpler
to specify per profile but it produces N different retrieval contracts, breaks the
load-first discipline, and lets a Data System namespace ship with no `canon/` or no
`synthesis/`. Rejected because a uniform base is what makes cross-namespace retrieval and
review predictable.

## Status

Locked for the V2 sprint. The base-surface check lands in `validate.sh` in the same wave
this becomes doctrine, so a missing base surface is visible immediately. The reduction
declaration convention is enforced by review, not by the validator, because the validator
cannot tell an intentional starter from a gap without the declaration.

## Notes

This decision defines the base every namespace must carry and how starters may reduce it.
It does not define the per-profile additive folders (that is [[namespace-profiles]]) or
what canon means and contains (that is [[canon-layer]]).
