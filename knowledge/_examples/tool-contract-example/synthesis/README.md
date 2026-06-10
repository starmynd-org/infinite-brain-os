# Synthesis: tool-contract-example

This folder holds derived analysis about the tool contract that is neither settled canon
nor raw archive.

## What goes here

- Contradiction maps: where the namespace contract and observed API behavior disagree,
  with the current best resolution.
- Best-current-reading notes: the operator's interpretation of an ambiguous API behavior.
- Open contract questions: unclear or undocumented API behaviors that need resolution
  before the contract can be updated.
- Canon-candidates: synthesis that is proposed for promotion into `canon/core-contract.md`.

## What does not go here

Provenance and migration receipts go in `support/`. Operational details go in
`operations/`. Do not put analysis in `canon/` until it is settled.

## Freshness

Tool Contract namespaces accumulate synthesis when the upstream API is observed to behave
differently from the documented contract, or when an agent reports an unexpected response.
Route those observations here before updating the contract.

## This example scaffold

This folder is empty in the example scaffold. In a real namespace, synthesis nodes
accumulate as the integration matures and edge cases are discovered.
