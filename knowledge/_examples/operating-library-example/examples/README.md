# examples/

This folder holds worked examples of past resolved incidents or completed procedure
runs. Examples serve as calibration: they show how a diagnostic or SOP was applied in a
real (or realistic) case, what was found, and what action was taken.

## What goes here

One `.md` file per example. The file is a knowledge node with full frontmatter. It
documents:

- Which SOP or diagnostic it illustrates.
- The input conditions: what was observed, when, at what metric values.
- The steps taken: which checks were run and what each check returned.
- The finding: the root cause identified.
- The action taken: what was done to resolve it, and whether it succeeded.
- The date of the example.

## What does not go here

Do not put live incident state here. This folder holds finished, reviewed examples, not
active tracking. Active incidents belong in the operational app layer.

Do not update SOP or diagnostic nodes from an example alone. If an example reveals a
gap in a procedure, update the procedure node directly and reference the example as the
source of the revision in the `## Changelog` of the procedure.

## Purpose

Examples reduce time-to-diagnosis for recurring incident types. An agent or operator who
has seen a past resolved example for an anomaly type will diagnose the next occurrence
faster. Build this folder as incidents are resolved, not speculatively.
