# Tokens: design-system-example

This folder holds token reference nodes for the namespace. Each node documents a
category of design tokens: their names, approved values, and the semantic intent each
token encodes.

## What goes here

- One node per token category, or one node spanning multiple related categories when
  they are small. Examples: `color-type-space-tokens.md`, `motion-tokens.md`,
  `elevation-tokens.md`.
- Each node carries full frontmatter and lists tokens in a table or structured format.
- The semantic intent of each token (what it means, not just what the value is) is
  stated alongside the value. An agent needs the intent to judge whether a new value
  is correct.

## What does not go here

Implementation code, component-level overrides, and usage examples do not go in
`tokens/`. Implementation lives in the implementation repo. Usage examples live in
`examples/`.

## Freshness

Token values change across releases. Mark the token file with a `created` date and
update the `## Changelog` section on each revision. Freshness review fires on
every design-system release.

## This is an example namespace

`color-type-space-tokens.md` in this folder is the characteristic example node for the
design-system profile. It is illustrative content, not a real token set.
