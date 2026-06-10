# Namespace Intake Rules

Operative rules for how a namespace consumes intake and what intake is allowed to write
into git. This file is the operative contract. The reasoning lives in
[[intake-fabric-namespace]] (why intake is a root OS layer) and [[process-namespace-intake]]
(the procedure an agent runs to process an item into a namespace).

Scope: contract Part 5. This file governs the durable layer (`intake/` in git) and the
boundary at which intake hands an item to a destination namespace. It does not govern the
connector and runtime layer; that stays in the operational app.

## The three-layer split (locked, G1)

Intake is split into three layers. The split is the reason no live queue state ever
enters git.

1. Connector and runtime layer. OAuth, polling, token refresh, and live queue state.
   Lives in the operational app (for example a small FastAPI connector app). NOT in
   git. NOT scaffolded as tracked folders.
2. Durable intake layer. Lives in git at `intake/`. Holds captured source records,
   processed receipts, routing decisions, routing doctrine, and per-source playbooks.
   This is the durable trail of what came in and what was done with it.
3. Knowledge layer. Lives in `knowledge/`. Holds only distilled doctrine, decisions,
   playbooks, and receipts produced from intake. The destination namespace owns the
   durable canon. Intake never owns truth.

Rule INTAKE-1: an intake item that has been processed produces a durable record in layer
2 and, when it carries signal worth keeping, distilled material in layer 3. An item that
carries no signal still produces a layer-2 receipt routed to nothing. Nothing is
processed silently.

## No live queue state in git (locked)

Rule INTAKE-2: git holds receipts, not queues. The folders `unprocessed`, `in-review`,
and `blocked` are operational state owned by the runtime app and are NOT tracked git
folders. Committing a live queue turns git into a runtime database and produces churn,
conflicts, and stale state.

A receipt is a settled record of a processed item. A queue is mutable runtime state that
changes many times before settling. Only receipts and routing doctrine enter git.

Enforcement: validate.sh enforces the intake schema-completeness checks below
(deterministic). The absence of live-queue folders is a convention the intake README
documents and a reviewer confirms; validate.sh does not scan for forbidden folder names.

## How a namespace consumes intake

Rule INTAKE-3: a namespace consumes intake only through the promotion path, never by
adopting raw captures as nodes. The path is: raw source (archive or intake) to support
(provenance recorded) to synthesis (derived reading) to canon-candidate to canon
(operator-approved). A raw captured item is never dropped straight into `canon/` or
treated as a finished knowledge node.

Rule INTAKE-4: the destination namespace owns the truth. When intake routes an item into
`knowledge/<ns>/`, the resulting node carries that namespace's frontmatter, lives in that
namespace's folders (`support/`, `synthesis/`, `concepts/`, `decisions/`, `playbooks/`,
`canon/`), and is governed by that namespace's review posture. Intake does not write
canon.

Rule INTAKE-5: a thin `knowledge/<intake-name>/` namespace may hold only distilled intake
doctrine, decisions, playbooks, and receipts. It never holds connectors or live queues.
It is Profile H expressed as a thin knowledge surface, not the durable `intake/` trail.

## The processed-receipt requirement (locked)

Rule INTAKE-6: every processed intake item produces a processed receipt in
`intake/processed/<source>/` (or `intake/destinations/<ns>/processed/` for a per-namespace
trail). A receipt is mandatory even when the item is routed to nothing. The receipt is
the proof that the item was seen and triaged.

Required fields in a processed receipt (schema of record: `intake/schemas/processed-receipt.md`):

- what came in (one-line description of the captured item)
- why it mattered (the signal, or "no signal" with a reason)
- what was done (the action taken)
- what changed: one of `archive`, `support`, `synthesis`, `canon`, or `nothing`
- files created or updated (relative paths, or "none")
- what remains unresolved (open follow-ups, or "none")
- link back to the source record (the intake-record file this receipt processes)

Rule INTAKE-7: a processed receipt that records a route to a destination must carry a
matching routing decision. validate.sh treats a processed receipt missing a routing
decision or destination link as an ERROR in the `intake/` tree (deterministic, contract
Part 7.3). A receipt routed to `nothing` is valid without a destination link.

## Record schemas (operative contract)

Three record contracts live in `intake/schemas/`. They are the operative shape; this file
governs how namespaces consume them.

- Intake record (`intake-record.md`): one captured item. Fields: source platform, creator
  or sender, original URL or message id, ingest timestamp, raw capture location, extracted
  summary, why it matters.
- Routing decision (`routing-decision.md`): candidate destinations, score, chosen
  destination, rationale, operator approval state.
- Processed receipt (`processed-receipt.md`): the fields in INTAKE-6.

Rule INTAKE-8: intake-record stub ids use the form `intake-<source>-<date>-<slug>`. Timestamps
on intake stubs use full ISO form (`received_at: "2026-05-30T11:15:00Z"`); namespace nodes
use date-only `created`.

## What validate.sh enforces vs what a curator decides

Deterministic (validate.sh, contract Part 7.3):

- a processed receipt missing a routing decision or destination link is an ERROR (except
  receipts routed to `nothing`)
- the intake tree is exempt from node-frontmatter checks EXCEPT the schema-completeness
  checks above
- the em and en dash ban applies to every `.md` in `intake/`

Fuzzy (curator agent, not validate.sh):

- whether a captured item actually carries signal worth promoting
- which destination namespace is correct when several are plausible
- whether a routed item should stop at support, advance to synthesis, or become a
  canon-candidate
- whether an item routed to `nothing` was triaged correctly

## Migration posture (the initial build)

Rule INTAKE-9: the initial build builds the `intake/` scaffold and writes migration plans. It
does not perform a live cutover. The the connector app connector stays external (app
layer). Its processed ledger and routing doctrine migrate into `intake/`; raw archives
stay archived; distilled patterns move into `intake/playbooks/` and `intake/schemas/`.

## Notes

The why lives in [[intake-fabric-namespace]]. The per-item procedure lives in
[[process-namespace-intake]]. This file is the rule layer between them: it states what
must be true of the durable `intake/` trail and of any node a namespace accepts from
intake. When a rule here and the reasoning node disagree, the reasoning node should be
corrected or this file should be, never silently diverged.
