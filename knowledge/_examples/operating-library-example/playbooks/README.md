# playbooks/

This folder holds repeatable procedures for maintaining the namespace itself. This is
distinct from `procedures/`, which holds SOPs for the business operations the namespace
covers.

## What goes here

- **Add a new SOP**: the steps to create a new procedure node, confirm it has a trigger,
  inputs, numbered steps, and an escalation condition, and add it to the relevant
  decision trees.
- **Add a new diagnostic**: the steps to create a new diagnostic node, confirm it
  references a valid `metric_id` from a Data System namespace, and link it from the
  relevant SOPs.
- **Review and update a procedure**: the steps to assess whether an existing SOP is
  still accurate, update it if not, and record the revision in `support/`.
- **Retire a procedure**: the steps to deprecate an SOP or diagnostic, add a
  `supersedes` pointer, and update any decision trees that referenced it.

## What does not go here

Do not put business SOPs here. Business SOPs (how to run a daily review, how to
diagnose a metric anomaly) belong in `procedures/` and `diagnostics/`. This folder
covers namespace maintenance only.
