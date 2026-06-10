# Schema: Processed Receipt

A processed receipt is the durable record of what was done with a captured item after it was
routed. It closes the loop: capture (intake record) to decision (routing decision) to work
done (this receipt). One worked item produces one receipt.

This schema defines the field list, an example record, and validation expectations. It is the
operative contract. The processed family READMEs under `../processed/<family>/` point here,
and the playbooks under `../playbooks/` write receipts to this shape.

## What a processed receipt is and is not

A processed receipt IS the audit trail of an intake item that has been worked: what came in,
why it mattered, what was done, whether it changed `archive`, `support`, `synthesis`, `canon`,
or nothing, which files were created or updated, what remains unresolved, and a link back to
the source record. It is durable. It stays in `../processed/` after the item is promoted so
the trail of where signal went is auditable months later.

A processed receipt is NOT the destination node. The receipt records that a node was created
or updated; the node itself lives in `knowledge/<ns>/` and owns the durable truth. Intake
never owns truth (contract Part 5.1). The receipt is also not live state: there is no
`in-review` or `blocked` status on a receipt, because a receipt is only written after the work
is done.

## File location and naming

A receipt lives in `../processed/<family>/`, mirroring the source family of its intake record.
When the item earned a home in a knowledge namespace, a pointer copy or stub is also added to
that namespace's trail under `../namespaces/<ns>/processed/` so each namespace can see what
flowed into it.

Filename and `id`:

```text
receipt-<source>-<date>-<slug>
```

Use the same `<source>-<date>-<slug>` tail as the intake record and routing decision, so all
three records of one item share an obvious stem. Example: intake record
`intake-web-2026-05-30-thin-harness-thesis` to routing decision
`routing-web-2026-05-30-thin-harness-thesis` to receipt
`receipt-web-2026-05-30-thin-harness-thesis`.

## Field list

| Field | Type | Required | Notes |
|-------|------|----------|-------|
| `id` | string | yes | `receipt-<source>-<date>-<slug>`. Matches filename without extension. |
| `aliases` | list of string | when id differs from filename | Include `id` for Obsidian resolution. |
| `type` | string | yes | Always `"processed-receipt"`. |
| `namespace` | string | yes | `"personal-operator"`. The namespace the item was routed into appears in `destination` below. |
| `source_record` | string | yes | Wikilink back to the intake record. |
| `routing_decision` | string | yes | Wikilink to the routing decision this receipt acts on. A receipt with no routing decision is a validation error. |
| `what_came_in` | string | yes | One line restating the captured item. |
| `why_it_mattered` | string | yes | One or two lines on the signal. |
| `what_was_done` | string | yes | One or two lines: the concrete action taken. |
| `layer_changed` | string | yes | Which durable layer changed: `archive`, `support`, `synthesis`, `canon`, or `none`. Exactly one. |
| `destination` | object | yes | Where it landed: `kind` plus `target`, mirroring the routing decision's `chosen_destination`. |
| `files_touched` | list of string | yes | Repo-relative paths created or updated. Empty list only when `layer_changed` is `none`. |
| `unresolved` | string | yes | What still needs attention, or `"none"` if fully closed. Feeds the next review. |
| `processed_at` | string | yes | ISO 8601 timestamp the work completed. |
| `lifecycle_state` | string | yes | `research`. A receipt records completed work; it is not `scratch`. |
| `confidence` | number | yes | 0.0 to 1.0. Confidence the work was done correctly. |
| `retrieval_class` | string | yes | `ephemeral`. |
| `export_class` | string | yes | `internal`. |
| `created` | string | yes | `YYYY-MM-DD`. |
| `edges` | list | yes | Edges to `source_record` (relation `produced_by`) and to each destination node created or updated (relation `produces`). |

`destination` shape mirrors the routing decision:

```yaml
kind: "knowledge"          # knowledge | project | workflow | action-queue | rejection
target: "garytan"          # namespace slug, project, workflow id, or "n/a"
sub_target: "support"      # support | synthesis | canon-candidate | pillar | task
```

`layer_changed` is the falsifiable claim of the receipt. It is one of:

- `archive`: raw source preserved into a namespace `archive/`.
- `support`: provenance, migration, or source-priority record added to `support/`.
- `synthesis`: a derived-thinking note created or updated in `synthesis/`.
- `canon`: a canon node changed (rare from intake; usually intake only feeds a
  canon-candidate in `synthesis/`, and the operator promotes it later).
- `none`: routed to a project, a workflow, the action queue, or rejected. Nothing in the
  durable knowledge layers changed.

## Example record

```yaml
---
id: "receipt-web-2026-05-30-thin-harness-thesis"
aliases: ["receipt-web-2026-05-30-thin-harness-thesis"]
type: "processed-receipt"
namespace: "personal-operator"
source_record: "[[intake-web-2026-05-30-thin-harness-thesis]]"
routing_decision: "[[routing-web-2026-05-30-thin-harness-thesis]]"
what_came_in: "A long-form post arguing the harness should stay thin and the skills should carry the weight."
why_it_mattered: "Directly extends the garytan thin-harness-fat-skills pillar with a fresh argument."
what_was_done: "Added a provenance entry to garytan support and drafted a synthesis note reconciling it with the existing pillar."
layer_changed: "synthesis"
destination:
  kind: "knowledge"
  target: "garytan"
  sub_target: "synthesis"
files_touched:
  - "knowledge/garytan/support/source-priority-thin-harness.md"
  - "knowledge/garytan/synthesis/thin-harness-best-current-reading.md"
unresolved: "Whether this rises to a canon-candidate or stays a synthesis note. Left for the monthly canon review."
processed_at: "2026-05-30T12:10:00Z"
lifecycle_state: "research"
confidence: 0.9
retrieval_class: "ephemeral"
export_class: "internal"
created: "2026-05-30"
edges:
  - target: "[[intake-web-2026-05-30-thin-harness-thesis]]"
    relation: "produced_by"
    confidence: 0.95
  - target: "[[thin-harness-best-current-reading]]"
    relation: "produces"
    confidence: 0.9
---

## What came in

A long-form web post arguing that the agent harness should stay thin and skills should carry
capability, so the operator owns capability independent of any one vendor.

## What was done

Recorded source provenance in `knowledge/garytan/support/`, then drafted a best-current-reading
synthesis note in `knowledge/garytan/synthesis/` reconciling the post with the existing
thin-harness pillar. No canon node was changed; the pillar still stands and the synthesis note
sits beside it as the current reading.

## Layer changed

`synthesis`. Two files written: one support provenance entry, one synthesis note.

## Unresolved

Whether the synthesis note is a canon-candidate. Deferred to the monthly canon review. Until
then it stays a synthesis note, not canon.
```

## Validation expectations

- `id` present, `type` is `"processed-receipt"`, `id` matches filename without extension.
- `source_record` and `routing_decision` both resolve. A receipt missing a routing decision
  or a destination link is an error in `intake/` (contract Part 7.3).
- `layer_changed` is exactly one of `archive`, `support`, `synthesis`, `canon`, `none`. When
  it is not `none`, `files_touched` is non-empty and the paths resolve.
- `destination.kind` is one of the five destination types and is consistent with the routing
  decision's `chosen_destination`.
- `processed_at` parses as ISO 8601. `unresolved` is present (`"none"` is valid). `export_class`
  is `internal`.
- No em dashes, no en dashes. No placeholder text above `scratch`.

How namespaces consume receipts is governed by `_system/namespace-intake-rules.md`. The
promotion path a receipt may trigger (support to synthesis to canon-candidate to canon) is
governed by `_system/promotion-path-rules.md`.
