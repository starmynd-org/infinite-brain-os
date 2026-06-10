# Playbook: Process a YouTube Item

How to take one captured YouTube video from capture through to a processed receipt. This is
the procedure for the `youtube` source family.

This playbook aligns with the `ingest-youtube` skill and the local runtime in
`tools/youtube_ingest/`, which take a video URL plus transcript, write a video capture, and
extract atomic notes. The skill and tool are the extraction engine. This playbook frames that
work inside the intake fabric: capture as an intake record, route the signal, and write the
receipt.

Records produced follow these schemas:

- captured item: `../schemas/intake-record.md`
- routing call: `../schemas/routing-decision.md`
- work done: `../schemas/processed-receipt.md`

Routing logic lives in `../routing/destination-rules.md`, `../routing/scoring-model.md`, and
`../routing/namespace-routing-map.md`.

## When to run

- After you have a video URL and its transcript and want it captured durably.
- When `ingest-youtube` or `python -m tools.youtube_ingest` has produced a video capture and
  atoms you want to route.

## Boundary

Transcript fetching and any video polling stay in the connector and runtime layer. This
playbook starts at a captured video and ends at a durable receipt.

## Procedure

### Step 1: Capture the video as an intake record

Write one intake record to `../sources/youtube/`, shaped by `../schemas/intake-record.md`.

- `source` is `youtube`. `creator` is the channel name. `original_ref` is the video URL.
- `received_at` is the capture timestamp, ISO 8601.
- Save the transcript under the per-video workspace in `../sources/youtube/<channel>/<date-title>/`
  and point `raw_capture` at the transcript JSON. The transcript can be long; never inline it in
  the record body.
- `summary` is the video's core message in one line. `why_it_matters` is the signal in one or
  two lines.
- Filename and `id`: `intake-youtube-<date>-<slug>`.

### Step 2: Extract the signal

Run the `ingest-youtube` extraction shape: read the transcript and pull each distinct,
actionable insight as a separate claim. The local runtime now creates atom nodes automatically in
the per-video workspace. A claim qualifies if it is a specific recommendation, a tool or product
evaluation, a workflow tip, a benchmark, or a contrarian take with reasoning. Channel promotion,
sponsor reads, and filler do not qualify. Expect five to twenty real claims in a dense video.

Record the extracted claims in the `## Extracted summary` section of the intake record, or, if
the volume is high, keep the atoms in the raw capture area and summarize the load-bearing ones
in the record. Handle transcript artifacts gracefully (for example "cloud code" means "Claude
Code").

### Step 3: Route the item

Apply `../routing/scoring-model.md` to decide route or reject. If it clears, apply
`../routing/destination-rules.md` decision order to pick one of the five destinations. For a
knowledge destination, pick the namespace with `../routing/namespace-routing-map.md`. YouTube
items commonly route to `ai-architecture` (technique and agent patterns), to a content workflow
(newsletter or post fuel), or to a project when the insight is scoped to one outcome.

A single video can split: some claims route to knowledge, one claim feeds a workflow. When that
happens, the chosen destination is the dominant route and the receipt's `unresolved` field
notes the secondary handoff, or write a second routing decision for the split claim.

Write one routing decision to `../sources/youtube/`, shaped by `../schemas/routing-decision.md`.

### Step 4: Do the work and write the receipt

Do the routed work, then write one processed receipt to `../processed/youtube/`, shaped by
`../schemas/processed-receipt.md`. Record what came in, why it mattered, what was done, the
single `layer_changed` value, `files_touched`, what is unresolved, and links back to the source
record and routing decision. Add a pointer under `../namespaces/<ns>/processed/` when the
destination was a knowledge namespace.

## Quality checks

- The transcript lives in `raw_capture`, not in the record body.
- One intake record, one (or more, for splits) routing decision, one receipt, sharing the
  `youtube-<date>-<slug>` stem.
- The receipt's links resolve and `layer_changed` matches reality.
- No live queue status in git. No em dashes, no en dashes.

## Anti-patterns

- Capturing the video but never extracting the atoms, leaving the signal locked in a transcript.
- Routing every interesting claim to knowledge when several are workflow fuel.
- Writing a receipt before the work is actually done.
