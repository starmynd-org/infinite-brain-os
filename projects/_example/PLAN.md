---
id: "project-example-autumn-collection"
aliases: ["project-example-autumn-collection"]
type: "Project"
namespace: "emberline-studio"
lifecycle_state: "research"
summary: "Launch the Emberline autumn candle collection: five SKUs around one anchor scent, photographed before listing."
confidence: 0.85
retrieval_class: "domain"
export_class: "public"
state_stored_at: "git://projects/_example/PLAN.md"
analytical_view: "none"
updated: "2026-06-11"
project_status: "active"
owner_department: "example-studio-ops"
owner_agent: "the-operator"
parent_initiative: "none"
review_cadence: "weekly"
linked_swarm_id: "none"
edges:
  - target: "[[department-example-studio-ops-index]]"
    relation: "owned_by"
    confidence: 0.9
  - target: "[[workflow-weekly-studio-review]]"
    relation: "reviewed_by"
    confidence: 0.9
  - target: "[[knowledge-emberline-studio-seasonal-collection]]"
    relation: "applies"
    confidence: 0.85
created: "2026-06-11"
---

# Project: Autumn Collection Launch

## Goal

Launch the Emberline autumn collection by September 1: five SKUs built around one
anchor scent, all photographed before listing, with stock levels sized from spring
sales data.

## Why this matters

The spring collection proved the anchor-scent pattern and exposed a stockout. Autumn
is the studio's highest-revenue season; launching late or understocked costs the
year's best window. The playbook in
[[knowledge-emberline-studio-seasonal-collection]] applies here end to end.

## Scope

In scope:

- Scent selection, naming, and label copy for five autumn SKUs
- Photography for every SKU before any listing goes live
- Opening stock sized from spring sell-through, reorder trigger at 30 percent

Out of scope:

- Wholesale program decisions (separate decision, separate project)
- Packaging redesign

## Success criteria

1. Five SKUs live in the shop by September 1, each with finished photography.
2. The anchor scent's opening stock is at least double any other SKU.
3. No SKU goes dark for more than two days during the first six weeks.

## Tasks

- [x] `task-pick-anchor-scent` Choose the autumn anchor scent from the shortlist
  - status: done
  - acceptance: One anchor scent named in this plan with reasoning recorded.
- [ ] `task-finalize-skus` Finalize the remaining four SKUs and their names
  - status: in_progress
  - acceptance: Five SKU names and scent specs recorded in this plan.
- [ ] `task-shoot-photography` Photograph all five SKUs
  - status: proposed
  - depends_on: task-finalize-skus
  - acceptance: Finished photos exist for every SKU before any listing is drafted.
- [ ] `task-size-opening-stock` Size opening stock from spring sell-through
  - status: proposed
  - acceptance: Per-SKU opening quantities and the 30 percent reorder trigger recorded.
- [ ] `task-publish-listings` Publish all five listings
  - status: proposed
  - depends_on: task-shoot-photography
  - acceptance: All five SKUs live in the shop with photography attached.

## Outputs

- The spring brief that informed this plan: [[output-spring-collection-brief]]

## Change log

- 2026-06-11: Created project from the spring collection review findings.
