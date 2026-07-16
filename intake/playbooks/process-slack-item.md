# Playbook: Process a Slack Item

How to take one captured item from Slack (a saved message, shared link, or thread) from capture
through to a processed receipt. This is the procedure for the `slack` source family.

This playbook pairs with a connector-side Slack ingest capability, which pulls explicitly-saved Slack messages
(reacted with a trigger emoji or shared into a to-brain channel) into an inbox in batches. Connector-side capture
(offline JSON import or live fetch, dedupe, and where captures land) is yours to wire: no
capture connector ships in this starter, and a connector suite is the planned next release. This playbook handles what the intake fabric does with each item once it is
captured: extract, route, and write the receipt.

Records produced follow these schemas:

- captured item: `../schemas/intake-record.md`
- routing call: `../schemas/routing-decision.md`
- work done: `../schemas/processed-receipt.md`

Routing logic lives in `../routing/destination-rules.md`, `../routing/scoring-model.md`, and
`../routing/namespace-routing-map.md`.

## When to run

- After your Slack connector has pulled new saved messages into the inbox.
- When you save a single Slack message or thread by hand and want it captured durably.

## Boundary

The Slack connector (the live API fetch, the reaction or channel selection, and the live channel
state) stays in the operational app layer. This playbook starts at a captured item and ends at a
durable receipt. It does not touch tokens or connectors. The full thread stays in Slack: the
capture holds only a length-capped excerpt and the permalink, so this playbook reasons over the
excerpt and summary, not a copied private thread.

## Procedure

### Step 1: Confirm the capture as an intake record

The connector writes one intake record per saved message to `../sources/slack/`, shaped by
`../schemas/intake-record.md`. Confirm it, or write it by hand for a single saved message.

- `source` is `slack`. `creator` is the sender's display name.
- `original_ref` and `raw_capture` are the Slack permalink, the pointer back to the message.
- `received_at` is the capture timestamp, ISO 8601.
- `summary` is a one-line, mrkdwn-rendered extract; `why_it_matters` is why it earns attention.
- Filename and `id`: `intake-slack-<date>-<slug>-<id6>`.
- When the value is in a thread, note that the full thread is in Slack by permalink rather than
  copying it in. Do not copy a long or private thread into the record body.

### Step 2: Extract the signal

Read the captured excerpt and extract the distinct, load-bearing claims or the concrete ask.
Slack is short-form and conversational, so expect a decision, a commitment, a named idea, or a
shared reference. A claim qualifies if it is a specific position, a decision, an action, a named
technique, or a worldview signal worth keeping. Status pings, reactions-only, and channel noise
do not qualify and route to rejection.

Write the extracted claims or the action into the `## Extracted summary` section of the intake
record. Keep each to a sentence or two. If the real signal is in the thread beyond the excerpt,
note that the full thread is in Slack by permalink.

### Step 2.5: Enrich with operator detail before creating a task or project

A raw Slack message is usually a thin seed, not a finished task. Before turning a capture into a
task or a project, surface the raw capture to the operator and solicit the additional detail and
scope that only they hold, then layer that enrichment on top of the capture. The raw capture stays
as provenance (what was actually said); the enriched task or project PLAN is the operator-scoped
version derived from it.

- Show the operator the raw line and ask: what is the real scope, who owns it, which department,
  and what are the acceptance criteria.
- If the enriched scope is project-sized, scope it as a `projects/<name>/PLAN.md` owned by the
  right department rather than a one-line task (worked example: a one-line
  inventory-tooling capture became a scoped project PLAN owned by the operations
  department).
- Record the enrichment in the routing decision (the operator detail and the chosen owner), and
  point the resulting task/PLAN back at the source capture.

This enrichment step is a general intake pattern, not Slack-specific; promote it to the shared
routing doctrine so every `process-<lane>-item` playbook applies it.

### Step 3: Route the item

Apply `../routing/scoring-model.md` first: decide whether the item clears the threshold or is
rejected. If it clears, apply `../routing/destination-rules.md` decision order to pick one of the
five destinations (knowledge namespace, project, workflow, action queue, rejection). For a
knowledge destination, pick the namespace with `../routing/namespace-routing-map.md`. Slack items
often route to an action queue (a task or follow-up), a project, or a knowledge namespace as cited
support.

Write one routing decision to `../sources/slack/` (alongside the intake record), shaped by
`../schemas/routing-decision.md`. Record every candidate considered, the score, the chosen
destination, the rationale, and `approval_state`. Most knowledge routes start `pending` for
operator approval; rejections and clear action-queue items can be `auto`.

### Step 4: Do the work and write the receipt

Once the destination is approved (or auto), do the work: add a provenance entry to the target
namespace `support/`, draft a `synthesis/` note, add a task to a project, hand it to a workflow,
queue an action, or record the rejection. Intake never writes canon directly; the most a Slack
item does to canon is seed a canon-candidate in `synthesis/` for later operator promotion.

Write one processed receipt to `../processed/slack/`, shaped by `../schemas/processed-receipt.md`.
Record what came in, why it mattered, what was done, the single `layer_changed` value, the
`files_touched` paths, what remains unresolved, and links back to the source record and routing
decision. If the destination was a knowledge namespace, also add a pointer under
`../namespaces/<ns>/processed/`.

## Quality checks

- One intake record, one routing decision, one receipt per worked item, sharing the same
  `slack-<date>-<slug>` stem.
- The receipt's `routing_decision` and `source_record` both resolve.
- `layer_changed` matches what actually changed; `files_touched` is non-empty unless
  `layer_changed` is `none`.
- No live channel status anywhere in git. No em dashes, no en dashes. No full private thread
  copied into git beyond the capped excerpt.

## Anti-patterns

- Copying a full private thread into the record instead of pointing `raw_capture` at the permalink.
- Writing a knowledge node straight from a Slack message without a routing decision and receipt.
- Treating a rejection as a non-event: rejections still get a routing decision with a reason.
- Capturing or processing whole channels instead of the explicitly-saved subset.
