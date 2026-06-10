---
id: "knowledge-intake-fabric-example-canon-core-doctrine"
aliases: ["knowledge-intake-fabric-example-canon-core-doctrine", "intake-fabric-example-core-doctrine"]
type: "Knowledge"
namespace: "intake-fabric-example"
lifecycle_state: "research"
summary: "Intake is a root OS layer that captures inbound items, preserves source context, and routes high-signal items into durable knowledge homes. The live fabric lives at repo-root intake/. This knowledge namespace holds only distilled doctrine about why it is structured the way it is."
confidence: 0.88
retrieval_class: "identity"
export_class: "internal"
verified_at: "2026-05-30"
verified_by: "scaffold-only-not-operator-approved"
edges:
  - target: "[[intake-fabric-namespace]]"
    relation: "derived_from"
    confidence: 0.92
  - target: "[[three-layer-split-decision]]"
    relation: "derived_from"
    confidence: 0.9
  - target: "[[namespace-profiles]]"
    relation: "informed_by"
    confidence: 0.85
  - target: "[[infinite-brain-control-model]]"
    relation: "grounded_in"
    confidence: 0.88
created: "2026-05-30"
---

## Read this first

This is the canon of the `intake-fabric-example` namespace. It is thin by design. The
live intake fabric is at repo root `intake/`. This namespace holds the rationale for why
intake is structured the way it is. Read this first; then read `intake/README.md` at
repo root to understand the live scaffold.

## 1. What intake is

Intake is the convergence point for inbound items from many sources: posts, bookmarks,
videos, repositories, emails, ideas, and AI-guided research. Its job is to capture
source context, track processing and routing, and move high-signal items into durable
knowledge homes. Intake does not own truth. The destination namespace owns the durable
canon. Intake only preserves the receipt trail that makes capture and routing auditable.

## 2. The three-layer split

The intake fabric is organized in three layers, locked by [[three-layer-split-decision]]:

1. **Connector and runtime layer**: OAuth credentials, polling loops, token refresh, live
   queue contents. This layer stays in the operational app (the the connector app FastAPI
   app). It is never tracked as live state in git. Live queue contents are volatile; they
   belong in a database or app state, not in a version-controlled file.

2. **Durable intake layer** (in git, at `intake/`): captured source records with
   provenance, processed receipts, routing decisions, routing doctrine, and processing
   playbooks. This layer is durable and auditable. It is the part of intake that belongs
   in git because it records what came in and what was decided, not what is currently
   waiting.

3. **Knowledge layer** (in `knowledge/`): only distilled doctrine, decisions, playbooks,
   and receipts produced from intake. This is where processed and promoted items land
   after routing. The destination namespace owns the node; intake only holds the routing
   receipt pointing to it.

The split is the guarantee: live operational churn stays out of the durable graph, while
the receipt trail makes every intake decision auditable.

## 3. Where things live

| What | Where |
|------|-------|
| Live queue contents | Operational app, not git |
| Connector config and credentials | `_system/` or secrets manager, not intake |
| Captured source records | `intake/sources/<source-family>/` |
| Processed receipts | `intake/processed/<source-family>/` |
| Routing doctrine | `intake/routing/` |
| Processing playbooks | `intake/playbooks/` |
| Per-namespace receipt trail | `intake/destinations/<namespace>/processed/` |
| Record schemas | `intake/schemas/` |
| Intake doctrine (why) | This knowledge namespace |
| Destination knowledge | Destination namespace, not `intake/` |

## 4. Intake never owns truth

A processed item from intake that becomes a knowledge node lives in the destination
namespace. The intake receipt records what was done and links to the destination node.
Intake is the channel, not the library. This rule is what prevents the intake layer from
gradually accumulating duplicate knowledge that drifts from the canonical version in the
destination namespace.

## 5. This knowledge namespace is thin by design

Profile H (intake-fabric) is the only profile whose live operational layer lives outside
`knowledge/`. This namespace exists to hold the rationale, the structural decisions, and
the process pointers so that any agent or operator who needs to understand the intake
system has a doctrine home to read first. It does not need synthesis, pillars, or a large
concept graph. The richness of the intake system is in `intake/` and in the destination
namespaces that receive processed items.

## Changelog

- 2026-05-30: initial example scaffold (sprint ai-architecture-namespace-v2-upgrade).
