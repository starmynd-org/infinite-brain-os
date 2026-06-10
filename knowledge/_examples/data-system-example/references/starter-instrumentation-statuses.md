---
id: "knowledge-data-system-example-reference-starter-instrumentation-statuses"
aliases: ["knowledge-data-system-example-reference-starter-instrumentation-statuses", "starter-instrumentation-statuses"]
type: "Knowledge"
namespace: "data-system-example"
lifecycle_state: "research"
summary: "Reference contract for starter Data System instrumentation statuses so departments and starter repos use one shared vocabulary."
confidence: 0.84
retrieval_class: "domain"
export_class: "internal"
created: "2026-06-03"
---

## Purpose

This reference defines the three starter instrumentation states used by thin Data System
namespaces and department KPI sets.

## Statuses

- `live`: the metric is hydrated by an active implementation path and has a current
  analytical surface behind it.
- `manual`: the metric is maintained by a person or by a low-automation artifact such as a
  Google Sheet, pasted export, or spreadsheet calculation.
- `not-wired`: the metric semantics are defined, but no current implementation path exists.

## Interpretation rules

- `live` does not mean "perfect." It means a named implementation path exists and should be
  the one consumers trust.
- `manual` is acceptable in a starter repo when the semantic layer matters more than
  automation completeness.
- `not-wired` is better than fake precision. It tells the operator and future builders that
  the metric contract is real but the implementation is still missing.

## Typical implementation paths

- `example-co-cli`
- `byo-adapter`
- `manual-sheet`

These values are not the only allowed paths, but they are the starter defaults this example
expects.
