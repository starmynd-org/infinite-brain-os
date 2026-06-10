---
id: "rule-trigger-taxonomy"
aliases: ["rule-trigger-taxonomy", "trigger-taxonomy"]
type: "Rule"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "The fixed trigger vocabulary for registered department work: scheduled, lifecycle, condition, and on-call, with mandatory hard flags for external and canon-touching effects."
confidence: 0.88
retrieval_class: "domain"
export_class: "internal"
description: "Apply this rule whenever a department register, callable capability, or other registered task declares what starts the work. Every registered task carries exactly one trigger field and explicit external and canon-touching hard flags."
edges:
  - target: "[[department-runtime-contract]]"
    relation: "depends_on"
    confidence: 0.84
  - target: "[[rule-signal-vocabulary]]"
    relation: "aligned_with"
    confidence: 0.87
  - target: "[[surface-boundary]]"
    relation: "bounded_by"
    confidence: 0.83
created: "2026-06-10"
---

# Rule: Trigger Taxonomy

Registered department work uses one fixed trigger vocabulary. A task register is a contract, not live
state, so the trigger field answers only "what is supposed to start this task" and never "did today's
run happen." Runtime state belongs to the operational substrate per `_system/department-runtime-contract.md`.

## Fixed trigger field

Every registered task carries exactly one `trigger` field. The value must be one of these four types:

1. `scheduled`
2. `lifecycle`
3. `condition`
4. `on-call`

Do not stack trigger types on one row. If a task can start in more than one way, register separate task
rows so each row stays unambiguous.

## Allowed trigger values

### `scheduled`

Clock-driven work. The subtype must be one of:

- `scheduled: daily`
- `scheduled: weekly`
- `scheduled: monthly`

Use this when the contract says the task runs on cadence regardless of whether new intake arrived.

### `lifecycle`

Runtime-boundary work tied to a session or operating cycle edge. The subtype must be one of:

- `lifecycle: on-startup`
- `lifecycle: on-closeout`

Use this for preparation or shutdown discipline, not for arbitrary "when ready" work.

### `condition`

Input- or state-driven work that fires when intake or repo state matches declared criteria. The value
must be:

- `condition: <intake criteria match>`

The criteria text should name the routing or state condition plainly, for example
`condition: new supplier catalog received` or `condition: shared pipeline failure detected`.

### `on-call`

Delegated work another agent or department invokes explicitly. The value must be:

- `on-call: <allowed caller or caller class>`

Use this for callable capabilities and support tasks, not for background polling.

## Mandatory hard flags

Every registered task also carries these two hard flags, even when both are false:

- `external`: `true | false`
- `canon-touching`: `true | false`

These are hard gates, not weighted hints. They align with `entities/rules/signal-vocabulary.md` and the
result-and-escalation posture.

- `external: true` when the task sends, publishes, deploys, spends, modifies an external runtime, or
  produces a client- or public-facing output by default.
- `canon-touching: true` when the task proposes or performs a canon change, including current-truth or
  doctrine edits that require operator review.

If either hard flag is true, the task remains registered in git as a contract, but acceptance and live
run handling stay conservative and runtime-mediated.

## Contract discipline

- Git says what can run and when it should run.
- The runtime says whether a specific run happened, failed, or is blocked today.
- Registers never become the live checklist.
- A trigger row should point at an existing workflow, playbook, or skill rather than duplicating its
  steps inline.

## Examples

- `scheduled: daily`
- `scheduled: weekly`
- `scheduled: monthly`
- `lifecycle: on-startup`
- `lifecycle: on-closeout`
- `condition: new intake item routed to finance`
- `on-call: fleet-coordinator`

Anything outside these forms is out of contract.
