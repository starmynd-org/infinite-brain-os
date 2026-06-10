---
id: "knowledge-ai-architecture-intake-fabric-namespace"
aliases: ["knowledge-ai-architecture-intake-fabric-namespace", "ai-architecture-intake-fabric"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Intake is a root OS layer, not an ordinary knowledge namespace. A three-layer split keeps connectors and live queues external, durable receipts and routing in git, and distilled knowledge in destination namespaces."
confidence: 0.9
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[namespace-intake-rules]]"
    relation: "implements"
    confidence: 0.9
  - target: "[[namespace-profiles]]"
    relation: "related_to"
    confidence: 0.85
created: "2026-05-30"
---

# Intake Fabric As A Root OS Layer

## Summary

Intake is the convergence point for inbound items from many sources: X, bookmarks,
YouTube, web, repos, email, Slack, ideas, and AI-guided deep research. It is a root OS
layer at `intake/`, not a knowledge namespace under `knowledge/<namespace>/` (contract
Part 5, Profile H). It receives items, preserves source context, tracks processing and
routing, and moves high-signal items into durable homes. Intake never owns truth; the
destination namespace does.

## Content

Intake is a root layer because it serves every namespace and owns no canon of its own.
Folding it into one knowledge namespace would either trap cross-namespace inbound flow
inside a single domain or pretend that captured items are already distilled knowledge.
Neither is true. Intake is plumbing that feeds the graph; it sits beside `knowledge/`,
not inside it.

## The three-layer split

The split is the locked design (guardrail G1) and the reason no live queue state ever
enters git.

- Connector and runtime layer: OAuth, polling, token refresh, and live queue state stay
  in the operational app, for example a small FastAPI connector app. This is not in
  git as live state. Live queues such as `unprocessed`, `in-review`, and `blocked` are
  operational state owned by the runtime app and are not scaffolded as tracked git
  folders.
- Durable intake layer in git at `intake/`: captured source records, processed receipts,
  routing decisions, routing doctrine, and per-source playbooks. This is the durable
  trail of what came in and what was done with it.
- Knowledge layer in `knowledge/`: only distilled doctrine, decisions, playbooks, and
  receipts produced from intake. The destination namespace owns the durable canon.

## No live queue state in git

Git holds receipts, not queues. A receipt is a settled record of a processed item: what
came in, why it mattered, what was done. A queue is mutable runtime state that changes
many times before settling. Committing live queues would turn git into a runtime database
and produce churn, conflicts, and stale state. The runtime app owns the queues; git owns
the durable trail. The intake README documents this boundary explicitly.

## Record schemas

Three record contracts live in `intake/schemas/` and govern the durable layer.

- Intake record: one captured item, holding source platform, creator or sender, original
  URL or message id, ingest timestamp, raw capture location, extracted summary, and why it
  matters.
- Routing decision: candidate destinations, score, chosen destination, rationale, and
  operator approval state.
- Processed receipt: what came in, why it mattered, what was done, whether it changed
  archive, support, synthesis, canon, or nothing, which files were created or updated,
  what remains unresolved, and a link back to the source record.

These schemas are the operative contract. The rules for how namespaces consume them live
in [[namespace-intake-rules]].

## Promotion paths

An intake item moves toward a durable home along the promotion path: raw source flows to
support when provenance is recorded, then to synthesis when a derived reading is written,
then to a canon candidate, then to operator-approved canon. A processed receipt records
which step a given item reached and which files it touched. Many items never reach canon;
they settle as receipts that prove the item was seen and routed, including items routed to
nothing.

## Edges

- `implements` the namespace-intake rules, which carry the operative consumption and
  routing procedure.
- `related_to` the namespace-profiles concept because intake is Profile H, the one profile
  that lives at repo root rather than under `knowledge/`.

## Notes

Operative rules live in [[namespace-intake-rules]]. A thin `knowledge/<intake-name>/`
namespace may hold only distilled doctrine, decisions, playbooks, and receipts; it never
holds connectors or live queues. The initial build plans intake migration and builds the
scaffold; it does not perform a live cutover from the runtime app.
