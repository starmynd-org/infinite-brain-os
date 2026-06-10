# Agent Load Order: data-system-example

This file tells an agent what to load first, by query class, when entering this namespace.
It is navigational and is not a knowledge node.

## Always load first

Read `canon/core-doctrine.md` before expanding into any other node. It gives you the
five-layer model, the metric primitive contract, and the source-of-truth rules. Without
it, you will misinterpret what individual source contracts or metric nodes say.

## By query class

**"What does metric X mean and how is it calculated?"**
Load `canon/core-doctrine.md`, then `metrics/<metric>.md`. Follow `depends_on` edges
to the model node if you need to trace the calculation to SQL.

**"Where does this number come from?" (lineage trace)**
Load `metrics/<metric>.md`, follow `depends_on` to `models/<model>.md`, follow its
`depends_on` to `transforms/<transform>.md`, follow that to
`source-contracts/<contract>.md`. That is the full upstream chain.

**"What does the source API provide?"**
Load `source-contracts/<contract>.md` directly. Check `architecture/README.md` for how
multiple sources relate to each other.

**"How often is this data refreshed and what runs it?"**
Load `pipelines/<pipeline>.md` and `models/<model>.md` (the model carries refresh
cadence).

**"Is there a known data quality issue or open dispute?"**
Load `synthesis/README.md` first. The synthesis folder holds contradiction maps and
best-current-reading notes for contested topics.

## What to skip on first load

`references/`, `support/`, and `playbooks/` are secondary surfaces. Load them only when
you need external documentation, migration provenance, or procedural guidance. They do
not carry the core reasoning.
