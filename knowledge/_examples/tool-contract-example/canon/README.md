# Canon: tool-contract-example

This folder holds the locked contract layer for this tool or API namespace. For Tool
Contract namespaces, the canon file of record is `core-contract.md` (not the standard
`core-doctrine.md` used by Doctrine namespaces).

## What lives here

- `core-contract.md`: the locked operational contract. Summarizes the tool, its
  primary operations, auth mechanism, error contract, and the key constraints an agent
  must know before making any call.
- `agent-load-order.md`: the load-order controller. Tells agents what to read next by
  query class.

## What does not live here

- Full API documentation. Link to it in `references/`. Canon compresses and interprets.
- Individual operation details. Those live in `operations/`.
- Worked example payloads. Those live in `examples/`.
- Disputed or unclear contract points. Those live in `synthesis/`.

## How to update canon

The core contract changes when the upstream API changes in a way that affects how agents
call it. The sequence:

1. Identify the change: a new endpoint, a changed payload shape, a deprecated field.
2. Update the relevant `operations/` node first.
3. If the change is load-bearing for agent reasoning, update `core-contract.md` and
   increment the `## Changelog` entry.
4. Update `verified_at` and `verified_by`.

Do not update `core-contract.md` for minor API surface changes that do not affect the
contract a calling agent needs to know. Route those to `references/` or an
`operations/` node.

## Navigational note

This README does not carry node frontmatter. `core-contract.md` carries full node
frontmatter because it is a real knowledge node.
