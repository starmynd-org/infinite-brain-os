# Routing: Scoring Model

The signal-scoring model for triage. It answers one question before any namespace is
chosen: is this item worth routing, and how much operator attention does it deserve? Run
this before `namespace-routing-map.md`. The score and the threshold band both go into the
routing decision (`../schemas/routing-decision.md`).

## The four signals

Each item is scored on four signals, 0.0 to 1.0.

- **Relevance.** How close is this to what the operator is actually working on or thinking
  about now? An AI architecture take during an architecture sprint scores high. A
  tangential industry rumor scores low.
- **Novelty.** Does this add something the brain does not already hold? A claim that
  restates existing canon scores near zero. A claim that contradicts or sharpens canon
  scores high, because it forces a synthesis or a canon revision.
- **Source trust.** How reliable is the origin? A tracked thinker, a primary source, or a
  cited research report scores high. An anonymous post with no evidence scores low. Source
  trust gates how much verification a high-novelty claim needs before promotion.
- **Actionability.** Does this imply a concrete next step (a task, a reply, a decision, a
  node to write)? High actionability pushes toward project or action-queue destinations;
  low actionability with high relevance and novelty pushes toward knowledge.

## Composite score

The composite is a weighted blend. Default weights, tunable by the operator:

- relevance 0.35
- novelty 0.30
- source trust 0.20
- actionability 0.15

```text
score = 0.35*relevance + 0.30*novelty + 0.20*source_trust + 0.15*actionability
```

Two guards override the blend:

- **Novelty floor.** If novelty is below 0.15, the item is a near-duplicate of existing
  knowledge regardless of other signals. Treat as defer or reject; do not create a node.
- **Source-trust gate on high novelty.** If novelty is at or above 0.7 but source trust is
  below 0.4, do not promote on the strength of the claim alone. Route to defer with a
  verify-before-promote note. The claim is interesting but unverified.

## Promote, defer, reject thresholds

| Band | Composite score | Meaning | Default handling |
|------|-----------------|---------|------------------|
| Promote | at or above 0.65 | High signal, worth a durable home now | Route per `destination-rules.md`. Knowledge routes with high novelty carry `operator_approval: pending`. |
| Defer | 0.35 to below 0.65 | Plausibly useful, not clearly worth a node yet | Keep the captured record, write no destination yet, revisit at the next review. Verify-before-promote items land here. |
| Reject | below 0.35 | Noise, duplicate, or off-target | Record rejection with a one-line reason, then drop. |

A defer is not a backlog of live queue state in git. The captured record stays in
`sources/<family>/`; the open status is runtime state in the operational app, not a tracked
`in-review/` folder. The intake fabric records the score and band, not a working queue.

## Auto-approve vs operator review

- **Auto-approve:** clear rejections of noise, workflow inputs, and low-stakes action-queue
  routes. The decision records `operator_approval: auto`.
- **Operator review:** any promote into a knowledge namespace with novelty at or above 0.5,
  any proposed new namespace, and any canon change. These carry `operator_approval: pending`
  until confirmed. The operator can raise or lower these triggers by editing this file.

## Tuning

Weights and thresholds are defaults, not law. If too many low-value items reach the promote
band, raise the novelty weight or the promote threshold. If real signal keeps landing in
defer, lower the promote threshold. Record any change to weights or thresholds with a dated
one-line reason at the bottom of this file so the model's evolution stays auditable.
