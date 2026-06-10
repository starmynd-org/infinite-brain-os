# Cross-Namespace Edge Rules

Operative rules for links that cross namespace boundaries: when to make them, which
relations are allowed, and how to avoid accidental coupling. This file owns the "what" and
"how to check." The "why" (one ontology spanning eight profiles, retrieval over isolated
silos) lives in the ai-architecture doctrine: [[profile-aware-knowledge-graph-design]],
[[namespace-architecture-v2]], and [[retrieval-over-raw-memory]]. This file does not
restate that reasoning.

## Principle: storage by namespace is not isolation

Namespaces organize storage. They do not partition the graph. A node in one namespace MAY
link to a node in another, and the graph is meant to be traversed across namespace
boundaries during retrieval. `knowledge/<namespace>/` is the storage unit, not a sandbox.

The mistake to avoid is the opposite one: treating each namespace as a sealed silo and
duplicating a concept into every namespace that touches it. Duplication is what storage-by-
namespace tempts and what cross-namespace edges prevent. Link to the one canonical node;
do not copy it.

## When to link across namespaces

Make a cross-namespace edge when:

- a node genuinely depends on, extends, or is grounded in a node that another namespace
  owns (for example a Content Strategy angle grounded in an `ai-architecture` decision).
- a shared primitive is owned by one namespace and referenced by others. The metric
  primitive is the canonical case: a metric is defined once and cross-linked, with the Data
  System namespace owning lineage and the Operating Library namespace owning diagnosis,
  both pointing at the same `metric_id`. See [[metric-primitive]].
- one namespace's canon reasons from another's (for example a cross-thinker reconciliation
  of two doctrine namespaces).

Do NOT make a cross-namespace edge when:

- you are tempted to copy a concept rather than link it. Link the canonical node instead.
- the link is incidental ("these are both about marketing") rather than load-bearing. A
  weak `related_to` that no retrieval path needs is graph noise.
- the relation would invert ownership. A namespace's canon does not depend on another
  namespace's `scratch` or unstable synthesis. Link only to material at `research` or
  higher in the other namespace.

## Allowed cross-namespace relations

Cross-namespace edges use the standard relation vocabulary. The relations that carry real
cross-namespace meaning:

- `derived_from`: this node compresses or builds on a node in another namespace.
- `grounded_in`: this node's claim rests on a foundational node elsewhere.
- `depends_on`: this node cannot be correct without the target node.
- `extends`: this node continues or specializes a concept owned elsewhere.
- `uses`: this node operationally consumes a primitive owned elsewhere (the metric case).
- `references`: a non-load-bearing pointer for navigation.
- `aligned_with`, `informed_by`, `reinforces`, `qualifies`: softer relations for synthesis
  and cross-thinker work.
- `related_to`: the weakest relation. Use sparingly across namespaces; prefer a specific
  relation when one fits.

Avoid `supports` and `implements` across namespaces unless the support or implementation
relationship is real and load-bearing. These read as tight structural coupling and should
not be used for incidental association.

- Enforced by `validate.sh` (deterministic): every `edges.target` resolves to a real node,
  cross-namespace included. A broken cross-namespace `[[wikilink]]` fails the build.
- Whether a chosen relation is the right one and whether the link is load-bearing versus
  noise is a curator check (fuzzy), surfaced by the namespace linter.

## Avoiding accidental coupling

Accidental coupling is when a namespace cannot be reasoned about without silently pulling
in another namespace's unstable state. Rules to prevent it:

- Link to stable targets. Cross-namespace edges point at `canon`, `research`, or
  `candidate` nodes in the target namespace, not at `scratch` or volatile synthesis.
- Depend downward toward shared primitives, not sideways into another namespace's internals.
  A metric, a doctrine pillar, a decision: these are stable shared anchors. Another
  namespace's in-progress synthesis is not.
- One owner per claim. A claim is owned by exactly one namespace. Other namespaces link to
  it; they do not restate or fork it. Forking creates two drifting copies.
- Do not chain canon through volatile state. A `canon/core-doctrine.md` node may
  `derived_from` another namespace's canon or stable pillar, never that namespace's
  `intake/` or `scratch` material.

## The metric primitive as the reference pattern

The metric primitive is the worked example of a correct cross-namespace edge. A metric node
is keyed by `metric_id` and defined once. The Data System namespace owns its lineage
(source, transform, model, refresh). The Operating Library namespace owns its diagnosis
(what moves it, failure modes, next actions). Both reference the same `metric_id` via `uses`
edges. Neither copies the definition. This is storage-by-namespace done right: one node,
many cross-namespace consumers, zero duplication. Full schema in
[[metric-primitive-schema]]; doctrine in [[metric-primitive]].

## Checklist before adding a cross-namespace edge

- the link is load-bearing, not incidental.
- you are linking the canonical node, not copying it.
- the relation is the most specific one that fits (avoid bare `related_to`).
- the target is at `research`, `candidate`, or `canon` in its namespace, not `scratch`.
- the edge does not invert ownership (canon does not depend on another namespace's unstable
  state).
- the target `[[wikilink]]` resolves.

## Related operative rules

- [[metric-primitive-schema]]: the shared typed node that the cross-namespace edge pattern
  is built around.
- [[stable-id-and-alias-rules]]: cross-namespace links target ids, which survive moves.
- [[namespace-lint-rules]]: orphan and broken-edge detection that catches bad
  cross-namespace edges.
