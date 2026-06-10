# Components: component-library-example

This folder holds approved component records for the namespace. Each record is the
governance and usage contract for one component.

## What goes here

- One node per approved component.
- Each node carries full frontmatter and states:
  - What the component is and what it does.
  - When to use it and when not to.
  - The usage constraints (configuration rules, composition rules, accessibility
    requirements).
  - A link to the canonical implementation location in the implementation repository.
  - A pointer to the relevant usage playbook in `playbooks/` if one exists.
- The component's approval status: `approved`, `deprecated`, or `under-review`. Stated
  in the node body or as a frontmatter tag.

## What does not go here

Source code does not go here. The implementation lives in the implementation repository.
Do not paste component code into a component record; link to it. When the code changes,
the link stays valid; pasted code silently drifts.

Composition patterns do not go here; they go in `patterns/`. A component record
describes one atomic component.

## Naming

Name each file after the component in kebab-case: `data-table-component.md`,
`modal-dialog-component.md`.

## This is an example namespace

`data-table-component.md` in this folder is the characteristic example node for the
component-library profile. It is illustrative content.
