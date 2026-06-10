---
id: "skill-build-profile-example-namespace"
aliases: ["skill-build-profile-example-namespace", "build-profile-example-namespace"]
type: "Skill"
namespace: "personal-operator"
lifecycle_state: "research"
summary: "Scaffold a profile example namespace under knowledge/_examples/ that proves one profile's folder shape and lint emphasis as a reference implementation."
confidence: 0.88
retrieval_class: "domain"
export_class: "internal"
description: "Use this skill to build a small reference namespace under knowledge/_examples/ that demonstrates a single profile's shape, so a provisional profile is validated before a real namespace adopts it."
edges:
  - target: "[[namespace-profiles]]"
    relation: "depends_on"
    confidence: 0.92
  - target: "[[profile-lint-rules]]"
    relation: "governed_by"
    confidence: 0.88
  - target: "[[canon-layer-schema]]"
    relation: "depends_on"
    confidence: 0.85
  - target: "[[namespace-index-schema]]"
    relation: "depends_on"
    confidence: 0.85
  - target: "[[metric-primitive-schema]]"
    relation: "informed_by"
    confidence: 0.7
  - target: "[[skill-build-namespace]]"
    relation: "paired_with"
    confidence: 0.85
  - target: "[[skill-migrate-legacy-knowledge-to-v2]]"
    relation: "related_to"
    confidence: 0.65
  - target: "[[rule-voice-and-style]]"
    relation: "governed_by"
    confidence: 0.8
created: "2026-05-30"
---

# build-profile-example-namespace

Build a small reference namespace under `knowledge/_examples/` that proves one profile's
shape. The eight profiles are defined now ahead of expansion (operator override O2), and
the provisional ones must be validated against a concrete instance before a real namespace
adopts them. An example namespace is that concrete instance: it doubles as the second and
third reference implementation the reviews asked for. The profile schemas live in
[[namespace-profiles]]; the per-profile lint emphasis lives in [[profile-lint-rules]].

## Use when

- a profile (especially a Provisional one) needs a concrete reference before a real
  namespace adopts it
- the build wave seeds one example namespace per profile in `knowledge/_examples/`
- a profile schema changed and the example must be updated to match
- a new builder needs a worked instance of a profile to copy from

## Do not use when

- you are building a real working namespace (use [[skill-build-namespace]]; real
  namespaces do not live under `knowledge/_examples/`)
- you are upgrading an existing namespace (use [[skill-migrate-legacy-knowledge-to-v2]])
- no profile is in question and the work is ordinary node authoring

## Goal

Produce a minimal but honest example namespace under `knowledge/_examples/<profile>-example/`
that carries the shared base plus that profile's additive folders, a thin disciplined
canon, a V2 `INDEX.md` that declares it is an example with a reduced base, and at least one
real node per profile-specific folder, so the profile's shape and lint emphasis are
demonstrated rather than asserted.

## Required outputs

1. An example namespace directory at `knowledge/_examples/<profile>-example/` carrying the
   shared base (`INDEX.md`, `canon/`, `playbooks/`, `support/`, `synthesis/`) plus the
   additive folders that profile defines in [[namespace-profiles]].
2. A V2 `INDEX.md` following [[namespace-index-schema]] that states in its `## Profile`
   section that this is a profile example with a reduced, demonstrative base.
3. At least one substantive node in each profile-specific folder showing the lint emphasis
   that profile is checked on ([[profile-lint-rules]]). For Data System and Operating
   Library examples, include a metric node using [[metric-primitive-schema]].
4. A thin `canon/core-doctrine.md` demonstrating canon shape without pretending to settled
   depth.

## Build steps

1. Pick the profile and read its schema in [[namespace-profiles]]: the additive folders
   and the lint emphasis it is judged on.
2. Create `knowledge/_examples/<profile>-example/` with the shared base folders plus the
   profile's additive folders.
3. Write a V2 `INDEX.md` that declares the example status and reduced base, names the
   profile and why, and maps the folders.
4. Write a thin `canon/core-doctrine.md` (full node frontmatter, `derived_from` edges to
   the example's own nodes, `verified_at`, `verified_by`, `## Changelog`) plus
   `canon/README.md` and `canon/agent-load-order.md` as navigational files.
5. Populate each profile-specific folder with at least one real node that exercises the
   profile's lint emphasis. For a Tool Contract example, include a payload example and a
   canon `core-contract.md`. For a Data System example, include a metric with source
   lineage plus the starter implementation posture (`live`, `manual`, or `not-wired`) and
   at least one playbook for a managed pull path or bring-your-own-data mapping. For an
   Operating Library example, include an SOP with a trigger and a
   diagnostic with a next action.
6. Register the example if the convention requires it, marking it clearly as an example so
   it is excluded from the real namespace set (assumption A-02: `knowledge/_examples/` is
   the example home).
7. Run `bash _system/validate.sh` and clear any profile folder or structural warnings.

## Quality checks

- the example lives under `knowledge/_examples/` and its `INDEX.md` declares it is an
  example with a reduced base
- every additive folder the profile defines has at least one real node, not an empty
  directory
- the profile's lint emphasis is actually demonstrated (a metric has lineage, a tool node
  has a payload example, an SOP has a trigger)
- canon is thin and honest, not padded to look settled
- nodes carry valid frontmatter and resolving edges (`bash _system/validate.sh` clean)
- the example is excluded from the real namespace set

## Anti-patterns

- shipping empty profile folders that prove nothing
- building the example so heavy it reads like a real namespace and gets mistaken for one
- skipping the lint-emphasis node, so the example does not actually validate the profile
- placing the example outside `knowledge/_examples/` where it pollutes the real namespace
  set
- inflating the example canon to fake settled depth
