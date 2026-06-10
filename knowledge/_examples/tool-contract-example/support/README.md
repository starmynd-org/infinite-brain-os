# Support: tool-contract-example

This folder holds provenance and migration records for this namespace.

## What goes here

- Migration receipts: records of where the contract was sourced from when the namespace
  was first created or when an older version was upgraded.
- Source-priority tables: if the upstream API docs and observed behavior differ, which
  takes precedence and why.
- Version migration maps: when the API releases a new version, a map from old endpoint
  names to new ones.

## What does not go here

Analysis and derived readings go in `synthesis/`. Operation details go in `operations/`.
Do not put analytical content in `support/`.

## Boundary note (G11)

`support/` is mechanical and historical. It holds receipts and maps, not judgment calls.
If you are writing something that requires interpretation of the API, it belongs in
`synthesis/`.

## This example scaffold

This folder is empty in the example scaffold. In a real namespace, `support/` grows when
the contract is migrated from a legacy source or when API versions change and old mappings
need to be preserved.
