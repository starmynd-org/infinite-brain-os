# Support: component-library-example

This folder holds provenance and migration records for the namespace. Support is
mechanical and historical.

## What goes here

- Migration receipts: records of components renamed, deprecated, or moved between
  versions, so link preservation is possible.
- Source-priority tables: which implementation version governed a component record, for
  provenance audits.
- Reorganization maps: current-to-target path maps used during a library restructure.

## What does not go here

Derived thinking does not go in `support/`. If a synthesis or interpretation lives here,
move it to `synthesis/`. Support is mechanical; synthesis is intellectual.

## This is an example namespace

In a real component-library namespace, provenance and migration receipts would
accumulate here. This example scaffold leaves `support/` at the README level.
