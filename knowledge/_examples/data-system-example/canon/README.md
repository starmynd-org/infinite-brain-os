# Canon: data-system-example

This is the canon layer for the data-system-example scaffold. It is an example, not
production canon. The purpose here is to show what a Data System canon layer looks like
in practice: a small set of compressed, provenance-bearing files that give an agent the
first-principles understanding before it expands into source contracts, pipelines, or
metrics.

## What canon means in a Data System namespace

Canon in a Data System namespace compresses the key design decisions and principles that
govern the data flow: what the source of truth is for each metric, how the layers
(source to raw to transform to model to metric) relate to each other, and what rules
keep the graph trustworthy. It does not duplicate the source contracts or model schemas.
It synthesizes the reasoning behind them.

## How canon is approved

In a production namespace, canon files require operator review before a node is promoted
from `lifecycle_state: research` to `lifecycle_state: canon`. The `derived_from` edges
must point to the source-contract, transform, and model nodes that the synthesis draws
from. The `verified_at` and `verified_by` fields must be filled.

In this example scaffold, `core-doctrine.md` carries `lifecycle_state: research` to
show the shape of a real canon node, not a finished one.

## How to update canon

1. Identify which source contract, model, or metric changed.
2. Update the affected node in its profile-specific folder.
3. Determine whether the change affects core-doctrine (a design principle changed) or
   only a detail node.
4. If core-doctrine changes, revise it, update `verified_at`, and append a line to the
   `## Changelog` section at the bottom of the file.
5. Run `bash _system/validate.sh` to confirm no broken links or missing frontmatter.

## Files in this canon layer

- `README.md` (this file): navigational, not a knowledge node.
- `core-doctrine.md`: the compressed first-principles synthesis. The keystone.
- `agent-load-order.md`: load order by query class. Navigational.
