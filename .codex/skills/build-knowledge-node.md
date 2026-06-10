---
id: "skill-build-knowledge-node"
aliases: ["skill-build-knowledge-node", "build-knowledge-node"]
type: "Skill"
namespace: "personal-operator"
lifecycle_state: "research"
summary: "Build knowledge-bearing nodes with correct frontmatter, namespace discipline, filename-first linking, and lifecycle posture."
confidence: 0.94
retrieval_class: "domain"
export_class: "internal"
description: "Use this skill when creating knowledge, memory, output, or data-adjacent nodes in the Infinite Brain."
edges:
  - target: "[[metric-primitive-schema]]"
    relation: "depends_on"
    confidence: 0.85
  - target: "[[canon-layer-schema]]"
    relation: "references"
    confidence: 0.82
  - target: "[[retrieval-over-raw-memory]]"
    relation: "informed_by"
    confidence: 0.85
created: "2026-05-29"
---

# build-knowledge-node

Use this skill when creating a new node under `knowledge/`, `data/`, `memory/`, or
`outputs/`. A knowledge node is atomic: one durable claim, lesson, definition, or
pointer. It is not canon. Canon is the compressed synthesis that sits over many nodes and
is built separately (see [[canonize-namespace]] and [[canon-layer-schema]]). This skill
builds the atoms; canon compresses them later.

## Use when

- durable understanding, lessons, deliverables, or data pointers are needed
- a single atomic claim, definition, decision, or metric definition belongs in a
  namespace

## Do not use when

- the item is an unresolved intake stub (route it through the root `intake/` fabric and
  [[process-namespace-intake]] first)
- the item is really a task or project anchor
- the item is a raw operational log
- the item is compressed synthesis over many nodes (that is canon; use
  [[canonize-namespace]])
- the item is derived interpretive thinking such as a contradiction map or
  best-current-reading note (that goes in `synthesis/`; see below)

## The canon-vs-node distinction

A node is atomic. Canon is synthesis. Keep the layers distinct:

- A **node** carries one durable claim and lives in a profile-additive folder
  (`pillars/`, `concepts/`, `decisions/`, `metrics/`, and similar).
- **Synthesis** is derived interpretive work over several nodes and lives in
  `synthesis/`: contradiction maps, best-current-reading notes, what-changed reviews, and
  canon-candidate packages.
- **Canon** is the compressed, operator-approved, first-principles synthesis that an
  agent loads first. It lives in `canon/` and is the heart of the namespace.

The promotion path is: raw source (archive or intake) -> support (provenance recorded) ->
synthesis (derived reading) -> canon-candidate -> canon (operator-approved). When you
write a node, you are usually working at the start of that path. Do not write canon as a
node and do not bury synthesis in `support/`. Mechanical provenance and migration
receipts go in `support/`; derived thinking goes in `synthesis/`.

## derived_from edges

When a node compresses, distills, or is built from one or more other nodes or sources,
add `derived_from` edges to the things it derives from. This makes provenance traversable
and lets canon and synthesis cite their inputs. A canon `core-doctrine.md` carries
`derived_from` edges to the pillars, concepts, decisions, and archive synthesis it
compresses; a synthesis note carries `derived_from` edges to the nodes it reconciles. Use
`derived_from` for the lineage relation and the more common relations (`supports`,
`explains`, `depends_on`, and similar) for everything else.

## The metric primitive (metric nodes)

A metric is a shared typed node, not three private definitions. It is keyed by
`metric_id` and defined once, then cross-linked. Build metric nodes per
[[metric-primitive-schema]]. A metric node adds these frontmatter fields:

- `type: "Metric"`
- `metric_id: "<stable-id>"` (id form `metric-<slug>`)
- `format: percent | currency | ratio | count | duration`
- `polarity: higher-better | lower-better | neutral`
- `aggregation: sum | avg | last | ratio-of-sums | custom`
- `expression: "<plain or SQL-ish definition>"`
- `depends_on: [<metric_id>, ...]`

A metric has three faces and one definition. The Data System namespace owns its lineage
(source, transform, model, refresh); the Operating Library namespace owns its diagnosis
(what moves it, failure modes, next actions); both reference the same `metric_id`. Add
edges from the metric node to its Data System lineage nodes and its Operating Library
diagnosis nodes. Do not redefine the same metric in two namespaces.

## lifecycle_state and retrieval_class discipline

Set both deliberately; they drive retrieval and review.

- `lifecycle_state`: `scratch` (rough, possibly wrong), `research` (validated, worth
  refining), `candidate` (nominated for canonization), `canon` (promoted), `archive`
  (superseded or preserved source). A node above `scratch` carries no placeholder text.
- `retrieval_class`: `identity` for pillar-level foundational nodes an agent should
  almost always load, `domain` for detail nodes loaded for specific queries, `ephemeral`
  for outputs and short-lived material. The retrieval consumer today is Claude Code and
  Codex file-reading agents (see [[retrieval-over-raw-memory]]); set `retrieval_class` so
  the right fragments surface for the right query, not so that everything loads.

## Build steps

1. Confirm the item is an atomic node, not canon or synthesis (see the distinction
   above). If it is intake, route it first.
2. Choose the correct folder family and the profile-additive folder within the namespace.
3. Pick a filename that works as the primary wikilink target.
4. Set the canonical `id` (`knowledge-<namespace>-<slug>`, or `metric-<slug>` for a
   metric).
5. Add `aliases:` when `id != filename`.
6. Fill required frontmatter, including `retrieval_class` and `export_class`. For a
   metric node, add the metric primitive fields.
7. Add `edges`, using `derived_from` for lineage and the standard relations otherwise.
8. Write body links to related nodes.
9. If the node materially belongs to external commercial scope, add `party_slugs` and any primary
   `client_slug` or `brand_slug`.
10. Choose the right lifecycle state.

## Quality checks

- the node is atomic, not canon or synthesis
- filename-first body links are used
- aliases cover `id` divergence
- `derived_from` edges are present when the node distills other nodes or sources
- metric nodes carry the full metric primitive frontmatter and are defined once
- `retrieval_class` matches the node's role (identity, domain, or ephemeral)
- `lifecycle_state` is deliberate and the node carries no placeholder text above scratch
- namespace usage is coherent
- the node is not duplicating live quantitative state unnecessarily
- party scope is explicit when the node materially belongs to one or more external parties

## Anti-patterns

- writing canon as a single node, or burying synthesis in `support/`
- raw data copied into markdown when a pointer is enough
- redefining the same metric in two namespaces instead of one `metric_id` cross-linked
- `edges:` present but no body links
- missing `derived_from` edges on a node that clearly distills other material
- vague lifecycle state, or placeholder text above `scratch`
- `retrieval_class: identity` on a detail node that should be `domain`
