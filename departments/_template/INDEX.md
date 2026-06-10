---
id: "department-template-index"
type: "Doc"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Template start-here for defining an AI shadow department assembly surface."
confidence: 0.86
retrieval_class: "identity"
export_class: "internal"
created: "2026-05-31"
---

# Department Template

Use this template when defining a new AI shadow department.

## Purpose

State the business function this department owns and the result it is meant to produce.

## Scope Class

State whether this department is:

- `shared-platform`
- `internal-product`
- `client-scoped`
- `brand-scoped`
- `multi-party`

If the department is externally scoped, list:

- `party_slugs`
- `client_slug` when one client is primary
- `brand_slug` when one brand is primary

Also link the relevant records under `parties/`.

## Head Agent

Link the head-of-department agent that owns first pass, routing, escalations, and the daily
department update.

## Intake

List the intake sources that should hit AI first for this department.

## Core Knowledge

List the namespaces the department reasons from.

## Core Execution

List the key skills, workflows, deterministic automations, tools, and projects the department
uses.

## Human Layer

State what remains human-only, what requires review, and what is fully AI-routed.

## Daily Update

Describe the daily update the department should emit and where it rolls up.

## Runtime Mapping

Make the `_system/department-runtime-contract.md` fields explicit so a Paperclip projection has one
source: `department_id`, `department_name`, `head_agent`, `owned_namespaces`, `owned_workflows`,
`owned_tools`, `primary_intake_sources`, `daily_update_output`, `daily_rollup_target`,
`human_review_gates`.

By default the department head reports to the fleet coordinator (`reports_to: fleet-coordinator`), so
the department is wired into the fleet apex. In the Paperclip projection set the head agent's
`reportsTo: fleet-coordinator`. The chief-of-staff is the only exception: it is a protected peer that
reports to the operator and syncs with the fleet coordinator, never commanded by it (see
`entities/rules/department-head-reporting-contract.md`).

When referencing shared doctrine from this file, use full repo-relative paths (for example
`knowledge/ai-architecture/decisions/paperclip-boundary.md`) or wikilinks by id, never bare relative
paths like `decisions/paperclip-boundary.md` (they do not resolve from `departments/`).

## Subdepartments

List any subdepartments and their boundaries.

## Open Gaps

List what still has to be built before this department is real.
