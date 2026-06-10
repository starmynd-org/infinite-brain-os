# Canon: component-library-example

This folder holds the compressed canon for the component-library-example namespace.

## What canon means here

Canon is the first-principles synthesis an agent loads before it reads any component
record, pattern, or deployment note. It answers: what is the governing model for how
components are approved and constrained, and what principles make a component-library
namespace different from a loose collection of implementation notes.

## What lives here

- `core-doctrine.md`: the keystone synthesis. A real knowledge node with full
  frontmatter. Operator-approved and provenance-bearing. Updated only when the
  component library's governance model changes.
- `agent-load-order.md`: navigational. Tells a reading agent what to load and in what
  order for each query class.

## How to update canon

Canon changes only when:

- the approval model changes (for example, the criteria for "approved" shift), or
- the source/namespace split principle is revised.

Record every change in the `## Changelog` section of `core-doctrine.md`. The operator
approves canon updates before they land.

## This is an example namespace

This canon folder is part of the component-library EXAMPLE scaffold. The
`core-doctrine.md` here is illustrative: short, structurally correct, with real
frontmatter, but not deep content. Copy and replace when building a real
component-library namespace.
