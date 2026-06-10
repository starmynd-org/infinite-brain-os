---
id: "skill-process-namespace-intake"
aliases: ["skill-process-namespace-intake", "process-namespace-intake-skill"]
type: "Skill"
namespace: "personal-operator"
lifecycle_state: "research"
summary: "Process one captured intake item into a destination namespace and write the durable processed receipt that records what was done and what changed."
confidence: 0.9
retrieval_class: "domain"
export_class: "internal"
description: "Use this skill to turn a single captured intake item into a routing decision, a knowledge or support or synthesis change in a destination namespace, and a processed receipt that closes the loop back to the source record."
edges:
  - target: "[[namespace-intake-rules]]"
    relation: "governed_by"
    confidence: 0.92
  - target: "[[knowledge-ai-architecture-process-namespace-intake]]"
    relation: "informed_by"
    confidence: 0.9
  - target: "[[intake-fabric-namespace]]"
    relation: "informed_by"
    confidence: 0.85
  - target: "[[promotion-path-rules]]"
    relation: "depends_on"
    confidence: 0.82
  - target: "[[skill-summarize-source]]"
    relation: "paired_with"
    confidence: 0.8
  - target: "[[skill-build-namespace]]"
    relation: "related_to"
    confidence: 0.7
  - target: "[[rule-voice-and-style]]"
    relation: "governed_by"
    confidence: 0.8
created: "2026-05-30"
---

# process-namespace-intake

Process one captured intake item end to end: read the source record, decide where it
belongs, make the smallest correct change in the destination namespace, and write a
processed receipt that records what happened and links back to the source. This skill is
the executable technique. The doctrine for why intake is a root OS layer and where the
three-layer boundary sits lives in the playbook
[[knowledge-ai-architecture-process-namespace-intake]]; the operative contract for what
intake may write into git lives in [[namespace-intake-rules]]. Run the technique, obey
the rules, reason from the playbook.

## Use when

- an item sits in `intake/sources/<family>/` with a routing decision still open
- a captured source record (X post, YouTube video, web page, repo, email, idea, research
  brief) needs to become a durable change in a namespace or be deliberately discarded
- you are clearing intake during a weekly review or a dedicated intake-review session
- a destination namespace exists or is warranted and the item carries enough signal to
  earn a home

## Do not use when

- the item is still being captured and has no source record yet (capture first)
- the item is live queue state belonging to the connector layer (out of git, G1)
- the item should spawn a whole new namespace from scratch (use [[skill-build-namespace]]
  first, then process the item into it)
- you are doing bulk freshness or contradiction sweeps rather than processing one item
- the change is large derived synthesis across namespaces (use
  [[skill-cross-synthesize-corpus]])

## Goal

Move a single high-signal item from raw capture into a durable home with a full audit
trail, or discard it with a recorded reason, so the same item never has to be triaged
twice and the destination namespace owns the truth (intake never owns truth).

## Required outputs

1. A routing decision recorded for the item: candidate destinations, score, chosen
   destination, rationale, operator approval state. Follows the routing-decision schema in
   `intake/schemas/routing-decision.md`.
2. The destination change itself: a new or updated file in the chosen namespace, landing
   in the correct surface (`support/` for provenance, `synthesis/` for derived reading,
   `archive/` for preserved source, a knowledge node for a settled fact, or nothing).
3. A processed receipt at `intake/processed/<family>/` (and mirrored under
   `intake/destinations/<namespace>/processed/` when the namespace tracks its own trail)
   following `intake/schemas/processed-receipt.md`. The receipt links back to the source
   record.

## Build steps

1. Read the source record in `intake/sources/<family>/`. Confirm it carries source
   platform, creator or sender, original URL or message id, ingest timestamp, raw capture
   location, an extracted summary, and why it matters. If the summary or why-it-matters is
   thin, apply [[skill-summarize-source]] to distill it before routing.
2. Score and route. Read `intake/routing/scoring-model.md` and
   `intake/routing/destination-rules.md`. Name the candidate destinations, score the item,
   pick the destination, and write the rationale. If no destination clears the bar, the
   correct decision is discard with a recorded reason.
3. Set operator approval state per [[namespace-intake-rules]]. Low-confidence or
   cross-namespace routes wait for operator approval; high-confidence single-namespace
   routes may proceed.
4. Make the destination change at the right altitude on the promotion path
   ([[promotion-path-rules]]): raw source goes to `archive/`, provenance to `support/`, a
   derived reading to `synthesis/`, a settled and operator-trusted fact to a knowledge
   node. Do not write a canon node directly from intake; canon is operator-approved
   synthesis, not a landing zone.
5. Write the processed receipt. Record what came in, why it mattered, what was done,
   whether it changed archive, support, synthesis, canon, or nothing, which files were
   created or updated, what remains unresolved, and a link back to the source record.
6. Hand any unresolved residue forward. If the item surfaced a contradiction, note it for
   [[contradiction-review-rules]]. If it is a canon candidate, mark it for the promotion
   path rather than promoting it here.

## Quality checks

- the routing decision names a chosen destination and a rationale, not just candidates
- the processed receipt links back to the source record and is not missing a destination
  link (validate.sh treats a receipt with no routing decision or destination link as an
  error in `intake/`)
- the destination change landed in the correct surface per the promotion path: no
  provenance in `synthesis/`, no derived reading in `support/`, no raw source as a node
- nothing was written to canon directly from intake
- no live queue state was committed to git
- run `bash _system/validate.sh` and clear any intake completeness error before closing

## Anti-patterns

- processing an item with no recorded routing decision, so the next session re-triages it
- writing the change but skipping the receipt, breaking the audit trail
- promoting straight into canon because the item felt important
- letting intake own the truth instead of handing it to the destination namespace
- treating discard as failure: a recorded discard with a reason is a complete outcome
