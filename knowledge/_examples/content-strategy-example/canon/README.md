# Canon: content-strategy-example

This is the canon layer for the `content-strategy-example` namespace scaffold. It is
navigational. It is not a knowledge node and does not carry node frontmatter.

## What canon means here

Canon for a content-strategy namespace is the compressed, operator-approved synthesis of
what the content program is for, what it stands on, and how its pillars and angles
connect to the broader marketing and product doctrine. It is the first thing an agent
loads when answering any question about why the content program exists or what it should
produce. It is small relative to the full `pillars/`, `concepts/`, `angles/`, and
`examples/` graph below it.

Canon is not a copy of the pillars. It synthesizes across them. If canon and a pillar
say the same thing at the same length, canon is wrong.

## What lives in canon here

- `core-doctrine.md`: the compressed synthesis. This is the authoritative node. Full
  node frontmatter, `derived_from` edges, `verified_at`, `verified_by`, `## Changelog`.
- `agent-load-order.md`: which files to load in which order for which query class.
  Navigational only.

A stateful content namespace (one tracking current active campaigns or live positioning)
may add `current-truth.md` to record current offer, current positioning claims, or the
current content calendar structure. This example scaffold does not include one.

## How canon is updated

1. A synthesis is proposed in `synthesis/` as a canon-candidate node.
2. The operator reviews and approves.
3. The approved synthesis is promoted to `core-doctrine.md` with a `## Changelog` entry.
4. `agent-load-order.md` is updated if the load sequence changes.

No agent may edit `core-doctrine.md` directly without an operator approval event. Agents
may write canon-candidate nodes to `synthesis/`.
