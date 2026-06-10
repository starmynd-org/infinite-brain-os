---
id: "knowledge-intake-fabric-example-three-layer-split-decision"
aliases: ["knowledge-intake-fabric-example-three-layer-split-decision", "three-layer-split-decision"]
type: "Knowledge"
namespace: "intake-fabric-example"
lifecycle_state: "research"
summary: "Decision: split the intake fabric into three layers (connector and runtime, durable intake, knowledge) to keep live queue state out of git while preserving an auditable receipt trail and clean destination-namespace ownership of durable truth."
confidence: 0.9
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[core-doctrine]]"
    relation: "supports"
    confidence: 0.92
  - target: "[[intake-fabric-namespace]]"
    relation: "implements"
    confidence: 0.9
  - target: "[[infinite-brain-control-model]]"
    relation: "grounded_in"
    confidence: 0.88
created: "2026-05-30"
---

## Decision

Split the intake fabric into three layers:

1. **Connector and runtime layer**: OAuth, polling, token refresh, live queue contents.
   Lives in the operational app. Never tracked as live state in git.
2. **Durable intake layer**: source records, processed receipts, routing decisions,
   routing doctrine, playbooks. Lives in git at repo-root `intake/`.
3. **Knowledge layer**: distilled doctrine, decisions, and receipts produced from intake.
   Lives in `knowledge/<namespace>/`. The destination namespace owns the node; intake
   holds only the routing receipt.

## Options considered

- **Single layer (all in git)**: Put queues, records, and knowledge all in git under
  `intake/`. Rejected. Live queue contents mutate rapidly and would make git history
  noisy and unreliable for auditing stable decisions. They are operational state, not
  durable knowledge.
- **Two layers (connector external, rest in git)**: Combine durable records and
  knowledge into one `intake/` folder. Rejected. This conflates the capture-and-routing
  function of intake with the destination-namespace function of knowledge, making it
  unclear which namespace owns truth for any given item.
- **Three layers (adopted)**: Separates the concerns cleanly. Connectors stay external.
  Git tracks only what happened (receipts and records) and what the routing rules are.
  Knowledge stays in the namespace that should own it.

## Rationale

The control model in [[infinite-brain-control-model]] establishes that git-backed canon
owns durable knowledge and operational state owns live queue contents. The three-layer
split applies this principle directly to intake. The boundary is what keeps live
operational churn out of the durable graph while ensuring every intake decision is
auditable via the receipt trail in `intake/processed/`.

The rule "intake never owns truth" follows from the same control model: a captured item
is not canon until it is reviewed, distilled, and promoted into a destination namespace
by a human or an approved agent. Intake is the channel; the namespace is the library.

## Status

This decision is locked for the V2 architecture sprint (2026-05-30). It may be revisited
if a future use case requires a different split, but the operator must explicitly approve
any change and record it as a superseding decision node here.
