# procedures/

This folder holds SOP (Standard Operating Procedure) nodes. Each SOP documents a
recurring task: what triggers it, what is needed before starting, the numbered steps to
follow, and the escalation condition.

## What goes here

One `.md` file per procedure. The file is a knowledge node with full frontmatter. The
body must include these sections, in order:

- **Trigger**: the specific event or condition that starts this procedure. Be concrete.
  "Every weekday at 09:00" or "When a Slack alert fires on channel #data-alerts" is a
  valid trigger. "When needed" is not.
- **Inputs**: what must be available before the first step. Links to credentials, access
  to a specific dashboard or system, or a prior SOP that must have been completed.
- **Steps**: numbered, each actionable in one or two sentences. Steps do not contain
  branching logic; if a step requires a decision, link to a decision tree.
- **Escalation**: the exact condition at which the operator stops this procedure and
  involves someone else or a different process. Name the escalation target (a person or
  a team, by role not by name).
- **Completion check**: how you know the procedure finished successfully.

## What does not go here

Do not put diagnostic guides here. If a step in an SOP uncovers an anomaly, the SOP
should link to the relevant diagnostic node in `diagnostics/`, not inline the
investigation steps.

Do not put decision trees here. Branching logic between procedures belongs in
`decision-trees/`.

## Example

See `sop-example-daily-metric-review.md` in this folder for a complete example.
