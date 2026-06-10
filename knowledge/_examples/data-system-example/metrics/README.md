# metrics/

This folder holds Metric nodes. Each node uses the shared metric primitive defined in
`_system/metric-primitive-schema.md` ([[metric-primitive-schema]]).

## What goes here

One `.md` file per business metric. The file is a knowledge node with full frontmatter
including all metric primitive fields:

- `type: "Metric"`
- `metric_id`: a stable kebab-case identifier prefixed with `metric-`. This is the key
  that the Operating Library uses to reference this metric from its diagnostic nodes.
- `format`: one of `percent`, `currency`, `ratio`, `count`, `duration`.
- `polarity`: `higher-better`, `lower-better`, or `neutral`.
- `aggregation`: how the metric is aggregated over a time window (`sum`, `avg`, `last`,
  `ratio-of-sums`, `custom`).
- `expression`: the plain or SQL-like definition at the business-logic level.
- `depends_on`: a list of `metric_id` values this metric derives from, if any.
- `instrumentation_status`: recommended in starter systems; one of `live`, `manual`,
  `not-wired`.
- `implementation_path`: recommended in starter systems; for example `example-co-cli`,
  `byo-adapter`, or `manual-sheet`.
- `implementation_owner`: who is expected to make the metric real; for example
  `example-co-managed` or `client-managed`.

Edges must include a `depends_on` edge to the warehouse model node that backs this
metric.

In a starter-thin namespace, the lineage may stop at the source contract or reference model
stub while the live implementation path points elsewhere. That is acceptable only if the
metric makes the implementation posture explicit.

## What does not go here

Do not put pipeline nodes, model schema nodes, or transform SQL nodes in this folder.
Those belong in `pipelines/`, `models/`, and `transforms/` respectively. This folder
holds only the typed metric definition, which is the business-facing contract.

Do not define the same metric in both this namespace and an Operating Library namespace.
Define it here; the Operating Library references it by `metric_id`.

## Example

See `metric-example-order-count.md` in this folder for a complete example using the
metric primitive.
