# synthesis/

This folder holds within-namespace synthesis. Synthesis is derived thinking that is
neither raw archive nor settled canon: contradiction maps, best-current-reading notes,
what-changed reviews, and canon-candidate packages.

## What goes here

- **Contradiction map**: where two source field definitions, two metric interpretations,
  or two model schemas disagree, and the current best resolution.
- **Best-current-reading**: the operator's current synthesized answer on a contested
  calculation or definition.
- **What-changed review**: a dated note on what moved since the last review pass (useful
  after a source API version bump).
- **Canon-candidate**: a synthesis node proposed for promotion into `canon/core-doctrine.md`.

## What does not go here

Do not put provenance or migration receipts here. Those belong in `support/`. Do not put
settled doctrine here. Settled doctrine belongs in `canon/`. Synthesis is for the
territory between raw data and finished canon: interpretation in progress, disputes
being resolved, lessons being extracted.

## Separation from support

`support/` is mechanical and historical: it records what happened (migration, source
versioning, reorganization). `synthesis/` is interpretive and current: it records the
current best understanding of contested or evolving questions. If you are not sure which
folder a note belongs in, ask: is this a receipt of what happened, or is it my current
thinking about what it means?
