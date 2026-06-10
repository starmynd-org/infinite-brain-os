# Outputs Placement Rules

This file is the operative contract for what belongs in `outputs/` and what must be promoted out
of it.

The doctrine lives in `knowledge/ai-architecture/concepts/outputs.md`. This file states the
builder rule.

## Rule

Use `outputs/` for produced artifacts only: files emitted by workflows, agents, commands,
deterministic runs, or swarm execution that are valuable as artifacts in their emitted form.

Do not treat `outputs/` as the sole durable home of authoritative truth. If an output changes
system understanding, also update the authoritative surface that owns that meaning:

- `knowledge/<namespace>/support/` for provenance or source-preserving support material
- `knowledge/<namespace>/synthesis/` for derived understanding
- `knowledge/<namespace>/canon/`, `_system/`, `projects/`, or another governed home for settled
  rules, doctrine, or planning truth

Nothing durable and authoritative lives only in `outputs/`.

## Minimum output shape

Every output file must carry the standard node keys required by the validator plus explicit
lineage such as:

- `produced_by`
- `created`
- `derived_from` or `informed_by` when applicable
- any local routing key the output family requires

An output family may add stricter requirements in its own contract, for example
`outputs/departments/README.md`.

## Placement posture

- Prefer stable family subfolders under `outputs/` over flat root placement.
- Keep the output artifact where it is produced; promote only the durable meaning to the owning
  authoritative surface.
- Historical flat files may remain as legacy artifacts, but new workflows should follow the
  current family contract.
