# support/

This folder holds provenance and revision history for this Operating Library namespace.
It is mechanical and historical, not interpretive.

## What goes here

- **SOP revision receipts**: when a procedure is updated, record the previous version
  summary, the new version summary, the date of the change, and the reason. If the
  change was triggered by a past incident, link to the example node.
- **Diagnostic revision receipts**: same pattern for diagnostic nodes.
- **Incident post-mortem references**: pointers to external post-mortems or internal
  example nodes that triggered a namespace change.
- **Node rename or move records**: when a procedure or diagnostic is renamed or moved,
  record the old path, the new path, and the alias added to preserve wikilink
  resolution.

## What does not go here

Do not put interpretive thinking here. If a revision reveals a deeper insight about
how the library should be organized, that belongs in `synthesis/`. This folder records
facts about what changed; synthesis records what you make of those changes.

## Relationship to validate.sh

When a node is renamed or moved, the old id must be added to the new file's `aliases`
field, and a record of the rename should be added here. This is the migration
compatibility rule from `_system/migration-compatibility-rules.md`.
