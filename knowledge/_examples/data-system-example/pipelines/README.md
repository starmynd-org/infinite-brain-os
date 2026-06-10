# pipelines/

This folder holds pipeline nodes. A pipeline node documents how raw records arrive from
a source and where they land.

## What goes here

One `.md` file per pipeline job. The file is a knowledge node with full frontmatter. It
documents:

- The source it reads from (link to the source contract node).
- The schedule or trigger: cron expression, event-driven, or manual.
- The destination table in the warehouse, with the dataset and table name.
- The credentials reference (not the secret value; the path in the secrets store).
- The failure posture: what happens when the pipeline fails, who is notified, whether
  it retries.

## What does not go here

Do not put transform logic in a pipeline node. The pipeline is the extraction and
loading step only. Business logic that reshapes records belongs in `transforms/`.

Do not put metric definitions here. A pipeline node knows nothing about metrics; it only
lands raw records.

## Relationship to other layers

A pipeline node links to the source contract it reads from and to the raw model or table
it writes to. A transform node then links to that raw model as its input.
