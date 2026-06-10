# References: tool-contract-example

This folder holds pointers to upstream documentation and external reference material.

## What goes here

- Links to the upstream API documentation (official docs, changelogs, OpenAPI spec).
- Rate limit tables, SLA documentation, environment-specific base URLs.
- Migration guides when the API version changes.
- Any reference material that an operator or agent may need to consult alongside the
  namespace contract but that is owned externally.

## What does not go here

The namespace contract itself (compressed, interpreted) belongs in
`canon/core-contract.md` and `operations/`. This folder links out; it does not duplicate.

## Freshness note

References carry a `verified_at` date because external docs change. Review references
when the upstream API publishes a version update.

## This example scaffold

This folder is empty in the example scaffold. In a real namespace, add at minimum a
pointer to the upstream API docs and a note on the last-verified date.
