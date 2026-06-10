# Concepts: tool-contract-example

This folder holds definitions and models needed to use this tool correctly.

## What goes here

Concept nodes explain the non-obvious ideas behind the API contract. Typical content:
how auth tokens work and when to refresh them, what idempotency means for this API, how
the pagination model works, what an `external_id` is and why uniqueness matters.

A concept node is needed when the same non-obvious idea recurs across multiple operation
nodes and is better explained once in its own file.

## What does not go here

Individual operation details go in `operations/`. The global contract goes in
`canon/core-contract.md`. Past design decisions go in `decisions/`.

## This example scaffold

This folder is empty in the example scaffold. In a real namespace, add one file per
concept that recurs across multiple operations or that an agent frequently misapplies.
