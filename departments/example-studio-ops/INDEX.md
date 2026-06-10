---
id: "department-example-studio-ops-index"
aliases: ["department-example-studio-ops-index", "example-studio-ops"]
type: "Doc"
namespace: "emberline-studio"
lifecycle_state: "research"
summary: "Assembly surface for the example studio-ops department: the entities that run Emberline Candle Studio operations."
confidence: 0.85
retrieval_class: "identity"
export_class: "public"
edges:
  - target: "[[department-example-studio-ops-charter]]"
    relation: "depends_on"
    confidence: 0.9
  - target: "[[project-example-autumn-collection]]"
    relation: "owns"
    confidence: 0.9
created: "2026-06-11"
---

# Department: Example Studio Ops

The worked example of a department: studio operations for Emberline Candle Studio.
It assembles existing entities into one operating surface; it owns no entity bodies.

## Purpose

Run the studio's day-to-day commerce: collections launch on time, orders ship on
time, listings carry the brand voice, and the weekly review keeps the whole loop
honest. See [[department-example-studio-ops-charter]] for what success means.

## Scope Class

`internal-product`. No external parties, clients, or brands; the studio is the
business.

## Head Agent

[[agent-studio-inbox-triage]] takes first pass on everything inbound: customer
email, wholesale inquiries, platform notifications. It routes, it does not decide.

## Intake

- The studio inbox (customer and wholesale email), triaged by the head agent
- Shop platform notifications (orders, stockouts, reviews)

## Core Knowledge

- The `emberline-studio` namespace, entered through its INDEX
- [[knowledge-emberline-studio-brand-essentials]] for who the studio is
- [[knowledge-emberline-studio-seasonal-collection]] for how a collection launches

## Core Execution

- Command: [[command-studio-brief]] for an on-demand studio status brief
- Skill: [[skill-write-product-description]] for listing copy
- Rule: [[rule-studio-brand-voice]] governing every customer-facing word
- Workflow (agentic): [[workflow-weekly-studio-review]]
- Workflow (deterministic): [[automation-order-export-digest]]
- Tool: [[tool-order-ledger]]
- Project: [[project-example-autumn-collection]]

## Human Layer

Human-only: pricing, new scent approval, wholesale terms, anything that spends money
or makes a public claim. Review-gated: new listing copy before publish. Fully
AI-routed: inbox triage classification and the weekly digest.

## Daily Update

One short note per day: orders in, orders shipped, anything blocked, anything
needing a human decision. Rolls up into the weekly studio review.

## Runtime Mapping

- `department_id`: `example-studio-ops`
- `department_name`: Example Studio Ops
- `head_agent`: `agent-studio-inbox-triage`
- `owned_namespaces`: `emberline-studio`
- `owned_workflows`: `workflow-weekly-studio-review`, `automation-order-export-digest`
- `owned_tools`: `tool-order-ledger`
- `primary_intake_sources`: studio inbox, shop platform notifications
- `daily_update_output`: daily studio note
- `daily_rollup_target`: weekly studio review
- `human_review_gates`: pricing, listing publish, wholesale terms

## Subdepartments

None. Keep it one surface until volume forces a split.

## Open Gaps

- The daily update is described, not yet automated.
- Wholesale handling has no playbook; inquiries route to a human by default.
