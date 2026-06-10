# Playbook: Process an X Item

How to take one captured item from X (a post, thread, bookmark, quote tweet, or reply) from
capture through to a processed receipt. This is the procedure for the `x` source family.

This playbook aligns with the `ingest-bookmarks` skill, which pulls exported X bookmarks into
an inbox in batches. That skill handles connector-side capture (export and ingest). This
playbook handles what the intake fabric does with each item once it is captured: extract,
route, and write the receipt.

Records produced follow these schemas:

- captured item: `../schemas/intake-record.md`
- routing call: `../schemas/routing-decision.md`
- work done: `../schemas/processed-receipt.md`

Routing logic lives in `../routing/destination-rules.md`, `../routing/scoring-model.md`, and
`../routing/namespace-routing-map.md`.

## When to run

- After `ingest-bookmarks` has pulled new X bookmarks into the inbox.
- When you save a single X thread by hand and want it captured durably.

## Boundary

The X connector (the exporter, polling, and the live unprocessed queue) stays in the
operational app layer. This playbook starts at a captured item and ends at a durable receipt.
It does not touch tokens or connectors.

## Procedure

### Step 1: Capture the item as an intake record

Write one intake record per item to `../sources/x/`, shaped by `../schemas/intake-record.md`.

- `source` is `x`. For a thread, capture the whole thread, not just the first post.
- `creator` is the X handle. `original_ref` is the post or thread URL.
- `received_at` is the capture timestamp, ISO 8601.
- Save the raw text (the full thread) under `../sources/x/raw/` and point `raw_capture` at it.
  Do not paste a long thread into the record body; quote only the load-bearing lines.
- Fill `summary` (one line of what it says) and `why_it_matters` (why it is worth attention).
- Filename and `id`: `intake-x-<date>-<slug>`.

### Step 2: Extract the signal

Read the captured thread and extract the distinct, load-bearing claims. X is short-form, so
expect one to three real claims per thread. A claim qualifies if it is a specific position,
a contrarian take with reasoning, a named technique, or a worldview signal from someone worth
tracking. Subscribe requests, replies-to-self filler, and engagement bait do not qualify.

Write the extracted claims into the `## Extracted summary` section of the intake record. Keep
each claim to a sentence or two. Note the creator's reasoning, not just the conclusion.

### Step 3: Route the item

Apply `../routing/scoring-model.md` first: decide whether the item clears the threshold or is
rejected. If it clears, apply `../routing/destination-rules.md` decision order to pick one of
the five destinations (knowledge namespace, project, workflow, action queue, rejection). For a
knowledge destination, pick the namespace with `../routing/namespace-routing-map.md`. X items
most often route to `ai-architecture`, `example-marketing`, or a thinker namespace as cited
support or a synthesis input.

Write one routing decision to `../sources/x/` (alongside the intake record), shaped by
`../schemas/routing-decision.md`. Record every candidate considered, the score, the chosen
destination, the rationale, and `approval_state`. Most knowledge routes start `pending` for
operator approval; rejections and clear workflow inputs can be `auto`.

### Step 4: Do the work and write the receipt

Once the destination is approved (or auto), do the work: add a provenance entry to the target
namespace `support/`, draft a `synthesis/` note, add a task to a project, hand it to a
workflow, or record the rejection. Intake never writes canon directly; the most an X item does
to canon is seed a canon-candidate in `synthesis/` for later operator promotion.

Write one processed receipt to `../processed/x/`, shaped by `../schemas/processed-receipt.md`.
Record what came in, why it mattered, what was done, the single `layer_changed` value, the
`files_touched` paths, what remains unresolved, and links back to the source record and routing
decision. If the destination was a knowledge namespace, also add a pointer under
`../namespaces/<ns>/processed/`.

## Quality checks

- One intake record, one routing decision, one receipt per worked item, sharing the same
  `x-<date>-<slug>` stem.
- The receipt's `routing_decision` and `source_record` both resolve.
- `layer_changed` matches what actually changed; `files_touched` is non-empty unless
  `layer_changed` is `none`.
- No live queue status anywhere in git. No em dashes, no en dashes.

## Anti-patterns

- Pasting a whole thread into the record body instead of pointing `raw_capture` at the raw file.
- Writing a knowledge node straight from an X post without a routing decision and receipt.
- Treating a rejection as a non-event: rejections still get a routing decision with a reason.
