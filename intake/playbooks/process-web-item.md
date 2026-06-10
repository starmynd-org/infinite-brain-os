# Playbook: Process a Web Item

How to take one captured web page (article, blog post, documentation, landing page) from
capture through to a processed receipt. This is the procedure for the `web` source family.

This playbook aligns with the `ingest-web` skill, which fetches a URL, writes a web capture,
extracts atomic notes, and can synthesize across multiple pages. That skill is the extraction
engine. This playbook frames that work inside the intake fabric: capture as an intake record,
route the signal, and write the receipt.

Records produced follow these schemas:

- captured item: `../schemas/intake-record.md`
- routing call: `../schemas/routing-decision.md`
- work done: `../schemas/processed-receipt.md`

Routing logic lives in `../routing/destination-rules.md`, `../routing/scoring-model.md`, and
`../routing/namespace-routing-map.md`.

## When to run

- After you have a URL worth keeping and want it captured durably.
- When `ingest-web` has produced a web capture and atoms you want to route.

## Boundary

Fetching the page (WebFetch, paste-on-paywall) is connector and runtime work. This playbook
starts at a captured page and ends at a durable receipt.

## Procedure

### Step 1: Capture the page as an intake record

Write one intake record to `../sources/web/`, shaped by `../schemas/intake-record.md`.

- `source` is `web`. `creator` is the author or, when no author, the publication. `original_ref`
  is the full URL.
- `received_at` is the capture timestamp, ISO 8601.
- Save the cleaned page body (navigation, ads, and footer stripped) under `../sources/web/raw/`
  and point `raw_capture` at it. If the page needed JavaScript or was paywalled and you pasted
  the text, note that in the record.
- `summary` is the page's core message in one line. `why_it_matters` is the signal.
- Filename and `id`: `intake-web-<date>-<slug>`. Use a simplified domain in the slug where it
  helps (for example `simonwillison` or `langchain`).

### Step 2: Extract the signal

Run the `ingest-web` extraction shape: read the cleaned content and pull each distinct,
actionable insight as a separate claim. A claim qualifies if it is a data-backed claim, a
technique or best practice, a tool comparison, a benchmark, a contrarian take with reasoning,
or a design decision with rationale. Author bio, boilerplate, and calls to action do not
qualify. Aim for three to fifteen real claims depending on density; for documentation, focus
on architecture decisions and novel patterns, not API reference detail.

Record the load-bearing claims in the `## Extracted summary` section of the intake record.
Distinguish opinion and speculation from data-backed claims.

### Step 3: Route the item

Apply `../routing/scoring-model.md` to decide route or reject. If it clears, apply
`../routing/destination-rules.md` decision order to pick one of the five destinations. For a
knowledge destination, pick the namespace with `../routing/namespace-routing-map.md`. Web items
spread widely: technique and architecture pages route to `ai-architecture`, positioning and
landing-page analysis to `example-marketing`, thinker essays to the matching thinker
namespace, and content-relevant pages to a content workflow.

Write one routing decision to `../sources/web/`, shaped by `../schemas/routing-decision.md`.

### Step 4: Do the work and write the receipt

Do the routed work, then write one processed receipt to `../processed/web/`, shaped by
`../schemas/processed-receipt.md`. Record what came in, why it mattered, what was done, the
single `layer_changed` value, `files_touched`, what is unresolved, and links back to the source
record and routing decision. Add a pointer under `../namespaces/<ns>/processed/` when the
destination was a knowledge namespace.

## Quality checks

- The cleaned page body lives in `raw_capture`, not inline in the record body.
- One intake record, one routing decision, one receipt, sharing the `web-<date>-<slug>` stem.
- The receipt's links resolve and `layer_changed` matches reality.
- No live queue status in git. No em dashes, no en dashes.

## Anti-patterns

- Storing the raw HTML with navigation and ads intact instead of a cleaned body.
- Routing a documentation page as new doctrine when it is reference detail that belongs in a
  tool-contract namespace, not the doctrine canon.
- Skipping the rejection path for low-signal marketing pages; record them as rejected with a
  reason.
