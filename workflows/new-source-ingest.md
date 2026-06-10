---
id: "workflow-new-source-ingest"
aliases: ["workflow-new-source-ingest", "new-source-ingest"]
type: "Workflow"
namespace: "personal-operator"
lifecycle_state: "research"
summary: "Ingest a new source (X, YouTube, web, repo, research) into the durable intake layer with a source-aware record, then hand off to namespace intake review for routing."
confidence: 0.85
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[agent-intake-router]]"
    relation: "uses"
    confidence: 0.85
  - target: "[[skill-process-namespace-intake]]"
    relation: "uses"
    confidence: 0.85
  - target: "[[namespace-intake-review]]"
    relation: "depends_on"
    confidence: 0.9
  - target: "[[process-namespace-intake]]"
    relation: "informed_by"
    confidence: 0.85
  - target: "[[namespace-intake-rules]]"
    relation: "governed_by"
    confidence: 0.9
  - target: "[[intake-fabric-namespace]]"
    relation: "informed_by"
    confidence: 0.85
  - target: "[[migration-compatibility-rules]]"
    relation: "references"
    confidence: 0.7
created: "2026-05-30"
runtime: "agentic"
---

# Workflow: New Source Ingest

A capture pipeline for getting a new inbound source into the durable intake layer correctly,
then handing off for routing. This workflow is the front door of the intake fabric. It writes
a source-aware intake record, never routes the item itself, and ends by invoking
[[namespace-intake-review]] to do the routing and receipt-writing. It aligns with the existing
project-side ingest skills (ingest-bookmarks, ingest-youtube, ingest-web, ingest-repo) and the
intake source playbooks; those skills do platform-specific fetching, this workflow standardizes
where their output lands and what shape it carries.

## When to run

- When a new item arrives that is worth capturing: an X bookmark, a YouTube video, a web page,
  a GitHub repo, an email, a Slack message, an idea, or an AI-guided research result.
- When an existing ingest skill (ingest-youtube, ingest-web, ingest-repo, ingest-bookmarks)
  has fetched raw content and you need it placed into `intake/sources/` with a conformant
  record before it can be routed.
- Not for items that already have a clear durable home; write those directly with
  [[skill-build-knowledge-node]] and skip intake.

## Inputs

- The source item: a URL, a message id, a file, or a pasted block, plus the source family
  (`x`, `youtube`, `web`, `repos`, `email`, `slack`, `ideas`, `ai-research`).
- The matching source playbook in `intake/playbooks/` (for example `process-youtube-item.md`,
  `process-web-item.md`, `process-repo-item.md`, `process-research-item.md`).
- The record contract `intake/schemas/intake-record.md`.
- The connector or fetch output (from the relevant project ingest skill, or a manual paste).
  The connector and live queue stay in the operational app per the intake three-layer split;
  this workflow consumes the fetched content, not the live queue.

## Pipeline

### Step 1: Identify the source family and playbook

Determine which source family the item belongs to. Load the matching playbook from
`intake/playbooks/`. If no family fits, default to `web` and note the mismatch for the
operator. Each family folder under `intake/sources/` is the capture target.

### Step 2: Fetch and preserve the raw capture

Run the family-appropriate fetch. For X, YouTube, web, and repos, prefer the existing project
ingest skill (ingest-bookmarks, ingest-youtube, ingest-web, ingest-repo) for the actual fetch;
this workflow standardizes the landing, not the fetch mechanics. Preserve the raw capture
(transcript, page text, repo readme, message body) at a stable path under
`intake/sources/<family>/`. Do not summarize away the raw material; the record points at it.

### Step 3: Write the source-aware intake record

Create the intake record under `intake/sources/<family>/` satisfying
`intake/schemas/intake-record.md`. Capture: source platform, creator or sender, original URL
or message id, ingest timestamp (`received_at` full timestamp), raw capture location,
extracted summary, and why it matters. Use the id convention
`intake-<source>-<date>-<slug>`. Apply [[skill-process-namespace-intake]] for the extracted
summary and the why-it-matters line so the record is route-ready.

### Step 4: Do not route yet

This workflow captures; it does not decide a destination. Leave the item unprocessed (no
matching receipt in `intake/processed/`). Routing is a separate judgment that
[[namespace-intake-review]] owns, so capture and routing stay separable and auditable.

### Step 5: Hand off to namespace intake review

Invoke [[namespace-intake-review]] on the new record (or note that the next scheduled intake
review will pick it up). That workflow runs [[agent-intake-router]] to score destinations,
applies the route into the destination namespace's `support/` or `synthesis/`, and writes the
processed receipt. New Source Ingest's job is done once a conformant, unprocessed record
exists.

## Output format

A capture summary printed to the session, plus the intake record and preserved raw capture
written in Steps 2 and 3. The capture summary contains:

- the source family, original URL or id, and raw capture path
- the extracted summary and the one-line why-it-matters
- the intake record id and path
- a handoff line: routed to [[namespace-intake-review]] now, or queued for the next run

The intake record and raw capture are the durable artifacts. The capture summary is a
point-in-time record and is not a knowledge node.

## Notes

- Capture and route are deliberately separate steps run by separate workflows. This keeps the
  intake fabric auditable: every routed item traces back to a captured record, and every
  capture can be re-routed if the first route was wrong.
- Provenance is preserved end to end: the raw capture is never discarded, and every downstream
  file links back to the source record per [[migration-compatibility-rules]].
- The connector layer (OAuth, polling, token refresh, live queue) stays in the operational app
  and is never written to git. This workflow reads fetched content, not live queue state.
- See [[process-namespace-intake]] for the doctrine on why intake is a root OS layer and never
  owns truth.
