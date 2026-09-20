---
id: "data-kyn-synthetic-example"
aliases: ["data-kyn-synthetic-example", "kyn-synthetic-example"]
type: "Data"
namespace: "personal-operator"
lifecycle_state: "research"
summary: "Pointer to the shipped Synthetic KYN folder (Pebble Press, an invented card seller): the worked example for the store-kyn-files skill. The numbers live in the sealed folder, never in this node."
confidence: 0.85
retrieval_class: "domain"
export_class: "public"
state_stored_at: "repo://knowledge/_examples/kyn-folder-example/kyn"
edges:
  - target: "[[skill-store-kyn-files]]"
    relation: "governed_by"
    confidence: 0.9
created: "2026-09-20"
---

# Data: KYN Synthetic Example (Pebble Press)

A prepared reporting surface in the `kyn-files/v1` format, shipped as the worked example
for [[skill-store-kyn-files]]. Everything in it is invented and labelled Synthetic in the
catalog name. This node is the pointer agents cite; the facts stay in the sealed files.

## Shape

- Folder: `knowledge/_examples/kyn-folder-example/kyn/` (catalog, one dimension file, one
  fact file).
- Workspace id `pebble-press`, revision `2026-03-04-r1`, as-of `2026-03-04T08:00:00Z`.
- One aggregate dataset, `daily-sales`, grain `channel`, metrics revenue (USD), units and
  the ratio average_price. Coverage: 2026-03-01 and 2026-03-02 complete, 2026-03-03
  incomplete.

## Discipline

- The live home for a real business is `kyn/` at the repo root, with its own Data node in
  this folder; this example stays where it is.
- Never edit a file in the folder in place: change, recompute descriptors, validate, then
  replace the whole folder (the skill's steps).
- Read date for the current revision: 2026-09-20, validator `"valid": true`.
