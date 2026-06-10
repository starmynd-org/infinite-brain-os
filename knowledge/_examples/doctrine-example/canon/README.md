# Canon: doctrine-example

This folder holds the compressed first-principles reasoning layer for this namespace.
It is what an agent should think from before it expands into the deeper graph.

## What lives here

- `core-doctrine.md`: the keystone knowledge node. A compressed, operator-approved
  synthesis of the best current first-principles understanding. It cites the pillars,
  concepts, and decisions it derives from. It is small relative to the graph it sits over.
- `agent-load-order.md`: the load-order controller. A navigational file that tells agents
  what to read next, by query class.

## What does not live here

- Copies or paraphrases of individual `pillars/` nodes. Canon synthesizes; it does not
  restate.
- Open questions or unresolved disputes. Those belong in `synthesis/`.
- Runtime state, raw archive, or public export surfaces.

## How to update canon

Canon is updated only when the underlying settled doctrine changes. The sequence:

1. Identify the change: a new pillar, a revised concept, a decision that shifts the
   first-principles picture.
2. Draft the revision in `synthesis/` as a canon-candidate.
3. Operator reviews and approves.
4. Update `core-doctrine.md` and increment the `## Changelog` entry.
5. Update `verified_at` and `verified_by` in the frontmatter.

Do not edit `core-doctrine.md` directly to resolve an open question. Route disputed
material to `synthesis/` first.

## Navigational note

This README is navigational. It does not carry node frontmatter. `core-doctrine.md`
carries full node frontmatter because it is a real knowledge node.
