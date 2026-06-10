---
id: "skill-refine-namespace-index"
aliases: ["skill-refine-namespace-index", "refine-namespace-index"]
type: "Skill"
namespace: "personal-operator"
lifecycle_state: "research"
summary: "Turn a thin or folder-listing INDEX.md into the ten-section retrieval router required by the namespace index schema."
confidence: 0.9
retrieval_class: "domain"
export_class: "internal"
description: "Use this skill when a namespace INDEX.md is a stub, a folder list, or missing the ten required sections, and an agent needs it to function as a real retrieval router."
edges:
  - target: "[[namespace-index-schema]]"
    relation: "implements"
    confidence: 0.95
  - target: "[[namespace-profiles]]"
    relation: "depends_on"
    confidence: 0.9
  - target: "[[output-linkage-review-rules]]"
    relation: "depends_on"
    confidence: 0.85
  - target: "[[public-llm-index-policy]]"
    relation: "references"
    confidence: 0.8
  - target: "[[canonize-a-namespace]]"
    relation: "informed_by"
    confidence: 0.85
  - target: "[[skill-canonize-namespace]]"
    relation: "paired_with"
    confidence: 0.85
  - target: "[[skill-lint-namespace]]"
    relation: "paired_with"
    confidence: 0.85
  - target: "[[rule-voice-and-style]]"
    relation: "governed_by"
    confidence: 0.8
created: "2026-05-30"
---

# refine-namespace-index

Use this skill to convert a thin `INDEX.md` (a stub, a one-paragraph note, or a bare
folder list) into the ten-section retrieval router defined in [[namespace-index-schema]].
The INDEX.md is the agent operating brief: it is the first file a retrieving agent reads
to decide what to load. A folder list is not a router. The operative section contract is
in [[namespace-index-schema]]; the reason it matters is in [[intake-fabric-namespace]]
and the retrieval doctrine in [[canon-layer]].

## Use when

- a namespace `INDEX.md` is a stub, a single paragraph, or only a folder map
- the INDEX.md is missing one or more of the ten required sections, or they are out of order
- a namespace just gained `canon/` or `synthesis/` and the router does not point to them
- an agent reports it could not tell what to load first for a namespace

## Do not use when

- the namespace has no canon and no real nodes yet; build the nodes first via
  [[skill-build-namespace]]
- the file is already a compliant ten-section router and only node content changed; a
  node edit does not require a router rewrite
- the namespace is a starter or example with a deliberately reduced base; refine to the
  reduced shape it declares, do not force full sections that do not apply

## Goal

Produce an `INDEX.md` that lets a cold-context agent answer "what do I load for this
query" in one read, with the ten sections present and in order, canon as the declared
load-first entry point, and real query classes mapped to real files.

## Required outputs

1. the rewritten `knowledge/<namespace>/INDEX.md` with all ten sections in order
2. a `## Profile` line that matches the `profile:` in `_system/namespaces/<ns>.md`
3. a `## Load first` section naming canon entry points plus the top three to five files
4. a `## Query classes` section mapping each common query to its load set
5. a short note of any gap found (missing canon, orphan folder, dead link) routed to
   [[skill-lint-namespace]]

## Build steps

1. Read the current `INDEX.md` and the namespace folder tree. Read the registry entry at
   `_system/namespaces/<ns>.md` for `profile`, `canon_posture`, `freshness_posture`, and
   `expected_folders`.
2. Write the ten sections in this exact order per [[namespace-index-schema]]: title plus
   one-paragraph purpose; `## Profile`; `## Load first`; `## Query classes`; `## Stable
   vs stateful`; `## Open disputes`; `## What this namespace drives`; `## Archive and
   provenance`; `## Common misreadings`; `## Map`.
3. For `## Load first`, point at `canon/agent-load-order.md` and `canon/core-doctrine.md`
   first when canon exists, then the three to five highest-value nodes with a one-line
   reason each.
4. For `## Query classes`, derive the real query types this namespace answers and list
   the files an agent loads for each. Cross-check against any eval set at
   `support/retrieval-eval.md`.
5. For `## What this namespace drives`, record the outputs, projects, or decisions this
   canon should improve, per [[output-linkage-review-rules]].
6. For `## Open disputes`, point at the contradiction maps and best-current-reading
   notes in `synthesis/`, not into canon.
7. Leave `## Map` last as the folder reference. Do not lead with it.

## Quality checks

- all ten sections present and in the order [[namespace-index-schema]] specifies
- `## Profile` matches the registry `profile:` exactly
- `## Load first` names canon when `canon_posture` is full or thin
- every file referenced in `## Query classes` and `## Load first` resolves
- `## What this namespace drives` is non-empty for serious namespaces (G7 reader-named)
- INDEX.md stays rich markdown without node frontmatter (the validator exempts it)
- no em dashes, no en dashes

## Anti-patterns

- shipping a folder list and calling it a router
- omitting `## Query classes` because "the agent can figure it out"
- pointing `## Load first` at raw archive instead of canon
- duplicating canon prose into the INDEX.md instead of linking to it
- inventing query classes that no real agent or output asks for
