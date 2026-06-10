# examples/

This folder holds example nodes: published pieces or production-ready drafts that
demonstrate an angle in practice. Each node links back to the angle it illustrates and
records what worked, what did not, and whether the angle's claimed mechanism held.

## What belongs here

- A node per published piece that is worth keeping as a reference case.
- A note on whether the angle landed (did the audience respond to the specific claim,
  or did they respond to something else?).
- A link back to the angle node.

## What does not belong here

- Draft content. Drafts live in `outputs/` with lineage back to a workflow or task.
- Editorial calendar entries. Those are operational state.
- Unstructured notes about a post's performance. Those go in intake for triage.

## Node frontmatter convention

An examples/ node carries `type: "Knowledge"`, `retrieval_class: "domain"`, and an edge
with `relation: "produced_by"` pointing at the angle node it illustrates. If the example
revealed a problem with the angle, add an edge with `relation: "qualifies"` and note it
in the body.
