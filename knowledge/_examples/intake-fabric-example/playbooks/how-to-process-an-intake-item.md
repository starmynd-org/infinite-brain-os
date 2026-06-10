---
id: "knowledge-intake-fabric-example-how-to-process-an-intake-item"
aliases: ["knowledge-intake-fabric-example-how-to-process-an-intake-item", "how-to-process-an-intake-item"]
type: "Knowledge"
namespace: "intake-fabric-example"
lifecycle_state: "research"
summary: "High-level pointer playbook: how an inbound item moves from source capture through routing to a durable destination, with links to the live intake/playbooks/ procedures."
confidence: 0.82
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[core-doctrine]]"
    relation: "implements"
    confidence: 0.85
  - target: "[[three-layer-split-decision]]"
    relation: "grounded_in"
    confidence: 0.8
created: "2026-05-30"
---

## Overview

An inbound item moves through four stages: capture, classify, route, receipt. Each stage
has a home in the durable intake layer at repo root `intake/`. The connector layer
(OAuth, polling) handles delivery into the capture stage but is not described here.

## Stage 1: Capture

The connector places a raw source record in `intake/sources/<source-family>/`. The
record follows the intake-record schema at `intake/schemas/intake-record.md`. It
preserves: source platform, creator or sender, original URL or message id, ingest
timestamp, raw capture location, extracted summary, why it matters.

For detailed steps per source family, read: `intake/playbooks/process-<source>.md` at
repo root.

## Stage 2: Classify

An agent or operator reviews the captured record and determines:

- Is this high-signal (worth routing into a knowledge namespace) or low-signal (no
  action)?
- If high-signal: which namespace is the correct destination?
- What priority and routing rationale apply?

The routing decision is documented following the routing-decision schema at
`intake/schemas/routing-decision.md`.

## Stage 3: Route

The item is moved to `intake/processed/<source-family>/` with a processed receipt. If
the item produces a new knowledge node, the node is created in the destination namespace.
The receipt records: what came in, why it mattered, what was done, which files were
created or updated, and what remains unresolved.

For routing rules and destination mapping, read: `intake/routing/destination-rules.md`
and `intake/routing/namespace-routing-map.md` at repo root.

## Stage 4: Receipt

The processed receipt is the permanent record that the item was handled. It lives in
`intake/processed/<source-family>/`. It links to the destination node if one was created.
It does not duplicate the destination node's content.

## What does NOT happen here

- Routing decisions are not finalized here in the knowledge-layer namespace.
- Live queue state is not written here.
- Items are not stored here after processing; they go to the destination namespace.

This playbook is a doctrine pointer. The operational details are in `intake/playbooks/`
at repo root.
