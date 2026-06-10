# synthesis/

This folder holds within-namespace synthesis for this Operating Library. Synthesis is
derived thinking that is neither raw SOP nor settled canon: disputed diagnostic
thresholds, best-current-reading on contested escalation rules, and canon-candidate
packages.

## What goes here

- **Contradiction map**: where two diagnostic nodes give conflicting guidance on the
  same anomaly, or where a threshold in a diagnostic conflicts with a threshold in an
  SOP.
- **Best-current-reading**: the operator's current synthesized answer on a disputed
  escalation threshold or diagnostic priority order.
- **What-changed review**: a dated review of which procedures or diagnostics changed
  and why, useful after a major operational change.
- **Canon-candidate**: a synthesis proposed for promotion into `canon/core-doctrine.md`.

## What does not go here

Do not put SOP revision history here. That belongs in `support/`. Do not put live
incident logs here. Synthesis holds interpretive thinking, not operational records.

## Separation from support

`support/` records what happened (SOP revision dates, diagnostic version changes).
`synthesis/` records the current best interpretation of contested or evolving questions.
If you are unsure which folder a note belongs in, ask: is this a receipt of a change,
or is it reasoning about what a change means for how we should operate?
