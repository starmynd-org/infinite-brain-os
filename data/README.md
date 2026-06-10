# Data

Data nodes are pointers, never live numbers. A Data node names where a dataset, table,
dashboard, or report lives (with a `state_stored_at` edge) so agents can cite the source of a
number without the repo ever becoming a system of record for metrics.

This folder ships empty except for the starter example. Add one pointer node per dataset or
reporting surface your brain coordinates with. See `_system/metric-primitive-schema.md` for
the metric primitive and the example Data node for the shape.
