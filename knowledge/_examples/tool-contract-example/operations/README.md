# Operations: tool-contract-example

This folder holds the operation router plus one file per operation exposed by the tool or API.

## Router first

`INDEX.md` is the fast call router for this folder. It answers:

- what operation an agent should start with
- which calls are preferred by task shape
- which calls should not be used by default

Read it before jumping into a specific operation when the task is still "which call?"

## What goes here

An operation node documents how to call one endpoint or method correctly. It covers:

- The endpoint (method and path) or method signature.
- Required and optional fields in the request payload.
- The response shape on success.
- Operation-specific error cases beyond the global error contract.
- Any non-obvious constraints (idempotency, ordering, side effects).

## What does not go here

The global auth and error contract lives in `canon/core-contract.md`. Worked sample
payloads live in `examples/`. Design rationale lives in `decisions/`.

## Lint note (Profile B)

Every operation node must have a worked example payload linked or present in `examples/`.
An operation with no example payload is an incomplete contract.

## This example scaffold

This folder contains:

- `INDEX.md`: recommended-call router
- `create-record.md`: example operation node
