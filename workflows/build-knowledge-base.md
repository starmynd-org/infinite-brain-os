---
id: "workflow-build-knowledge-base"
aliases: ["workflow-build-knowledge-base", "build-knowledge-base"]
type: "Workflow"
namespace: "personal-operator"
lifecycle_state: "research"
summary: "End-to-end workflow for building a new knowledge namespace from a real source corpus using the V2 namespace system."
confidence: 0.9
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[skill-build-knowledge-base]]"
    relation: "uses"
    confidence: 0.95
  - target: "[[skill-build-namespace]]"
    relation: "uses"
    confidence: 0.92
  - target: "[[skill-migrate-legacy-knowledge-to-v2]]"
    relation: "uses"
    confidence: 0.9
  - target: "[[skill-canonize-namespace]]"
    relation: "uses"
    confidence: 0.9
  - target: "[[skill-refine-namespace-index]]"
    relation: "uses"
    confidence: 0.88
  - target: "[[workflow-namespace-lint-review]]"
    relation: "references"
    confidence: 0.84
  - target: "[[workflow-legacy-knowledge-migration]]"
    relation: "related_to"
    confidence: 0.82
created: "2026-05-31"
runtime: "agentic"
---

# Workflow: Build Knowledge Base

This workflow builds a new real namespace from a real source corpus. It is the standard
path behind `/build-knowledge-base`: interpret the operator's plain-English request,
choose the profile, scaffold the namespace, atomize and refactor the source material into
agent-usable nodes, author canon and synthesis, refine the `INDEX.md` router, review
cross-namespace implications, then prove the result with the validator and lint review.

It is broader than [[workflow-legacy-knowledge-migration]] because it covers born-V2
namespace creation and plain-English operator requests, not only queued namespace
upgrades from audit packets.

## When to run

- when the operator wants a new real namespace, not a stub
- when a legacy folder or corpus should be converted into Infinite Brain style
- when the current OS architecture should be tested on a live source set

## Inputs

- the operator's natural-language request
- the source corpus or folder
- the target repo, usually `infinite-brain-os`
- the operative rules in `_system/`
- the doctrine in `knowledge/ai-architecture/`

## Pipeline

### Step 1: Parse the operator request

Apply [[skill-build-knowledge-base]] to extract:

- target namespace slug
- source location
- namespace purpose
- exclusions or non-goals
- canon expectations
- live-truth or sensitivity concerns
- any material external-party scope

If one missing detail would materially alter the build, ask for that detail. Otherwise
infer reasonably and record the assumption.

### Step 2: Choose the profile and boundary

Use [[skill-build-namespace]] plus [[namespace-profiles]] and
[[problem-to-architecture]] to decide:

- the primary profile
- what belongs in the namespace
- what stays out
- what should be archived, synthesized, canonicalized, or left as support-only
- whether `party_slugs`, `client_slug`, or `brand_slug` should be declared

If the profile is `data-system`, decide whether the namespace is full-lineage or
starter-thin. Starter-thin still requires real metrics and source contracts; it may point
implementation at your data-platform CLI or a client-managed adapter instead of documenting a bespoke
warehouse stack in full depth.

### Step 3: Scaffold the namespace

Use [[skill-build-namespace]] to create:

- the registry entry under `_system/namespaces/`
- the shared base surfaces
- the profile-additive folders
- the initial `INDEX.md`
- any needed party-scope metadata

If the namespace already partially exists, treat this as an additive build, not a reset.

### Step 4: Refactor the source corpus

Apply [[skill-migrate-legacy-knowledge-to-v2]] where migration logic is needed. Preserve
provenance. Keep the support versus synthesis versus canon distinction sharp. Honor any
operator exclusions even when expressed informally.

Atomize source material into digestible, scoped nodes rather than carrying forward
oversized notes or coarse summaries. Prefer small units a future agent can ingest,
compose, and cite. When a source idea is too broad for one node, split it into the
minimum useful set of nodes with preserved provenance and explicit linkage.

### Step 5: Build canon and synthesis

Apply [[skill-canonize-namespace]] to write the compressed first-principles canon. Seed
or build `synthesis/` for derived interpretation, contradiction maps, or best-current
readings. Keep unresolved material out of canon.

The target shape is layered:

- atomized nodes as the base knowledge surfaces
- `INDEX.md` as the retrieval router over those surfaces
- `synthesis/` as the interpretation layer over the nodes
- `canon/` as the compressed "what future agents should ingest first" layer over the
  namespace's main ideas

Canon should name the governing ideas future agents should load first to understand the
namespace quickly, not merely restate folder contents.

### Step 6: Refine the retrieval router

Apply [[skill-refine-namespace-index]] so `INDEX.md` becomes a real agent router with
load-first, query classes, stable versus stateful, common misreadings, and map sections.

### Step 7: Review cross-namespace implications

Before closeout, inspect whether this build changes the shape of adjacent namespaces or
shared doctrine. Check for:

- new nodes that belong in another namespace instead of the target namespace
- cross-synthesis opportunities between the target namespace and existing namespaces
- canon adjustments needed elsewhere because the new namespace changes the best-current
  understanding
- index or routing adjustments in related namespaces so agents can find the new material

If a neighboring namespace should gain a node, synthesis note, cross-synthesis note, or
canon adjustment, make that additive change or record the exact follow-up in the build
report. Do not assume namespace boundaries eliminate cross-namespace maintenance.

### Step 8: Prove the result

Run `bash _system/validate.sh`. Then run the lint pass via the logic in
[[workflow-namespace-lint-review]]. Fix structural issues before closeout.

### Step 9: Write the build report

Save a short output at:

`outputs/build-knowledge-base-{namespace}-{date}.md`

with:

- profile chosen and why
- external-party scope and why
- source set and exclusions
- canon surfaces created
- synthesis surfaces created
- atomization choices and major node splits
- support and archive choices
- cross-namespace changes made
- cross-namespace follow-ups still needed
- validator/lint result
- open questions
- lessons about the OS itself

## Output format

A single Output node at `outputs/build-knowledge-base-{namespace}-{date}.md` with a
succinct execution record. This is a point-in-time artifact, not canon.

## Notes

- This workflow is the preferred standard path for future real namespace births from
  legacy corpora.
- `/create-namespace` remains the lightweight stub path; `/build-knowledge-base` is the
  real build path.
- If repeated friction appears during real runs, improve this workflow and the paired
  skill rather than re-expanding operator prompts indefinitely.
