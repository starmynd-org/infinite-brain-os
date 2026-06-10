# source-contracts/

This folder holds source contract nodes. A source contract is the authoritative record
of what an external API or upstream system provides to this namespace.

## What goes here

One `.md` file per source. The file is a knowledge node with full frontmatter. It
documents:

- The source system name and owner.
- The base URL or connection identifier.
- The fields the source provides, with type, nullability, and the operator's
  interpretation of each field.
- Known quirks: fields that behave differently than documented, nulls that mean
  something, status enumerations that have undocumented values.
- The versioning posture: how the source signals breaking changes, and who is responsible
  for updating this contract when the upstream API changes.

## What does not go here

Do not put pipeline configuration here. Pipeline nodes (schedule, trigger, destination
table) belong in `pipelines/`. The source contract describes what is available upstream;
the pipeline node describes how it is collected.

Do not put transform logic here. The transform node owns the business logic that reshapes
what the source provides.

## Example

See `source-contract-example-orders-api.md` in this folder for a complete stub.
