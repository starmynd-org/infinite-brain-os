---
id: "knowledge-operating-library-example-canon-core-doctrine"
aliases: ["knowledge-operating-library-example-canon-core-doctrine", "operating-library-example-core-doctrine"]
type: "Knowledge"
namespace: "operating-library-example"
lifecycle_state: "research"
summary: "Compressed first-principles synthesis for an Operating Library namespace: SOP structure, diagnostic design, metric bridging, and escalation rules."
confidence: 0.85
retrieval_class: "identity"
export_class: "internal"
verified_at: "2026-05-30"
verified_by: "scaffold-build-agent"
edges:
  - target: "[[sop-example-daily-metric-review]]"
    relation: "derived_from"
    confidence: 0.9
  - target: "[[diag-example-order-count-drop]]"
    relation: "derived_from"
    confidence: 0.9
  - target: "[[metric-primitive-schema]]"
    relation: "implements"
    confidence: 0.95
  - target: "[[namespace-profiles]]"
    relation: "implements"
    confidence: 0.9
created: "2026-05-30"
---

An Operating Library namespace is the authoritative record of how recurring work is
executed and how problems are diagnosed. It does not hold live state; it holds the
procedures, diagnostics, and decision logic that agents and operators follow. Every node
in this namespace answers one of three questions: how do I run this, how do I diagnose
this, or which path should I take given these conditions.

## The three node types

**Procedures (SOPs)**: step-by-step guides for recurring tasks. A procedure must carry
a trigger (what starts it), inputs (what is required before you begin), numbered steps
(what you do), and an escalation condition (when to stop and involve someone else).
A procedure with no trigger is not yet a procedure; it is a note.

**Diagnostics**: investigation guides for metric anomalies or system failures. A
diagnostic must reference the metric it investigates by `metric_id`. It does not
redefine the metric; it documents what moves it, what failure modes exist, what to
check first, and what next action to take for each finding. Diagnostics bridge this
namespace to the Data System namespace that owns the metric definition.

**Decision trees**: branching logic for choosing between procedures or actions. A
decision tree takes a situation as input and routes the operator to the right procedure
or escalation path. Decision trees are useful when the trigger is ambiguous or when the
right procedure depends on a condition that must be checked first.

## The metric primitive bridge

Every diagnostic node in this namespace that investigates a metric references that
metric by `metric_id`, not by name alone. The `metric_id` is defined in the Data System
namespace that owns the metric (for example, `metric-example-order-count` in
[[data-system-example]]). This rule keeps definitions single-sourced. When a metric
expression changes, only the Data System namespace updates; the diagnostic's `metric_id`
reference remains valid.

The edge relation to use from a diagnostic node to the metric node is `references` with
the `metric_id` field populated. Do not copy the metric expression into the diagnostic.

## Escalation design

Every SOP must define its escalation condition: the moment when the operator or agent
running the procedure should stop and involve a human or a different process. Escalation
conditions are explicit criteria, not vague guidance. "If the metric is below threshold
X, escalate to the data team" is a valid escalation condition. "Use judgment" is not.

The escalation threshold may reference a metric. In that case, cite the `metric_id` so
the threshold can be updated in one place when the metric definition changes.

## What belongs here and what does not

Belongs here: SOPs, diagnostic guides, decision trees, worked examples of past resolved
incidents (in `examples/`), references to external runbooks, and reasoning about how
the library is organized.

Does not belong here: live incident state, metric definitions, data model schemas,
dashboard configuration, or alert rule definitions. Those belong in the operational app
layer or in a Data System namespace.

## Changelog

- 2026-05-30: Initial scaffold version authored by sprint build agent.
