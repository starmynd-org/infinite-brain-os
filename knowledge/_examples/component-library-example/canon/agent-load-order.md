# Agent Load Order: component-library-example

This file tells a reading agent what to load next after canon, organized by query class.
It is navigational: it has no frontmatter and is exempt from node-frontmatter validation.

## Always load first

`canon/core-doctrine.md`. Load it whole before anything else. It gives you the
governance model that makes all component approval decisions coherent.

## Then, by query class

**Component approval** (is this component approved, what are the rules for using it):
Load the specific component node in `components/`. If no named component matches the
query, load `components/README.md` to understand the inventory.

**Composition pattern** (how to combine components for a recurring UI need):
Load the specific pattern node in `patterns/`. If no pattern matches, load
`patterns/README.md`.

**Deployment and publish** (how to package, version, or publish the library):
Load `deployment/`. Start with the most specific deployment note that matches the
environment or toolchain in question.

**Usage example** (a concrete worked example of components in a real feature):
Load `examples/`. Load the example that most closely matches the feature or screen
described in the query.

**External library or upstream spec** (the third-party library this wraps or extends,
or the upstream design system it implements):
Load `references/`. These nodes link out; they do not duplicate external docs.

**Synthesis or contested question**:
Load `synthesis/`. Canon states settled doctrine; open questions and approval
disputes live in `synthesis/`.

## What not to load

Do not load `support/` unless you are answering a provenance or migration question.
Do not expect source code here; it is in the implementation repository.
