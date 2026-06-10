# Schema: Intake Record

An intake record is one captured item. It is the durable, in-git evidence that something
entered the intake fabric: a single X post or thread, a YouTube video, a web page, a repo,
an email, a Slack message, an idea, or a deep-research item. The record preserves source
context so a later reader can verify the claim and trace it back to where it came from.

This schema defines the field list, an example record, and validation expectations. It is
the operative contract. The source family READMEs under `../sources/<family>/` point here,
and the playbooks under `../playbooks/` write records to this shape.

## What an intake record is and is not

An intake record IS a captured-source receipt: it says what arrived, from whom, when, where
the raw bytes live, what it says in one paragraph, and why it is worth attention. It is
durable. It stays in git after the item is routed so the capture trail is auditable.

An intake record is NOT live queue state. It does not carry `unprocessed`, `in-review`, or
`blocked` status. That state lives in the operational app layer (G1, contract Part 5.1). An
intake record is also not the routing decision and not the processed receipt: those are
separate records shaped by `routing-decision.md` and `processed-receipt.md`. One captured
item produces one intake record, then (when worked) one routing decision and one processed
receipt that both link back to it.

## File location and naming

A record lives in `../sources/<family>/`, one Markdown file per captured item. The family
is one of `x`, `youtube`, `web`, `repos`, `email`, `slack`, `ideas`, `ai-research`.

Filename and `id` use the intake convention from the repo conventions digest:

```text
intake-<source>-<date>-<slug>
```

- `<source>` is the source family slug (`x`, `youtube`, `web`, `repo`, `email`, `slack`,
  `idea`, `research`).
- `<date>` is the capture date as `YYYY-MM-DD`.
- `<slug>` is a kebab-case short title, first few meaningful words, max about 40 characters.

Example filename: `intake-x-2026-05-30-orientation-as-retrieval.md`.

## Field list

| Field | Type | Required | Notes |
|-------|------|----------|-------|
| `id` | string | yes | `intake-<source>-<date>-<slug>`. Matches the filename without extension. |
| `aliases` | list of string | when id differs from filename | Include `id` so `[[wikilinks]]` resolve in Obsidian. |
| `type` | string | yes | Always `"intake-record"`. |
| `namespace` | string | yes | `"personal-operator"` until routed. The destination namespace is recorded in the routing decision, not here. |
| `source` | string | yes | Source platform: `x`, `youtube`, `web`, `repo`, `email`, `slack`, `idea`, `ai-research`. |
| `creator` | string | yes | Creator or sender: X handle, channel name, author, repo owner, email sender, Slack user. Write `"unknown"` if genuinely unknown. |
| `original_ref` | string | yes | Original URL, or message id for email and Slack. The canonical pointer back to the live source. |
| `received_at` | string | yes | Ingest timestamp, ISO 8601 with timezone, for example `"2026-05-30T11:15:00Z"`. |
| `raw_capture` | string | yes | Where the raw capture lives: a relative path to a saved file, an archive path, or the external archive location. Never paste large raw bodies into the record body; point to them. |
| `summary` | string | yes | One-line extracted summary of what the item says. |
| `why_it_matters` | string | yes | One or two lines on why this is worth attention. Drives the scoring model. |
| `lifecycle_state` | string | yes | `scratch` on capture; moves to `research` if the captured record itself is worth keeping as reference. Intake records do not become canon. |
| `confidence` | number | yes | 0.0 to 1.0. Capture confidence, not classifier routing confidence. |
| `retrieval_class` | string | yes | `ephemeral` for ordinary captures; `domain` only if the captured record is itself reference-grade. |
| `export_class` | string | yes | `internal`. Intake records are never public. |
| `created` | string | yes | Capture date, `YYYY-MM-DD`. |
| `edges` | list | when known | Edge to the routing decision and processed receipt once they exist, relation `references` or `produces`. |

The body holds the human-readable capture: source block, raw content (quoted or in a
collapsible block, or a pointer to `raw_capture`), and an extracted summary. The body never
holds live queue status.

## Example record

```yaml
---
id: "intake-x-2026-05-30-orientation-as-retrieval"
aliases: ["intake-x-2026-05-30-orientation-as-retrieval"]
type: "intake-record"
namespace: "personal-operator"
source: "x"
creator: "@example_handle"
original_ref: "https://x.com/example_handle/status/0000000000000000000"
received_at: "2026-05-30T11:15:00Z"
raw_capture: "../../sources/x/raw/orientation-as-retrieval-thread.txt"
summary: "Thread argues memory is raw material and retrieval is the operating layer."
why_it_matters: "Sharpens the retrieval-over-raw-memory pillar in ai-architecture."
lifecycle_state: "scratch"
confidence: 0.7
retrieval_class: "ephemeral"
export_class: "internal"
created: "2026-05-30"
edges:
  - target: "[[routing-x-2026-05-30-orientation-as-retrieval]]"
    relation: "produces"
    confidence: 0.9
---

## Source

- Platform: X
- Creator: @example_handle
- Original: https://x.com/example_handle/status/0000000000000000000
- Captured: 2026-05-30 at 11:15 UTC
- Raw capture: ../../sources/x/raw/orientation-as-retrieval-thread.txt

## Captured content

Full thread is preserved at the raw capture path above. The load-bearing claim:
right fragments at the right time beat a large undifferentiated context window, so the
operating layer is retrieval, not storage.

## Extracted summary

The thread restates the retrieval-over-raw-memory position with one concrete example: an
agent that grep-reads the three relevant nodes outperforms one that loads the whole
namespace. Candidate support for the ai-architecture retrieval pillar.

## Why it matters

It is a clean external statement of a pillar this brain already holds. Useful as cited
support, not as new doctrine.
```

## Validation expectations

- `id` present, `type` is `"intake-record"`, and `id` matches the filename without
  extension. If they differ, `id` appears in `aliases`.
- `source` is one of the eight family slugs. `received_at` parses as ISO 8601. `created` is
  `YYYY-MM-DD`.
- `creator`, `original_ref`, `raw_capture`, `summary`, `why_it_matters` are all present and
  non-empty. No placeholder text (`{todo}`, `TBD`) above `lifecycle_state: scratch`; write
  `"unknown"` where a value is genuinely unknown.
- `export_class` is `internal`. `validate.sh` rejects any other value for an intake record.
- No em dashes and no en dashes anywhere, per `entities/rules/voice-and-style.md`.
- The record body holds no live queue status field. Status is runtime state in the app
  layer, not in git.

These intake records are governed downstream by `_system/namespace-intake-rules.md` (how
namespaces consume them). The reasoning for why intake is a root layer is explained in
`knowledge/ai-architecture/concepts/intake-fabric-namespace.md`.
