# Agent Load Order: operating-library-example

This file tells an agent what to load first, by query class, when entering this
namespace. It is navigational and is not a knowledge node.

## Always load first

Read `canon/core-doctrine.md` before expanding into any other node. It gives you the
three node types, the metric primitive bridge rule, and the escalation design principle.
Without it, you may confuse diagnostics with SOPs, or copy a metric expression instead
of referencing the `metric_id`.

## By query class

**"How do I run this recurring task?"**
Load `procedures/<sop>.md` directly if you know the task name. If you do not know which
SOP applies, load `decision-trees/` to find the right branching path. Then load the
target SOP.

**"Why is metric X lower than expected?" (anomaly diagnosis)**
Load `diagnostics/<diag>.md` for that metric. If the diagnostic references a `metric_id`,
cross-load the metric definition from the Data System namespace that owns it to confirm
the expression has not changed. Follow the diagnostic's "what to check" steps in order.

**"Which procedure should I run given condition Y?"**
Load `decision-trees/<tree>.md` for that situation. Decision trees route you to the
right SOP.

**"Has this type of incident happened before and how was it resolved?"**
Load `examples/` for past resolved incidents. These are calibration examples, not
current state.

**"Is there an open question about how this diagnostic works?"**
Load `synthesis/README.md`. Contested diagnostic logic or disputed thresholds live in
synthesis, not in the diagnostic node itself.

## What to skip on first load

`references/`, `support/`, and `playbooks/` are secondary surfaces. Load them only
when you need external runbook links, SOP revision history, or procedural guidance for
maintaining the namespace itself.
