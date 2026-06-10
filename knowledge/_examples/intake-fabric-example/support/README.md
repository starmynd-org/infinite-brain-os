# support/

This folder holds provenance and migration records for the `intake-fabric-example`
namespace scaffold.

The live intake scaffold is at repo root `intake/`. This support folder holds only:

- Migration context: how the intake scaffold was built or migrated from prior tooling
  (such as a small FastAPI connector app's mailboxes.json and inbox-zero prompt).
- Source-priority notes: if the intake routing doctrine was seeded from a prior document
  or workflow, record that source mapping here.
- Retrieval eval queries for this namespace, when added.

## Scope note

This folder is intentionally minimal in the example scaffold. A real intake-fabric
namespace would add a migration receipt when the connector app is
integrated into the durable intake layer, documenting which source families were
migrated, what schemas were adapted, and what remains in the operational app layer.

## Pointing to the live scaffold

The live intake fabric is at:

```text
intake/
  README.md
  sources/
  processed/
  routing/
  playbooks/
  namespaces/
  schemas/
```

An agent looking for operational intake documentation should follow links from this
namespace's `INDEX.md` and canon to `intake/README.md` at repo root, not look here.
Support here is for provenance only.
