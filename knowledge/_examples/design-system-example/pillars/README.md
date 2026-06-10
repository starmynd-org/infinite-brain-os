# Pillars: design-system-example

This folder holds foundational design principles for the namespace. A pillar is a
first-principles constraint that all token, asset, and usage decisions derive from.

## What goes here

Each file is a knowledge node with full frontmatter. It states one foundational principle:
what it is, why it was chosen, and what it rules out. Pillars are stable; they change
only when the design system's foundational direction changes.

## What does not go here

Token values, usage examples, and asset records do not go in `pillars/`. Those live in
`tokens/`, `examples/`, and `assets/`. A pillar states the principle that authorizes
a token or pattern; it does not restate the token value.

## Naming

Name each file after the principle it encodes, in kebab-case. Example:
`visual-hierarchy-first.md`, `accessible-by-default.md`.

## This is an example namespace

In a real design-system namespace, one or more pillar files live here. This example
scaffold leaves `pillars/` at the README level so the shape is clear without inventing
content.
