# Canon: design-system-example

This folder holds the compressed canon for the design-system-example namespace.

## What canon means here

Canon is the first-principles synthesis an agent loads before it reads any token value,
asset reference, or usage example. It answers: what are the founding design principles,
what constraints do they impose, and why were those constraints chosen.

Canon is small relative to the rest of the namespace. It does not paraphrase
`pillars/` node by node. It synthesizes and compresses.

## What lives here

- `core-doctrine.md`: the keystone synthesis. A real knowledge node with full
  frontmatter. Operator-approved and provenance-bearing. Updated only when the design
  system's first principles change.
- `agent-load-order.md`: navigational. Tells a reading agent what to load and in what
  order for each query class.

## How to update canon

Canon changes only when:

- a design pillar is revised and the prior synthesis is no longer accurate, or
- a new pillar is added that changes the compressed first-principles picture.

Record every change in the `## Changelog` section of `core-doctrine.md`. The operator
approves canon updates before they land.

## This is an example namespace

This canon folder is part of the design-system EXAMPLE scaffold. The `core-doctrine.md`
here is illustrative: short, structurally correct, with real frontmatter, but not deep
content. Copy and replace when building a real design-system namespace.
