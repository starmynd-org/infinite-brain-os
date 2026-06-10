---
id: "command-studio-brief"
aliases: ["command-studio-brief", "studio-brief"]
type: "Command"
namespace: "emberline-studio"
lifecycle_state: "research"
summary: "Slash command that produces the studio's morning brief: open orders, low stock, unanswered emails, one suggested focus."
confidence: 0.9
retrieval_class: "identity"
export_class: "public"
name: "studio-brief"
description: "Produce the Emberline morning brief: open orders, low-stock candles, unanswered customer emails, and one suggested focus for the day, written to outputs/."
edges:
  - target: "[[agent-studio-inbox-triage]]"
    relation: "delegates_to"
    confidence: 0.9
  - target: "[[workflow-weekly-studio-review]]"
    relation: "related"
    confidence: 0.8
created: "2026-06-11"
---

# /studio-brief

Produce the studio's morning brief in one pass. Run it once at the start of the workday.

## Usage

```text
/studio-brief
```

## What this command does

1. Lists open orders and flags any older than three business days.
2. Lists candles at or below their reorder threshold.
3. Counts unanswered customer emails and delegates triage to
   `[[agent-studio-inbox-triage]]`.
4. Suggests exactly one focus for the day, with a one-line reason.

## What it reads

- `data/orders-ledger.md`: the pointer node for the order ledger. Read the pointer,
  then the source it names. Never copy live numbers into the brief body.
- `memory/`: recent studio learnings, so the suggested focus respects lessons
  already paid for (for example, `[[memory-photograph-before-listing]]`).

## What it outputs

One Markdown brief in `outputs/`, named `YYYY-MM-DD-studio-brief.md`, with four
sections matching the steps above and lineage frontmatter pointing back to this
command.

## Notes

The brief is a daily snapshot, not the weekly retrospective. For trends across
weeks, run `[[workflow-weekly-studio-review]]` instead.
