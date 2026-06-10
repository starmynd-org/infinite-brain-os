---
id: "knowledge-ai-architecture-process-namespace-intake"
aliases: ["knowledge-ai-architecture-process-namespace-intake", "ai-architecture-process-namespace-intake", "process-namespace-intake"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Procedure to process an intake item into a namespace: read the intake record, decide routing, do the work, and write a processed receipt recording what changed and which files were created."
confidence: 0.9
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[intake-fabric-namespace]]"
    relation: "implements"
    confidence: 0.9
  - target: "[[namespace-intake-rules]]"
    relation: "bounded_by"
    confidence: 0.9
created: "2026-05-30"
---

# Process Namespace Intake

## Summary

Intake is the root OS layer that receives inbound items from many sources and moves the
high-signal ones into durable homes. This playbook processes one intake item end to end:
read its captured record, decide where it belongs, do the work, and write a processed
receipt. Intake never owns truth. The destination namespace owns canon; the receipt only
records what happened.

## When to run

Run this when an intake item is ready to process: a captured source record exists under
`intake/sources/<family>/` and either an agent or the operator has decided it is worth
acting on. Live queue state such as unprocessed and in-review lists is operational and
lives in the runtime app, not in git. This playbook starts from a durable captured
record, not from a live queue. See [[intake-fabric-namespace]] for why intake is a root
layer and how the three-layer split works.

## Procedure

1. Read the intake record. Open the captured record under `intake/sources/<family>/`.
   Confirm it carries source platform, creator or sender, original URL or message id,
   ingest timestamp, raw capture location, extracted summary, and why it matters. If the
   record is incomplete, fix the capture before routing.

2. Decide routing. Score candidate destination namespaces and pick one, following the
   routing doctrine in `intake/routing/` and the consumption rules in
   [[namespace-intake-rules]]. Record the candidates, the score, the chosen destination,
   the rationale, and the operator approval state as a routing decision. High-stakes or
   low-confidence routes wait for operator approval.

3. Classify the work. Decide what the item becomes in the destination: a provenance
   record in `support/`, a derived reading in `synthesis/`, a candidate for `canon/`, a
   new or updated knowledge node, or nothing durable at all. Most items become support
   or synthesis, not canon. Promotion into canon follows the promotion path, not a direct
   write.

4. Do the work. Create or update the destination files. Add full node frontmatter to any
   new knowledge node. Add `derived_from` or `informed_by` edges from the new content
   back to the intake source so provenance survives. Never restructure the destination
   namespace's existing folders to fit one intake item.

5. Write the processed receipt. Create the receipt under
   `intake/destinations/<namespace>/processed/` (and mirror in `intake/processed/<family>/`
   per the scaffold). The receipt records: what came in, why it mattered, what was done,
   whether it changed archive, support, synthesis, canon, or nothing, which files were
   created or updated, what remains unresolved, and a link back to the source record.

6. Link the created files. The receipt must link every file it created or updated and
   link back to the source record. A receipt with no destination link or no routing
   decision is an error that `validate.sh` flags in the intake tree.

7. Close the item. Mark the source record processed in the durable layer. If anything
   remains unresolved, record it in the receipt and, where it is derived thinking, open a
   `synthesis/` note in the destination namespace rather than leaving it in intake.

## What the receipt must record

- what came in and why it mattered
- the chosen destination and the routing rationale
- what was done and whether it changed archive, support, synthesis, canon, or nothing
- which files were created or updated, each linked
- what remains unresolved
- a link back to the source record

## Quality checks

- The intake record was complete before routing; gaps were fixed at capture.
- A routing decision with a chosen destination exists.
- The destination namespace's existing folders were not restructured.
- New content carries provenance edges back to the source.
- The processed receipt links every created file and the source record.

## Notes

Intake is a conveyor, not a vault. The discipline is to move signal into the right
durable home quickly and leave a receipt, not to let items accumulate in intake as a
shadow knowledge base. If an item cannot be routed, that is itself a result: record the
receipt as routed to nothing and note why.
