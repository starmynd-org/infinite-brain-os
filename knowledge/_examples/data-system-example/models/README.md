# models/

This folder holds warehouse model nodes. A model node documents the table or view that
data consumers query.

## What goes here

One `.md` file per model. The file is a knowledge node with full frontmatter. It
documents:

- The warehouse location: dataset, table or view name, and the warehouse system
  (for example, BigQuery or Redshift).
- The schema: columns, types, and descriptions.
- The refresh cadence: how often the model is updated and what drives the update.
- The transform it depends on (link to the transform node).
- The metrics and downstream nodes that read from this model.

## What does not go here

Do not put transform logic or source field definitions here. The model node documents
the stable consumer-facing shape of the data, not how it was produced. That reasoning
lives in the transform and source contract nodes.

## Relationship to other layers

A model node is the output of a transform and the input for one or more metric nodes.
When the model schema changes, any metric nodes that depend on it must be reviewed to
confirm the expression is still valid.
