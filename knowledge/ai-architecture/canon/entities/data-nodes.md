---
id: "knowledge-ai-architecture-canon-entity-data-nodes"
aliases: ["knowledge-ai-architecture-canon-entity-data-nodes", "ai-architecture-entity-data-nodes", "entity-data-nodes"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Canon for the Data node: a pointer to a BigQuery table, dashboard, or report with a state_stored_at edge, never the live numbers themselves, keeping the analytical layer out of git canon."
confidence: 0.9
retrieval_class: "domain"
export_class: "internal"
verified_at: "2026-05-31"
verified_by: "operator-pending"
edges:
  - target: "[[system-overview]]"
    relation: "part_of"
    confidence: 0.9
  - target: "[[core-doctrine]]"
    relation: "derived_from"
    confidence: 0.88
  - target: "[[surface-boundary]]"
    relation: "bounded_by"
    confidence: 0.85
  - target: "[[metrics]]"
    relation: "related_to"
    confidence: 0.82
created: "2026-05-31"
---

## What it is

A **Data node** is a pointer, not a payload. It lives in `data/` and references a BigQuery
table, a dashboard, a Google Sheet, a report, or another live analytical surface through a
`state_stored_at` edge, so the brain knows where a number lives without copying the number
into git. The Infinite Brain is not a system of record for numbers: metrics, telemetry, and
live data live in the warehouse, BI tool, sheet, or managed substrate, and a data node is the
durable reference to them.

## When to use it (and when not)

Create a data node when the brain needs a durable, citable reference to live data so a node,
playbook, or project can point at the authoritative source. In a starter repo, this often
means a dashboard, export, or Google Sheet before a client has built a richer warehouse. Do
not create a data node by copying raw data into Markdown; a pointer is enough. Do not use a
data node to define what a number means across namespaces; that is a [[metrics|metric]]. Do
not store raw runtime logs as data nodes; reviewed lessons from logs become [[memory-nodes]].

## Required shape

- **Folder**: `data/`.
- **Frontmatter**: standard node fields plus `type: "Data"` and a `state_stored_at` edge to
  the live source. Add `analytical_view` when there is a specific view or query that backs
  the pointer.
- **Body**: describe what the data is, where it lives, how it is refreshed, and which
  metrics or nodes reference it. Do not inline the live values.

## How it relates to the other entity types

A data node is the live-source pointer that a [[metrics|metric]] computes its lineage from,
and that [[knowledge-nodes]], [[workflows]], and [[projects]] cite when they need a number.
A [[deterministic-workflows|deterministic workflow]] may write or refresh the underlying
table, but the data node only references it. The analytical layer it points at is one of the
three control-model layers and is numbers, not doctrine.

## Governing rules and doctrine

The rule that durable canon stays in git while analytical history lives in the warehouse is
the control model in [[core-doctrine]]; the data node is the pointer that keeps the
analytical layer out of canon. The surface boundary in [[surface-boundary]] governs which
layer owns the live state. The `state_stored_at` and `analytical_view` fields are recognized
by `validate.sh`. See [[system-overview]] for how data nodes sit in the entity set.
