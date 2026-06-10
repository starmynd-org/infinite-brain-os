# Agent Load Order: intake-fabric-example

This is navigational. It is not a knowledge node and does not carry node frontmatter.

## Default: always load first

1. `canon/core-doctrine.md` (the compressed intake-fabric doctrine)
2. `intake/README.md` at repo root (the live scaffold; follow the link after reading canon)

## By query class

**What is the intake fabric and where does it live**

1. `canon/core-doctrine.md` sections 1 and 3
2. `intake/README.md` at repo root

**Why does intake have a three-layer split**

1. `canon/core-doctrine.md` section 2
2. `decisions/three-layer-split-decision.md`

**How to process an inbound item**

1. `canon/core-doctrine.md` section 3 (the table: where things live)
2. `playbooks/how-to-process-an-intake-item.md` (which points to `intake/playbooks/`)
3. `intake/playbooks/<source-family>.md` at repo root for the specific source

**Where do intake-processed items land in knowledge**

1. `canon/core-doctrine.md` section 4 (intake never owns truth)
2. `intake/routing/destination-rules.md` at repo root for the routing map

**What record schemas govern intake**

1. `intake/schemas/` at repo root directly; the schemas live there, not here

## What to load last

`support/README.md` (migration provenance). Load only when auditing a migration or
reviewing how the intake scaffold was built.
