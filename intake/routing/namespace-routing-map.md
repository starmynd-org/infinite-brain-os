# Routing: Namespace Routing Map

Maps source and content signals to likely destination namespaces. Use this after
`department-routing-map.md` has picked the owning department lane and `destination-rules.md` has
determined that the destination type is a knowledge namespace. This map narrows the candidates
inside or across lanes; it does not override the decision order. A signal suggests a namespace; the
content confirms it. The destination namespace owns the truth it accepts; this map and the intake
trail own only the routing record.

The starter ships two registered namespaces, so the table starts small. Every time you register a
namespace in `_system/namespaces/INDEX.md`, add a row here so routed intake can reach it.

## Signal to namespace table

| Content or source signal | Likely namespace | Owning lane | Notes |
|---|---|---|---|
| AI architecture takes, agent design, retrieval, harness and memory portability, knowledge-graph structure | `ai-architecture` | system stewardship | The doctrine home. Architecture posts, papers, and talks land here. |
| Operator goals, priorities, review cadence, self-management, sandbox experiments, uncategorized personal items | `personal-operator` | personal | The catch-all. Use when nothing else fits and the item is personal. |

The scaffolds under `knowledge/_examples/` never receive routed intake. They are unregistered
shape references for building new namespaces, not destinations.

## Worked example

An article arrives in `intake/sources/` arguing that knowledge-graph retrieval should be
query-class-driven rather than embedding-first. Scoring says it is worth routing. The destination
type is knowledge (a durable claim, not a task). The department map puts it in the system
stewardship lane. This table matches the knowledge-graph-structure signal to `ai-architecture`.
The item becomes a support note under `knowledge/ai-architecture/support/` with provenance, the
routing decision records the destination, and a receipt lands in `intake/processed/`.

## Source-family priors

Source family is a weak prior, not a destination. Content always confirms. Common priors:

- **web and feeds:** articles and papers. Wide spread; routed purely on content. Architecture
  signal routes to `ai-architecture`.
- **ideas:** self-generated; often a project, a synthesis note, or `personal-operator`.
- **ai-research:** synthesized briefs; route on the topic of the synthesis and preserve
  citations. Architecture research routes to `ai-architecture`.

As you register source connectors and namespaces, extend this list with the priors you actually
observe.

## Multi-candidate and new-namespace handling

When two namespaces both fit, record both as candidates in the routing decision, route to the best
fit, and note the cross-link. When the two sit in different department lanes, resolve the lane first
with `ambiguity-and-overlap-rules.md`. When an item recurs and fits no existing namespace, flag a
candidate new namespace with the proposed profile (see the eight profiles in
`_system/namespace-profiles.md` and the matching scaffold in `knowledge/_examples/`). Do not stand
up a namespace from a single item. The default for an unmatched one-off is `personal-operator` or
rejection, per `scoring-model.md`.
