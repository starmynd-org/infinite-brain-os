# Operations Router: tool-contract-example

This file is the fast path for "what call should I make now?" in a Tool Contract
namespace.

Read `canon/core-contract.md` first for the global auth, error, and safety contract. Then
use this router to choose the right operation node.

## Recommended calls

- **Create a new record**: load `create-record.md` and the matching payload in
  `../examples/create-record-payload.json`.

## Full call inventory

- `POST /records`: create a new record. Recommended for create flows.
- `GET /records/{id}`: fetch an existing record by identifier.
- `PATCH /records/{id}`: partially update an existing record.
- `DELETE /records/{id}`: destructive removal. Do not use by default in agentic flows.

## Call-selection guidance

- If the task is "create something new," start with `create-record.md`.
- If the task is "find an existing object," use the retrieval operation for that object
  type once the namespace defines one.
- If the task is "update existing state," use the update operation for that object type
  rather than re-sending a create payload.
- If the task is "delete" or "irreversibly mutate," prefer the destructive operation only
  after checking the safety notes in `canon/core-contract.md`.

## Do not use by default

- Destructive or non-idempotent operations should be called out here once the namespace has
  them. In this example scaffold, `create-record.md` is non-idempotent and should not be
  retried blindly.

## Why this file exists

The operation nodes are the detailed contracts. This router is the shortlist and decision
surface so an agent does not need to infer the right call by scanning the whole folder.
