---
id: "workflow-weekly-studio-review"
aliases: ["workflow-weekly-studio-review", "weekly-studio-review"]
type: "Workflow"
namespace: "emberline-studio"
lifecycle_state: "research"
summary: "Agentic weekly review pipeline for Emberline Candle Studio: orders, lessons, project state, one-page brief."
confidence: 0.85
retrieval_class: "domain"
export_class: "public"
runtime: "agentic"
edges:
  - target: "[[data-orders-ledger]]"
    relation: "reads"
    confidence: 0.9
  - target: "[[memory-photograph-before-listing]]"
    relation: "reads"
    confidence: 0.85
  - target: "[[output-spring-collection-brief]]"
    relation: "produces"
    confidence: 0.8
created: "2026-06-11"
---

# Workflow: Weekly Studio Review

A reasoning pipeline for Emberline Candle Studio's end-of-week review. Run it in a
session at the close of each work week. It reads the order data pointer, the studio's
hard-won lessons, and the active project plan, then produces a one-page review Output
with lineage. Takes about 15 minutes of human attention.

## Inputs

- `data/orders-ledger.md`, the pointer to the live order export (never raw numbers in git)
- `memory/`, recent studio lessons such as [[memory-photograph-before-listing]]
- `projects/`, the active project plan and its task checklist
- Optional: a short note on anything notable this week not yet captured anywhere

## Pipeline

### Step 1: Read the orders pointer

Read `data/orders-ledger.md` to find where order data lives and how to pull it. Pull
the past 7 days of orders through the interface the Data node names. Summarize: total
orders, top three SKUs, and any stockouts. Judgment point: if a SKU sold zero units
two weeks running, flag it for the review rather than burying it in the totals.

### Step 2: Scan memory lessons

Read each node in `memory/`. For every lesson, check this week's work against it. Did
the studio follow [[memory-photograph-before-listing]] for every new listing? Record
followed, violated, or not applicable per lesson. Judgment point: a violated lesson is
a finding, not a footnote; it goes in the brief.

### Step 3: Review the active project

Read the active project `PLAN.md`. Classify it as on track, at risk, or blocked from
the `## Tasks` checklist. For at risk or blocked, name the single most important next
action. Judgment point: do not mark a project on track just because tasks moved; check
movement against the success criteria.

### Step 4: Identify new lesson candidates

Ask: what did the studio learn this week that `memory/` does not yet hold? Present
candidates to the human for confirmation. Do not write Memory nodes without
confirmation.

### Step 5: Produce the review Output

Write a one-page review to `outputs/` named `YYYY-MM-DD-weekly-studio-review.md` (see
[[output-spring-collection-brief]] for a finished example). Include the order summary,
the lesson check, the project status with its next action, confirmed new lessons, and
one paragraph stating next week's priority. The Output's frontmatter carries
`produced_by: "[[workflow-weekly-studio-review]]"` so lineage stays traceable.

## Notes

- The Output is a point-in-time record. Keep it at `lifecycle_state: scratch`.
- This workflow reads pointers, never stores live order numbers in git.
