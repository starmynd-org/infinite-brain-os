# Agent Load Order: design-system-example

This file tells a reading agent what to load next after canon, organized by query class.
It is navigational: it has no frontmatter and is exempt from node-frontmatter validation.

## Always load first

`canon/core-doctrine.md`. Load it whole before anything else. It gives you the
principles and constraints that make all token and asset decisions coherent.

## Then, by query class

**Token values** (what color, type size, or spacing value is approved for X):
Load `tokens/color-type-space-tokens.md`. If the token file has subsections, load
the subsection relevant to the query. Do not load all of `tokens/` unless the query
spans all three categories.

**Design principles** (why a token or pattern was chosen, what rule constrains it):
Load `pillars/`. A real namespace will have one or more pillar files here; load the
one whose title matches the principle in question.

**Usage and application** (how to use a token in a specific component or pattern):
Load `examples/`. The usage example is authoritative for that application.

**Asset inventory** (what approved logos, icons, or illustrations exist):
Load `assets/README.md` first. If the query names a specific asset, load its record
in `assets/`.

**External reference or source spec**:
Load `references/README.md`. If the query names a specific external system, load its
reference file.

**Synthesis or contested question**:
Load `synthesis/`. Canon states settled doctrine; open questions and comparisons live
in `synthesis/`.

## What not to load

Do not load `support/` unless you are answering a provenance or migration question.
`support/` holds receipts and reorganization maps, not design knowledge.
