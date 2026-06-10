# support/

This folder holds provenance and migration receipts for this namespace. It is mechanical
and historical, not interpretive.

## What goes here

- **Schema migration receipts**: when a source API changes a field name, type, or enum,
  record the old shape, the new shape, the date of the change, and which nodes were
  updated.
- **Source-priority tables**: when two sources provide overlapping fields and one takes
  precedence, document the decision and the date it was made.
- **Reorganization maps**: when nodes are renamed, moved, or merged, record the old path,
  the new path, and the alias added to preserve wikilink resolution.

## What does not go here

Do not put derived intellectual work here. If you are interpreting what a field change
means for a downstream metric, that interpretation belongs in `synthesis/`. The `support/`
folder records facts about what changed; `synthesis/` records what you make of those
changes.

## Relationship to validate.sh

When a node is renamed or moved, the old id must be added to the new file's `aliases`
field, and a record of the rename should be added here. This is the migration
compatibility rule from `_system/migration-compatibility-rules.md`.
