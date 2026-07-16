# Playbook: Process an Email Item

How to take one captured item from email (a saved message, newsletter, thread, or forwarded
message) from capture through to a processed receipt. This is the procedure for the `email`
source family.

This playbook pairs with a connector-side email ingest capability, which pulls explicitly-saved email (a
`to-brain` label/folder or a starred message) into an inbox in batches. Connector-side capture (offline `.eml` import
or live IMAP fetch, dedupe, and where captures land) is yours to wire: no capture connector
ships in this starter, and a connector suite is the planned next release. This playbook handles what the intake fabric does with each item once it is captured:
extract, route, and write the receipt.

Records produced follow these schemas:

- captured item: `../schemas/intake-record.md`
- routing call: `../schemas/routing-decision.md`
- work done: `../schemas/processed-receipt.md`

Routing logic lives in `../routing/destination-rules.md`, `../routing/scoring-model.md`, and
`../routing/namespace-routing-map.md`.

## When to run

- After your email connector has pulled new saved email into the inbox.
- When you save a single message by hand and want it captured durably.

## Boundary

The email connector (the IMAP fetch, the capture folder selection, and the live unprocessed
queue) stays in the operational app layer. This playbook starts at a captured item and ends at
a durable receipt. It does not touch credentials or connectors. The full message body stays in
the mailbox: the capture holds only a length-capped excerpt and the `Message-ID` reference, so
this playbook reasons over the excerpt and summary, not a copied private body.

## Procedure

### Step 1: Confirm the capture as an intake record

The connector writes one intake record per saved message to `../sources/email/`, shaped by
`../schemas/intake-record.md`. Confirm it, or write it by hand for a single saved message.

- `source` is `email`. `creator` is the sender address (or display name).
- `original_ref` and `raw_capture` are `mid:<Message-ID>`, the pointer back to the mailbox.
- `received_at` is the capture timestamp, ISO 8601.
- `summary` is the subject (one line) and `why_it_matters` is why it earns attention.
- Filename and `id`: `intake-email-<date>-<slug>-<id6>`.
- Do not copy the full private body into git; the capped excerpt the connector wrote is enough.

### Step 2: Extract the signal

Read the captured excerpt and subject and extract the distinct, load-bearing claims or the
concrete ask. Email varies widely: a newsletter may carry one or two reusable ideas; a thread
may carry a decision or an action; a forwarded message may carry a reference. A claim qualifies
if it is a specific position, a named technique, a decision, a commitment, or a worldview signal
worth keeping. Marketing filler, receipts, and notifications usually do not qualify and route to
rejection.

Write the extracted claims or the action into the `## Extracted summary` section of the intake
record. Keep each to a sentence or two. If the real signal is in the full body beyond the
excerpt, note that the full message is in the mailbox by `Message-ID` rather than copying it in.

### Step 3: Route the item

Apply `../routing/scoring-model.md` first: decide whether the item clears the threshold or is
rejected. If it clears, apply `../routing/destination-rules.md` decision order to pick one of the
five destinations (knowledge namespace, project, workflow, action queue, rejection). For a
knowledge destination, pick the namespace with `../routing/namespace-routing-map.md`. Email items
often route to an action queue (a reply or task), a project, or a knowledge namespace as cited
support; newsletters most often route to a thinker or domain namespace or to rejection.

Write one routing decision to `../sources/email/` (alongside the intake record), shaped by
`../schemas/routing-decision.md`. Record every candidate considered, the score, the chosen
destination, the rationale, and `approval_state`. Most knowledge routes start `pending` for
operator approval; rejections and clear action-queue items can be `auto`.

### Step 4: Do the work and write the receipt

Once the destination is approved (or auto), do the work: add a provenance entry to the target
namespace `support/`, draft a `synthesis/` note, add a task to a project, hand it to a workflow,
queue an action, or record the rejection. Intake never writes canon directly; the most an email
item does to canon is seed a canon-candidate in `synthesis/` for later operator promotion.

Write one processed receipt to `../processed/email/`, shaped by `../schemas/processed-receipt.md`.
Record what came in, why it mattered, what was done, the single `layer_changed` value, the
`files_touched` paths, what remains unresolved, and links back to the source record and routing
decision. If the destination was a knowledge namespace, also add a pointer under
`../namespaces/<ns>/processed/`.

## Quality checks

- One intake record, one routing decision, one receipt per worked item, sharing the same
  `email-<date>-<slug>` stem.
- The receipt's `routing_decision` and `source_record` both resolve.
- `layer_changed` matches what actually changed; `files_touched` is non-empty unless
  `layer_changed` is `none`.
- No live queue status anywhere in git. No em dashes, no en dashes. No full private body copied
  into git beyond the capped excerpt.

## Anti-patterns

- Copying a full private email body into the record instead of pointing `raw_capture` at the
  `Message-ID`.
- Writing a knowledge node straight from an email without a routing decision and receipt.
- Treating a rejection as a non-event: rejections still get a routing decision with a reason.
- Capturing or processing the whole inbox instead of the explicitly-saved subset.
