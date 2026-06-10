# Routing: Ambiguity and Overlap Rules

How to resolve a routing call when two or more department lanes both look right. Use this after
`department-routing-map.md` when the lane is not obvious. The decision order in `destination-rules.md`
picks a destination type; the department map picks a lane; this file breaks the tie when lanes
overlap.

Real deployments create real adjacencies: an application that sits on a data backend, a marketing
lane that distributes another lane's product, a shared tool contract consumed by several domains.
Overlap is expected. The rule is to name one owner and cross-link the rest, never to dual-own.

## The governing principle

Route to the lane that owns the durable outcome, then cross-link the others in the routing decision.

- The owner is the department that will hold the resulting node, project, or action and answer for
  it later.
- A cross-link is a `candidate_destinations` entry with a note, not a second copy of the node.
- Framing is owned separately from the thing being framed. Marketing owns how a product is
  positioned; the product department owns the product.
- The capability contract is owned separately from the work built with it. A tool-contract
  namespace owns how the tool is called; the consuming domain owns what the work means.
- A fact about work is owned separately from the work. A reporting lane reads an outcome; the
  producing lane owns the outcome.

## The overlap pairs

The pairs below are worked examples of the principle, phrased against generic namespace shapes.
Replace them with your own real pairs as your department set grows; keep the two-column form.

| Overlap | Goes to lane A when | Goes to lane B when |
|---|---|---|
| a marketing namespace vs the product namespace it promotes | A (marketing): positioning, offer framing, public claims, campaign and content ideas, channel and funnel work, the framing and distribution of the thing | B (product): the product or service being distributed, including its scope, features, roadmap, and doctrine |
| a tool-contract namespace vs the consuming domain namespace | A (tool-contract): how to call the tool safely, endpoint and SDK behavior, credential posture, rate and retry discipline | B (domain): the work performed with the tool, its domain meaning, and the outcomes the domain answers for |
| a data-system namespace vs the application namespace that presents the data | A (data-system): pipelines, transforms, models, metric definitions, freshness, monitoring, anything that gets data in and shaped | B (application): how the data is surfaced and used, dashboards, presentation, and anything that makes data usable in the product |

## Resolution procedure

1. Name one owner by the durable outcome. If exactly one lane will hold and answer for the node,
   route there and stop.
2. If two lanes genuinely bridge, route to the best fit and add the other as a cross-link note in the
   routing decision. Do not write the node twice.
3. If the item is cross-namespace synthesis that belongs to neither lane alone, route it to the root
   `synthesis/` layer, not into either namespace.
4. If no lane fits and the item is a one-off, default to `personal-operator` or rejection per
   `scoring-model.md`. If it recurs, flag a candidate new namespace or department in the routing
   decision rather than force-fitting.
5. If the item is `external` or `canon-touching`, or stakes are high or critical, escalate to the
   operator regardless of how clear the lane is. These hard flags override lane confidence. See
   `entities/rules/signal-vocabulary.md`.

## Confidence and escalation

Routing confidence is distinct from item score (see `intake/schemas/routing-decision.md`). When
routing confidence is low, or when two lanes score within a narrow band and neither clearly owns the
outcome, do not guess: mark the routing decision `approval_state: pending` and surface it for
operator review. The conservative default is to defer or surface, never to silently force a lane.
Misrouting (an item the operator later moves to a different lane) is the routing safety metric;
when it rises, tighten these rules.

Human-bound items (a decision, approval, blocker, or assumption needing sign-off) never resolve to a
namespace through this file. They escalate to the operator through the human-review channel.
