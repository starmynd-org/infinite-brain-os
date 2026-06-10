# Examples: tool-contract-example

This folder holds sample payloads and worked examples for operations in this namespace.

## What goes here

- Sample JSON request payloads for each operation in `operations/`.
- Sample response payloads where the response shape is complex enough to warrant a
  worked example.
- Any other concrete, runnable example that an agent can use to verify its request
  before sending.

## Naming convention

Match the operation file name: `create-record.md` in `operations/` pairs with
`create-record-payload.json` in `examples/`.

## What does not go here

Operation descriptions and payload field explanations go in `operations/`. Design
rationale goes in `decisions/`. Reference material goes in `references/`.

## Lint note (Profile B)

Every `operations/` file must have a corresponding worked example in this folder.
A missing example is an incomplete contract.

## This example scaffold

This folder contains `create-record-payload.json` paired with
`operations/create-record.md`.
