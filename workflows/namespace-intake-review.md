---
id: "workflow-namespace-intake-review"
aliases: ["workflow-namespace-intake-review", "namespace-intake-review"]
type: "Workflow"
namespace: "personal-operator"
lifecycle_state: "research"
summary: "Per-change pipeline that processes the intake queue, routes each item to a destination namespace, and writes a processed receipt back into the intake fabric."
confidence: 0.85
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[agent-intake-router]]"
    relation: "uses"
    confidence: 0.9
  - target: "[[process-namespace-intake]]"
    relation: "uses"
    confidence: 0.9
  - target: "[[skill-process-namespace-intake]]"
    relation: "uses"
    confidence: 0.85
  - target: "[[namespace-intake-rules]]"
    relation: "governed_by"
    confidence: 0.9
  - target: "[[promotion-path-rules]]"
    relation: "depends_on"
    confidence: 0.85
  - target: "[[intake-fabric-namespace]]"
    relation: "informed_by"
    confidence: 0.85
  - target: "[[correction-loop-rules]]"
    relation: "references"
    confidence: 0.7
created: "2026-05-30"
runtime: "agentic"
---

# Workflow: Namespace Intake Review

A per-change review pipeline. Run it whenever the durable intake layer at `intake/` has
unprocessed captured items waiting to be triaged, routed to a destination namespace, and
closed out with a processed receipt. This workflow is the operating loop that keeps the
intake fabric from accumulating residue. It implements the per-item half of the intake
contract; [[new-source-ingest]] captures the item, this workflow processes it.

## When to run

- On change: any time new items land in `intake/sources/<family>/` and have no matching
  receipt in `intake/processed/<family>/`.
- As a scoped step inside [[workflow-weekly-review]] when intake residue is the focus.
- Before [[monthly-canon-review]], so canon candidates surfaced by routing are already
  recorded as synthesis before the monthly canon pass reads them.

## Inputs

- The current date (Claude Code reads this automatically).
- `intake/sources/` (captured source records, one folder per source family).
- `intake/processed/` (existing receipts, used to detect what is already processed).
- `intake/routing/destination-rules.md`, `intake/routing/namespace-routing-map.md`, and
  `intake/routing/scoring-model.md` (the routing doctrine).
- `intake/schemas/intake-record.md`, `routing-decision.md`, and `processed-receipt.md`
  (the record contracts the receipts must satisfy).
- The namespace registry at `_system/namespaces/` (each entry declares `profile`,
  `v2_status`, `canon_posture`; routing reads these to pick a real destination).
- The operative rules: [[namespace-intake-rules]] and [[promotion-path-rules]].

## Pipeline

### Step 1: Build the unprocessed set

List every record under `intake/sources/<family>/`. For each, check whether a matching
receipt already exists in `intake/processed/<family>/` (match on source record id). The
unprocessed set is every source record with no matching receipt. If the set is empty,
stop and report "intake clear, nothing to process."

### Step 2: Classify each item

For each unprocessed item, apply [[skill-process-namespace-intake]] to read the captured
record and classify it into one of: durable knowledge candidate, correction signal (route
to [[correction-loop-rules]]), task, or noise. Record the one-line why-it-matters from the
source record. Do not route noise to a namespace; mark it processed-as-noise so it is not
re-surfaced.

### Step 3: Route to a destination namespace

For each knowledge candidate, invoke [[agent-intake-router]] to produce a routing decision
that satisfies `intake/schemas/routing-decision.md`. The router reads
`intake/routing/destination-rules.md` and the namespace registry, scores candidate
destinations with `scoring-model.md`, and names: candidate destinations, score, chosen
destination, rationale, and operator approval state. A routed item never lands directly in
`canon/`. It lands in the destination namespace's `support/` (provenance) or `synthesis/`
(derived reading) per [[promotion-path-rules]]; canon promotion is a separate operator-gated
step owned by [[monthly-canon-review]].

### Step 4: Apply the route

For each approved routing decision, place the distilled material in the destination per the
promotion path: raw context stays in `intake/`, provenance lands in
`knowledge/<namespace>/support/`, derived reading lands in
`knowledge/<namespace>/synthesis/`. Preserve a link back to the source record on every file
created so provenance is never broken (migration compatibility).

### Step 5: Write the processed receipt

For each processed item, write a receipt to `intake/processed/<family>/` satisfying
`intake/schemas/processed-receipt.md`. The receipt records: what came in, why it mattered,
what was done, whether it changed archive, support, synthesis, canon, or nothing, which
files were created or updated, what remains unresolved, and a link back to the source
record. A receipt that names a destination but carries no routing decision is invalid;
validate.sh flags it as an error.

### Step 6: Surface unresolved items

Collect every item whose routing decision is "needs operator approval" or whose
classification was ambiguous. Present these to the operator as a short decision list. Do not
force a route on an ambiguous item; leave it unprocessed with a note rather than guess.

## Output format

A run summary printed to the session, plus the receipts written in Step 5. The run summary
contains:

- a count table: items found, routed, marked noise, deferred to operator
- a routing table:

```
| Source item | Family | Classification | Destination | Approval state |
|-------------|--------|----------------|-------------|----------------|
```

- the operator decision list from Step 6
- a one-line note for any item that touched a canon-candidate, flagged for the next
  [[monthly-canon-review]]

The receipts are the durable artifact. The run summary is a point-in-time record and is not
a knowledge node.

## Notes

- This workflow does the fuzzy work: classification and routing judgment. Deterministic
  checks (receipt missing a routing decision, broken link back to source) stay in
  `validate.sh` per the architecture contract.
- The intake three-layer split holds: live queue state (`unprocessed`, `in-review`,
  `blocked`) is operational app state and is never written to git. This workflow reads the
  durable `intake/` layer only.
- Operator approval is required before any item is routed into a namespace with
  `export_class` above `internal`. When in doubt, defer to Step 6.
- See [[process-namespace-intake]] for the doctrine on why intake never owns truth and the
  destination namespace always does.
