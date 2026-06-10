# Schema: Routing Decision

A routing decision records where a captured intake item should go and why. It is the bridge
between an intake record (what arrived) and a processed receipt (what was done). One captured
item produces one routing decision once it is triaged.

This schema defines the field list, an example record, and validation expectations. It is
the operative contract. The routing doctrine that produces the values lives in
`../routing/destination-rules.md`, `../routing/scoring-model.md`, and
`../routing/namespace-routing-map.md`. This schema defines the shape; those docs define the
logic.

## What a routing decision is and is not

A routing decision IS the durable record of a triage call: the candidate destinations that
were considered, the score, the destination chosen, the rationale, and whether the operator
approved it. It is durable in git so a later reader can see not just where an item went but
what else it could have gone to and why one option won.

A routing decision is NOT the live triage queue. It does not track `in-review` or `blocked`
as workflow state; the operational app owns that (G1, contract Part 5.1). The decision record
is written when the call is made, not while the item waits. It is also not the receipt: the
receipt records what was actually done after the decision, and lives in `../processed/`.

## File location and naming

A routing decision lives next to its intake record, in the same source family folder under
`../sources/<family>/`, or in a `routing/` subfolder of that family if the operator prefers
separation. The build default is alongside the intake record.

Filename and `id`:

```text
routing-<source>-<date>-<slug>
```

Use the same `<source>-<date>-<slug>` tail as the intake record it decides on, so the pair
is obvious. Example: intake record `intake-x-2026-05-30-orientation-as-retrieval` pairs with
routing decision `routing-x-2026-05-30-orientation-as-retrieval`.

## Field list

| Field | Type | Required | Notes |
|-------|------|----------|-------|
| `id` | string | yes | `routing-<source>-<date>-<slug>`. Matches filename without extension. |
| `aliases` | list of string | when id differs from filename | Include `id` for Obsidian resolution. |
| `type` | string | yes | Always `"routing-decision"`. |
| `namespace` | string | yes | `"personal-operator"`. The chosen destination namespace is a field below, not this one. |
| `source_record` | string | yes | Wikilink to the intake record this decides on, for example `"[[intake-x-2026-05-30-orientation-as-retrieval]]"`. |
| `candidate_destinations` | list | yes | Each candidate considered, with type and (if knowledge) namespace. See structure below. |
| `score` | number | yes | 0.0 to 1.0 from the scoring model. The signal strength that justified routing rather than rejection. |
| `chosen_destination` | object | yes | The winning destination: `kind` plus a target. See structure below. |
| `rationale` | string | yes | Why the chosen destination beat the others. One or two sentences. |
| `approval_state` | string | yes | `pending` (awaiting operator), `approved`, `rejected`, or `auto` (above auto-route threshold, no operator gate needed). |
| `decided_at` | string | yes | ISO 8601 timestamp of when the decision was recorded. |
| `lifecycle_state` | string | yes | `scratch` then `research`. Routing decisions do not become canon. |
| `confidence` | number | yes | 0.0 to 1.0. Confidence in the routing call (distinct from `score`, which is item signal strength). |
| `retrieval_class` | string | yes | `ephemeral`. |
| `export_class` | string | yes | `internal`. |
| `created` | string | yes | `YYYY-MM-DD`. |

`candidate_destinations` entry shape:

```yaml
- kind: "knowledge"        # knowledge | project | workflow | action-queue | rejection
  target: "ai-architecture"  # namespace slug, project name, workflow id, or "n/a" for action-queue/rejection
  score: 0.81              # this candidate's score
  note: "fits the retrieval pillar as cited support"
```

`chosen_destination` shape:

```yaml
kind: "knowledge"          # one of the five destination types
target: "ai-architecture"  # the concrete destination
sub_target: "support"      # optional: support | synthesis | canon-candidate | pillar update | task
```

The five destination kinds (`knowledge`, `project`, `workflow`, `action-queue`, `rejection`)
match `../routing/destination-rules.md`. Rejection is a first-class outcome: a rejected item
still gets a routing decision recording the reject reason.

## Example record

```yaml
---
id: "routing-x-2026-05-30-orientation-as-retrieval"
aliases: ["routing-x-2026-05-30-orientation-as-retrieval"]
type: "routing-decision"
namespace: "personal-operator"
source_record: "[[intake-x-2026-05-30-orientation-as-retrieval]]"
candidate_destinations:
  - kind: "knowledge"
    target: "ai-architecture"
    score: 0.81
    note: "fits the retrieval-over-raw-memory pillar as cited support"
  - kind: "rejection"
    target: "n/a"
    score: 0.0
    note: "would be a duplicate if it added nothing past existing canon"
score: 0.81
chosen_destination:
  kind: "knowledge"
  target: "ai-architecture"
  sub_target: "support"
rationale: "It is a clean external statement of a held pillar. Route as cited support, not new doctrine, so it strengthens provenance without duplicating canon."
approval_state: "pending"
decided_at: "2026-05-30T11:40:00Z"
lifecycle_state: "scratch"
confidence: 0.85
retrieval_class: "ephemeral"
export_class: "internal"
created: "2026-05-30"
---

## Decision

Two candidates were live: route to `ai-architecture` as cited support, or reject as a
duplicate of existing canon. The item restates a held pillar with a concrete example, which
strengthens provenance, so it clears the duplicate test (it sharpens, it does not merely
repeat). Destination: `knowledge/ai-architecture/support/` as a provenance entry, not a new
node.

## Open for operator

Approval is pending. The operator confirms whether this belongs in support, or whether the
concrete example is sharp enough to seed a synthesis note. Default if unreviewed: support.
```

## Validation expectations

- `id` present, `type` is `"routing-decision"`, `id` matches filename without extension.
- `source_record` resolves to an existing intake record. A routing decision with a broken
  `source_record` link is an error in `intake/` (contract Part 7.3).
- `chosen_destination.kind` is one of the five destination types. If `kind` is `knowledge`,
  `target` resolves to a real namespace. A processed receipt later in the chain must point
  back to this decision; a receipt with no routing decision is an error.
- `approval_state` is one of `pending`, `approved`, `rejected`, `auto`.
- `score` and `confidence` are between 0.0 and 1.0. `decided_at` parses as ISO 8601.
- `export_class` is `internal`. No em dashes, no en dashes. No placeholder text above
  `scratch`.

The doctrine that fills these fields lives in `../routing/destination-rules.md` (decision
order), `../routing/scoring-model.md` (whether to route at all), and
`../routing/namespace-routing-map.md` (which namespace). The rules for how namespaces consume
routed items live in `_system/namespace-intake-rules.md`.
