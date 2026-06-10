# metrics/ (optional)

This folder is optional in an Operating Library namespace. Add it when the namespace
needs local metric references tied specifically to diagnostic use, beyond what the Data
System namespace provides directly.

## When to add this folder

Add `metrics/` to an Operating Library namespace when:

- The namespace uses a metric that is not yet defined in any Data System namespace and
  you need a placeholder reference to unblock a diagnostic node.
- The namespace tracks a process or operational metric (for example, "time to diagnose
  an incident") that does not belong in a Data System namespace.

## What does not go here

Do not redefine a metric that is already defined in a Data System namespace. If the
metric exists in a Data System namespace with a stable `metric_id`, reference it there.
This folder is not a second definition point; it is a home for genuinely local
operational metrics or temporary placeholders.

## Metric primitive still applies

Even local operational metrics must use the shared metric primitive: `type: "Metric"`,
`metric_id`, `format`, `polarity`, `aggregation`, `expression`, `depends_on`. See
[[metric-primitive-schema]].

## This example

The operating-library-example scaffold includes this folder to show it is available as
an optional surface. No metric nodes are seeded here; the example diagnostic
([[diag-example-order-count-drop]]) references `metric-example-order-count` from the
data-system-example namespace instead, which is the preferred pattern.
