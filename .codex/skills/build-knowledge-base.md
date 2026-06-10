---
id: "skill-build-knowledge-base"
aliases: ["skill-build-knowledge-base", "build-knowledge-base"]
type: "Skill"
namespace: "personal-operator"
lifecycle_state: "research"
summary: "Turn a real source corpus into a new Infinite Brain knowledge namespace using plain-English operator instructions and the V2 namespace machinery."
confidence: 0.93
retrieval_class: "domain"
export_class: "internal"
description: "Use this skill when an operator wants to build or migrate a real knowledge base into Infinite Brain V2 shape, describing the source and constraints in normal English rather than rigid flags."
edges:
  - target: "[[skill-build-namespace]]"
    relation: "uses"
    confidence: 0.95
  - target: "[[skill-migrate-legacy-knowledge-to-v2]]"
    relation: "uses"
    confidence: 0.93
  - target: "[[skill-canonize-namespace]]"
    relation: "uses"
    confidence: 0.92
  - target: "[[skill-refine-namespace-index]]"
    relation: "uses"
    confidence: 0.9
  - target: "[[skill-lint-namespace]]"
    relation: "uses"
    confidence: 0.86
  - target: "[[workflow-build-knowledge-base]]"
    relation: "paired_with"
    confidence: 0.9
  - target: "[[problem-to-architecture]]"
    relation: "informed_by"
    confidence: 0.88
  - target: "[[namespace-profiles]]"
    relation: "depends_on"
    confidence: 0.9
  - target: "[[canon-layer-schema]]"
    relation: "depends_on"
    confidence: 0.86
created: "2026-05-31"
---

# build-knowledge-base

Use this skill when the operator wants a real source corpus turned into a real Infinite
Brain namespace.

This is the plain-English front door for namespace construction. The operator says what
the source is, what the namespace should be called, what it is for, and any important
constraints. This skill extracts the architectural meaning from that request, chooses the
profile, and routes the work through the existing V2 machinery instead of bypassing it.
It also ensures the corpus is atomized into agent-usable nodes, layered into synthesis
and canon, and checked for cross-namespace implications so the operator does not need to
repeat those expectations in every prompt.

## Use when

- a new namespace should be built from an existing folder, legacy PKM, notes tree, or
  source corpus
- the operator wants a natural-language request like "build `personal-health` from this
  folder, but leave the legacy database alone"
- the work should serve as a real test of the current namespace architecture, skills,
  agents, workflows, and validator
- provenance, canon quality, and retrieval quality matter more than speed

## Do not use when

- the operator only wants a lightweight namespace registry stub; use
  [[skill-build-namespace]] or `/create-namespace`
- the material is still unprocessed intake and should remain in root `intake/`
- the request is only to add or revise nodes in an existing namespace
- the dominant need is a live runtime store, secrets store, or application database

## Goal

Produce a V2-compliant namespace that is actually useful for future agents:

- the right profile is chosen from first principles
- the source corpus is atomized into digestible, composable nodes
- the right material becomes canon, synthesis, support, or archive
- the namespace `INDEX.md` acts as a real retrieval router
- canon states the main ideas future agents should ingest first
- related namespaces are reviewed for additive node, synthesis, canon, or router changes
- provenance is preserved
- the validator and lint pass are run before closeout
- the run leaves behind a build report that explains what was decided

## Required outputs

1. a decision on namespace profile and why
2. a built namespace under `knowledge/<namespace>/` unless the best fit is
   `intake-fabric`
3. a registry entry under `_system/namespaces/<namespace>.md`
4. canon, synthesis, support, playbooks, and profile-additive folders as justified by
   the chosen profile
5. a migration or build receipt in `support/`
6. a V2 `INDEX.md` retrieval router
7. any needed cross-namespace additive changes, or an explicit follow-up list if they
   should not be made in the same wave
8. a validator-clean result plus lint review
9. a short build report in `outputs/`

## How to work

### 1. Read the operator request as architecture input

Extract the following from plain English:

- source location or source set
- target namespace slug
- intended use cases
- exclusions or non-goals
- quality bar for canon
- freshness risk or live-truth concerns

Do not force the operator into flags when the request is already clear.

### 2. Decide whether this is a born-V2 build or a migration-heavy build

- If the namespace does not exist yet and the source corpus is external, route through
  [[skill-build-namespace]] first, then use migration logic to populate it.
- If the namespace already exists but is underbuilt, route through
  [[skill-migrate-legacy-knowledge-to-v2]].

### 3. Choose the profile from first principles

Use [[namespace-profiles]] and [[problem-to-architecture]] to decide the primary job of
the namespace. Explain the choice briefly in the build report. Resist hybrid sprawl: pick
one primary profile and use the allowed additive surfaces.

### 4. Classify the source material

Sort the corpus into:

- canon-worthy stable doctrine
- synthesis-worthy interpretation
- support-worthy provenance or migration receipts
- archive-worthy preserved raw source
- out-of-scope material that should not be migrated

If the operator named exclusions in prose, honor them.

For a `data-system` namespace request, also decide whether the right build is:

- a full lineage namespace with pipelines, transforms, and models documented in depth
- a starter-thin semantic namespace whose implementation path is your data-platform CLI
- a starter-thin semantic namespace whose implementation path is client-managed

Prefer the thinner correct build when the operator's real goal is shared metric semantics,
not bespoke data engineering.

### 5. Atomize before summarizing

Break broad source material into digestible nodes future agents can load selectively.
Prefer:

- one idea, claim, mechanism, or decision per node when possible
- explicit links between sibling nodes that together form a larger model
- provenance on every node that came from migration or compression work

Do not jump straight from a large source corpus to only a few summaries. Build the node
layer first, then build synthesis and canon over it.

### 6. Build through the existing V2 machinery

Use:

- [[skill-build-namespace]] for structural scaffold and registry posture
- [[skill-migrate-legacy-knowledge-to-v2]] for additive migration logic where applicable
- [[skill-canonize-namespace]] for compressed canon
- [[skill-refine-namespace-index]] for the retrieval router
- [[skill-lint-namespace]] plus `bash _system/validate.sh` for structural proof

Do not bypass these with ad hoc folder creation or copy-paste migration.

### 7. Review cross-namespace implications

Inspect nearby namespaces and shared doctrine for additive changes triggered by this
build. Check whether:

- an idea belongs partly or wholly in another namespace
- a cross-synthesis note should connect this namespace to another one
- a related namespace's canon or synthesis is now incomplete or misleading
- a related namespace's `INDEX.md` should route to this new work

Make the additive change when it is clearly in scope. Otherwise record the exact follow-up
in the build report so it is not lost.

### 8. Document what happened

Create a short build report with:

- source set used
- profile chosen
- major folder and node surfaces created
- major atomization choices
- canon expectations satisfied
- exclusions honored
- cross-namespace changes made or deferred
- open ambiguities
- validator/lint result
- what parts of the current OS felt strong or awkward

## Quality checks

- the namespace job and profile match
- source material was atomized rather than flattened into a few coarse notes
- canon is compressed reasoning, not vague summary
- canon identifies the main ideas future agents should ingest first
- synthesis holds unresolved or interpretive material rather than canon
- support preserves provenance and migration logic
- archive is used only when source preservation matters
- exclusions from the operator request were honored
- related namespaces were checked for additive impacts
- `INDEX.md` is a real retrieval router, not a folder list
- `bash _system/validate.sh` passes

## Anti-patterns

- making the command-friendly front door but skipping the actual V2 skills underneath
- flattening the source corpus into a few summaries with no provenance trail
- skipping the node layer and trying to let canon do all the compression work
- treating every source artifact as canon
- assuming a namespace build cannot require additive changes in other namespaces
- ignoring clear exclusions because they were expressed in prose instead of flags
- choosing a profile by folder familiarity instead of by the namespace's real job
