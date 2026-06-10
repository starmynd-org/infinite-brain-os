# transforms/

This folder holds transform nodes. A transform node documents the business logic that
reshapes or enriches raw records before they reach a warehouse model.

## What goes here

One `.md` file per transform. The file is a knowledge node with full frontmatter. It
documents:

- The raw input table or view it reads from (link to the pipeline or raw model).
- The output table or view it writes to (link to the downstream model).
- The logic: normalization rules, joins, filters, derived columns, and status enum
  mappings.
- The refresh behavior: is this a scheduled job, a triggered view, or a manual run?

You may include the actual SQL or transformation code as a code block, or link to the
implementation file in the source repo.

## What does not go here

Do not put source field definitions here. Those belong in `source-contracts/`. Do not
put metric expressions here. Metric expressions belong in `metrics/`.

## Relationship to other layers

A transform node sits between the raw pipeline output and the clean warehouse model.
It depends on one or more pipeline outputs and produces one or more model inputs.
Metric nodes then depend on the model nodes that this transform feeds.
