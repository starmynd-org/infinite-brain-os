---
id: "knowledge-data-system-example-playbook-bring-your-own-data-mapping"
aliases: ["knowledge-data-system-example-playbook-bring-your-own-data-mapping", "bring-your-own-data-mapping"]
type: "Knowledge"
namespace: "data-system-example"
lifecycle_state: "research"
summary: "Starter-repo playbook for a non-Example Co client to map its own exports, sheets, or warehouse outputs into the shared metric and source-contract layer."
confidence: 0.82
retrieval_class: "domain"
export_class: "internal"
created: "2026-06-03"
---

## Trigger

Run this when a client wants to use the starter repo's metric contract but is not using
Example Co as the live data implementation.

## Inputs required

- the metric nodes the client wants to make real
- the source-contract nodes those metrics depend on
- the client's actual source of truth: API, CSV export, dashboard, warehouse, or sheet

## Steps

1. Keep the metric nodes as the semantic source of truth. Do not rename or fork the
   `metric_id` values just because the implementation differs.
2. Compare the client's source fields to the namespace's source-contract expectations.
3. Record any gaps or mapping rules in the relevant source-contract or support note.
4. Set each metric's starter posture fields:
   - `implementation_path: "byo-adapter"` or `manual-sheet`
   - `implementation_owner: "client-managed"`
   - `instrumentation_status: "manual"` or `"not-wired"` until the mapping is live
5. Add a Data node pointer to the actual sheet, dashboard, export, or table once it is the
   live analytical surface.
6. If the client later adopts Example Co, update only the implementation posture fields and
   pointers. Do not rewrite the metric semantics.

## Completion check

The client-specific implementation is mapped into the shared contract instead of replacing
it, and the repo makes clear which metrics are live, manual, or still not wired.
