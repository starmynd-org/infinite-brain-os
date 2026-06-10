# diagnostics/

This folder holds diagnostic nodes. A diagnostic node is an investigation guide for a
specific metric anomaly or system failure. It does not define the metric; it uses the
metric's `metric_id` to reference the definition owned by a Data System namespace.

## What goes here

One `.md` file per diagnostic scenario. A diagnostic node must carry:

- The `metric_id` it investigates. Use the `metric_id` field in frontmatter and link to
  the metric node by its `metric_id` in the body. Do not copy the metric expression.
- **What moves it**: the known drivers that cause this metric to rise or fall. Concrete
  and specific.
- **Failure modes**: the specific failure conditions that produce an anomaly in this
  metric. Each failure mode is a distinct checklist item.
- **What to check first**: the first two or three things to inspect, in priority order.
  Lead with the fastest check that would confirm or rule out the most common cause.
- **Next action per finding**: for each failure mode or check result, a specific next
  action. "Investigate further" is not a next action.

## What does not go here

Do not redefine the metric. Do not put transform SQL here. Do not put SOP steps here.
If the diagnosis concludes that an SOP should be run, link to the SOP; do not inline
its steps.

## Metric primitive bridge

The key rule for diagnostic nodes: reference the metric by its `metric_id`. This is the
bridge between the Operating Library and the Data System namespace. When the metric
definition changes in the Data System namespace, the diagnostic remains valid because it
references the id, not the expression.

## Example

See `diag-example-order-count-drop.md` in this folder for a complete example.
