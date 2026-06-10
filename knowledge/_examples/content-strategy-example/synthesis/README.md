# synthesis/

This folder holds within-namespace derived thinking: contradiction maps, best-current-reading
notes, what-changed reviews, and canon-candidate packages.

## Synthesis vs support boundary

`synthesis/` holds interpretive, current, derived work. `support/` holds provenance and
migration records (mechanical and historical). Do not put synthesis in `support/`. Do not
put migration receipts in `synthesis/`.

## What belongs here

- A contradiction map when two angles or pillars say inconsistent things and the
  resolution is not yet clear.
- A best-current-reading note when the operator's synthesized answer on a contested
  topic needs to be recorded before it is ready for canon.
- A what-changed review after a significant product shift or market event that affects
  the content strategy.
- A canon-candidate package when a synthesis is ready to propose for promotion to
  `core-doctrine.md`.

## What does not belong here

- Settled doctrine. That belongs in `canon/` or `pillars/`.
- Raw signals or research. Those belong in `references/` or in `intake/`.
- Operational notes or draft content. Those belong in `outputs/` or the project layer.

## Node frontmatter convention

Synthesis nodes carry `type: "Knowledge"`, `lifecycle_state: "research"` until promoted
to `candidate`, and edges pointing at the nodes they derive from or connect. A canon-candidate
also carries `lifecycle_state: "candidate"` and an edge with `relation: "supports"`
pointing at `core-doctrine.md`.
