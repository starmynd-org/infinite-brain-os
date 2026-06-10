# Agent Load Order: content-strategy-example

This is navigational. It is not a knowledge node and does not carry node frontmatter.

## Default: always load first

1. `canon/core-doctrine.md` (this namespace's canon synthesis)
2. `INDEX.md` (the retrieval router; scan query classes)

## By query class

**What pillars govern this content program**

1. `canon/core-doctrine.md`
2. `pillars/content-strategy-pillar.md`

**Which angles are active and what are they grounded in**

1. `canon/core-doctrine.md` sections 2 and 3
2. `angles/ai-operator-angle.md` (example; in a real namespace, scan `angles/` by
   lifecycle_state)
3. Cross-links from each angle node to its source pillar and reference nodes

**How to construct a new angle**

1. `canon/core-doctrine.md` section 2
2. `concepts/signal-to-angle.md`
3. `angles/` (scan existing angles to check overlap before proposing a new one)

**What examples exist for a given angle**

1. The angle node itself (its `edges` point to `examples/` nodes)
2. `examples/README.md` for the folder conventions

**How to brief a piece**

1. `playbooks/README.md` (reduced base in scaffold; a real namespace would have
   `playbooks/brief-a-piece.md`)
2. The angle node for the piece

## What to load last

Raw `references/` nodes, `support/` provenance, `synthesis/` contested questions. Load
these only when grounding a specific claim or reviewing a specific dispute. Do not load
them in the default path.
