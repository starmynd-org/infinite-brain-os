# Playbook: Process a Research Item

How to take one AI-guided deep research item from capture through to a processed receipt. This
is the procedure for the `ai-research` source family.

A research item is different from the other source families. The others capture one external
artifact (a post, a video, a page, a repo). A research item is a synthesized output: the
operator poses a question, an AI research harness fans out across many sources, verifies
claims, and returns a cited report. The cited report is the captured artifact, and the
underlying sources are its provenance.

This playbook aligns with the deep-research harness shape: fan out web searches, fetch sources,
verify claims adversarially, then synthesize a cited report. The harness is the extraction
engine. This playbook frames that output inside the intake fabric: capture the report as an
intake record, route its findings, and write the receipt.

Records produced follow these schemas:

- captured item: `../schemas/intake-record.md`
- routing call: `../schemas/routing-decision.md`
- work done: `../schemas/processed-receipt.md`

Routing logic lives in `../routing/destination-rules.md`, `../routing/scoring-model.md`, and
`../routing/namespace-routing-map.md`.

## When to run

- After an AI research run returns a cited report on a question the operator posed.
- When a multi-source synthesis is worth keeping and routing into the brain.

## Boundary

The research harness (search fan-out, source fetching, verification, model calls) is connector
and runtime work. This playbook starts at a completed cited report and ends at a durable
receipt. The harness does not run inside the intake fabric; its output flows in.

## Procedure

### Step 1: Capture the report as an intake record

Write one intake record to `../sources/ai-research/`, shaped by `../schemas/intake-record.md`.

- `source` is `ai-research`. `creator` is the harness or model that produced the report, plus
  the operator who posed the question (for example `"deep-research harness, posed by
  the-operator"`). `original_ref` is a link to the run, or `"local research run"` when there
  is no external URL.
- `received_at` is the time the report was produced, ISO 8601.
- Save the full cited report and its source list under `../sources/ai-research/raw/` and point
  `raw_capture` at it. The report can be long; do not inline it in the record body.
- `summary` is the research question and its headline answer in one line. `why_it_matters` is
  why the operator asked and what it unblocks.
- Filename and `id`: `intake-research-<date>-<slug>`.

### Step 2: Extract the signal

Read the cited report and pull each verified, load-bearing finding as a separate claim. A
finding qualifies if it is a verified answer to a sub-question, a strongly-cited claim, a clear
consensus or disagreement across sources, or a named open question the report could not close.
Treat the report's own confidence and citations as part of the signal: a finding cited by three
sources is stronger than one cited by an unverified blog. Carry the citation with the claim so
provenance survives.

Record the load-bearing findings in the `## Extracted summary` section of the intake record,
each with its source citation. Note disagreements explicitly; they often route to `synthesis/`.

### Step 3: Route the item

Apply `../routing/scoring-model.md` to decide route or reject. If it clears, apply
`../routing/destination-rules.md` decision order. A research report rarely routes to a single
destination: its findings split. The common pattern is route the synthesized reading to the
owning namespace `synthesis/` (it is derived thinking, not raw source), record the cited
sources as provenance in `support/`, and feed any scoped action into a project. Pick the
namespace with `../routing/namespace-routing-map.md`. Cross-namespace findings route to the
repo-root `synthesis/` rather than to one namespace.

Write one routing decision to `../sources/ai-research/`, shaped by
`../schemas/routing-decision.md`. When findings genuinely split across destinations, write one
routing decision per destination and let all of them share the research item's stem.

### Step 4: Do the work and write the receipt

Do the routed work, then write one processed receipt to `../processed/ai-research/`, shaped by
`../schemas/processed-receipt.md`. Because research items usually touch `support` (sources) and
`synthesis` (the reading), set `layer_changed` to the most significant durable change
(`synthesis` when a reading was written) and list every file in `files_touched`. Record what
came in, why it mattered, what was done, what is unresolved (open questions the report named),
and links back to the source record and routing decisions. Add a pointer under
`../namespaces/<ns>/processed/` for each namespace touched.

A research finding never lands directly in `canon`. The strongest path is a canon-candidate in
`synthesis/` that the operator promotes later in the monthly canon review.

## Quality checks

- The full cited report and source list live in `raw_capture`, not inline.
- Citations travel with each extracted finding so provenance survives routing.
- One intake record, one or more routing decisions (one per destination on a split), one
  receipt, sharing the `research-<date>-<slug>` stem.
- The receipt's links resolve and `layer_changed` matches the most significant durable change.
- No live queue status in git. No em dashes, no en dashes.

## Anti-patterns

- Routing a research finding straight into canon without the operator promotion step.
- Dropping citations during extraction, leaving claims with no provenance.
- Forcing a multi-finding report into one destination when its findings clearly split.
