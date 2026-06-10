# Routing: Destination Rules

How to decide where a captured intake item goes. This is the canonical decision doctrine
for the intake fabric. It is small on purpose. Use it with the rest of the routing set:

- `scoring-model.md`: whether an item is worth routing at all.
- `department-routing-map.md`: which department lane owns a worth-routing item.
- `namespace-routing-map.md`: which namespace inside or across lanes it belongs to.
- `ambiguity-and-overlap-rules.md`: how to break a tie when two lanes both fit.
- `residue-and-review-posture.md`: what happens after routing, and when a route is closed.

The output of applying these rules is a routing decision shaped by
`../schemas/routing-decision.md`: candidate destinations, score, chosen destination,
rationale, and operator approval state.

## The five destination types

Every item resolves to exactly one of five destinations.

- **Knowledge namespace.** The item carries durable understanding: a concept, principle,
  decision, doctrine, or reusable pattern. It becomes a node in `knowledge/<ns>/` or feeds
  an existing node. This is the default for high-relevance, high-novelty items.
- **Project.** The item is scoped, has an owner-intent, and moves a specific outcome
  forward. It becomes a task or note in `projects/<project>/PLAN.md`.
- **Workflow.** The item is an input to a recurring pipeline (for example a research item
  that belongs in the next newsletter prep, or a source for a content angle). It is handed
  to the workflow rather than stored as standalone knowledge.
- **Action queue.** The item demands a near-term action that is not a durable project: a
  reply, a follow-up, a decision to make this week. It goes to the operational action
  layer, not to git as knowledge.
- **Rejection.** The item is noise, a duplicate of existing canon, or below threshold. It
  is recorded as rejected with a one-line reason, then dropped. Rejection is a first-class
  outcome, not a failure.

## Decision order

Apply these in order. The first match wins.

1. **Below threshold?** If the scoring model returns reject (see `scoring-model.md`), the
   destination is rejection. Record the reason and stop.
2. **Duplicate of existing canon?** If the item restates something already canonized, the
   destination is rejection with reason `duplicate-of <node-id>`. If it sharpens or updates
   existing canon, it is not a duplicate; route it to the owning namespace as an update.
3. **Time-bound action with no durable lesson?** If the item needs a near-term action and
   carries no reusable understanding, the destination is the action queue. Do not store a
   knowledge node for a one-off reply.
4. **Input to a known recurring pipeline?** If the item is fuel for a workflow (content,
   research digest, newsletter), the destination is that workflow.
5. **Scoped to a specific outcome with owner-intent?** If the item advances one concrete
   outcome, the destination is a project.
6. **Durable understanding?** Otherwise, if the item carries reusable understanding, the
   destination is a knowledge namespace. Pick the namespace with `namespace-routing-map.md`.

## Department-aware routing

The decision order above picks the destination type. For every type except rejection, also pick the
owning department lane with `department-routing-map.md`. The lane and the type are orthogonal: the
type says what artifact the item becomes (a knowledge node, a project task, a workflow input, an
action), the lane says which department owns that artifact and reviews its residue.
Routing targets the department set you have assembled in `departments/`. The starter ships one
example department plus the template; add a lane per department you assemble, and keep the system
roles (intake operations, brain stewardship, the chief-of-staff membrane, the fleet coordinator)
as lanes once you stand them up.

When two lanes both look right, resolve with `ambiguity-and-overlap-rules.md` before recording the
decision. The governing rule is single-owner-by-durable-outcome plus cross-link, never dual-own.
A human-bound item (a decision, approval, blocker, or assumption) never resolves to a namespace; it
escalates to `chief-of-staff` through the operator human-queue contract.

## Stewardship handoff for PKM-impact items

Some items do not merely belong in a namespace; they imply that the brain itself may need
to change. Examples:

- a likely canon candidate
- a namespace-structure implication
- a new tool, workflow, or department implication
- a refined project-task recommendation born from intake

For these, `intake-operations` should still produce the normal processed receipt, but it
should also create a PKM-opportunity handoff for `infinite-brain-ops`. This does not change
the destination type taxonomy above. It adds a second-stage stewardship review when the
structural implication matters.

## Choosing the knowledge namespace

When the destination is a knowledge namespace, use `namespace-routing-map.md` to pick the
candidate namespaces from the item's source and content signals. Then:

- If one namespace clearly fits, route there.
- If two or more fit and the item bridges them, route to the best-fit namespace and note a
  cross-link to the other in the routing decision. Genuinely cross-namespace synthesis
  belongs in the root `synthesis/` layer, not duplicated into two namespaces.
- If no existing namespace fits and the item recurs, flag a candidate new namespace in the
  routing decision rather than forcing a poor fit. Do not create a namespace from a single
  item.

## Within a namespace: which layer

Routing decides the namespace. The processing playbook and the destination namespace's own
rules decide the layer inside it: raw goes to `archive/` or stays as an intake capture,
provenance to `support/`, derived reading to `synthesis/`, settled compressed knowledge is
a canon-candidate. Intake never writes directly into `canon/`. Canon is operator-approved
through the promotion path in `_system/promotion-path-rules.md`.

## Operator approval

High-novelty items routed to a knowledge namespace, and any item that proposes a new
namespace or a canon change, carry `operator_approval: pending` in the routing decision
until the operator confirms. Low-stakes routes (action queue, workflow input, rejection of
clear noise) may be auto-approved per the scoring model. The decision records which path
was taken.

## When the route is closed

A routing decision is not the end of the route. The route closes only when the owning department or
namespace has produced the node, task, action, or workflow input and the matching receipt and
per-destination trail pointer both exist. Until then the item is open handoff residue for its lane.
The full residue model, the daily and weekly review loop, and the metrics live in
`residue-and-review-posture.md`.
