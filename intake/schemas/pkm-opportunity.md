# Schema: PKM Opportunity

Use this schema when `intake-operations` hands a PKM-worthy item to `infinite-brain-ops`
for structural review.

## Purpose

This record makes the handoff traceable:

- what source item triggered the opportunity
- what `intake-operations` thinks matters about it
- what structural recommendation is being proposed
- what `infinite-brain-ops` decides to do with it

It is the durable bridge from intake processing to PKM adjustment.

## Required frontmatter

```yaml
---
id: "pkm-opportunity-<slug>"
type: "pkm-opportunity"
namespace: "personal-operator"
source_record: "[[intake-...]]"
processed_receipt: "[[receipt-...]]"
proposed_by_department: "intake-operations"
target_department: "infinite-brain-ops"
recommended_disposition: "support-only"
recommended_targets:
  - "knowledge/<namespace>/support/<file>.md"
status: "pending"
lifecycle_state: "research"
confidence: 0.8
retrieval_class: "ephemeral"
export_class: "internal"
created: "2026-05-31"
---
```

## Field guidance

- `recommended_disposition`
  Use one of:
  - `reject`
  - `defer`
  - `support-only`
  - `synthesis`
  - `canon-candidate`
  - `namespace-update`
  - `new-namespace-candidate`
  - `task-candidate`
  - `workflow-candidate`
  - `tool-candidate`
  - `department-candidate`

- `status`
  Use one of:
  - `pending`
  - `approved`
  - `deferred`
  - `rejected`
  - `executed`

## Body sections

Include:

1. what came in
2. why it might matter to the brain
3. intake-operations recommendation
4. candidate target files or structures
5. infinite-brain-ops decision
6. resulting files or tasks created
7. unresolved questions

## Traceability rule

Every PKM opportunity must link back to:

- the intake source record
- the processed receipt

And if acted on, it must also link forward to:

- the files changed, and/or
- the project/task created

That trace is the whole point of the artifact.
