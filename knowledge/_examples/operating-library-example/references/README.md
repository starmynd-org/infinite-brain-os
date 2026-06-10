# references/

This folder holds external reference nodes for this namespace. External references are
documents outside this repo that procedures or diagnostics rely on: vendor runbooks,
system administration guides, API documentation for tools used in procedures, or
internal wiki pages that are not tracked in this repo.

## What goes here

One `.md` file per external reference. Minimum content:

- Title and URL or location.
- Why this namespace depends on it: which SOP or diagnostic links to it.
- The sections most relevant to the operators running this library.
- A freshness note: when this was last verified as accurate.

## What does not go here

Do not put internal namespace nodes here. Do not put provenance or SOP revision history
here. Those belong in `support/`.

## Typical use

You would add a reference node when an SOP requires an operator to follow a vendor
runbook step-by-step, when a diagnostic requires checking an external monitoring tool,
or when a decision tree terminal branch points to a team wiki page.
