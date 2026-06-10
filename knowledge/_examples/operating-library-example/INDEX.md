# operating-library-example

This is a reduced-base EXAMPLE scaffold for the operating-library profile. It is not a
real namespace. It exists so an agent or operator can copy this folder when starting a
new Operating Library namespace, see the correct structure in a minimal self-consistent
state, and understand what each layer is for. No live operations run through here. All
nodes are illustrative.

## Profile

operating-library. This profile documents how to execute recurring work and how to
diagnose problems. The characteristic folders are `procedures/` (SOPs), `diagnostics/`
(how to investigate a metric or system anomaly), and `decision-trees/` (structured
branching logic for common situations). The metric primitive ([[metric-primitive-schema]])
bridges this namespace to a Data System namespace: a diagnostic node references a metric
by its `metric_id`, rather than redefining it.

## Load first

Canon entry points, in order:

1. [[operating-library-example/canon/README]]: what canon means in an Operating Library
   namespace.
2. [[operating-library-example/canon/core-doctrine]]: the compressed first-principles
   synthesis for operating library design. Read before expanding into specific procedures
   or diagnostics.
3. [[operating-library-example/canon/agent-load-order]]: what to load next by query
   class.

Top nodes after canon:

- [[sop-example-daily-metric-review]]: the example SOP node. Shows trigger, inputs,
  numbered steps, and escalation condition.
- [[diag-example-order-count-drop]]: the example diagnostic node. References
  `metric-example-order-count` by its `metric_id`, showing how the metric primitive
  bridges Data System and Operating Library.

## Query classes

- **How to run a recurring task** (what is the trigger, what are the steps, what is the
  escalation): load the relevant `procedures/<sop>.md` directly. If you do not know
  which SOP applies, load `canon/core-doctrine.md` first to understand how procedures
  are organized.
- **How to diagnose a metric anomaly** (metric dropped or spiked, what to check first):
  load `diagnostics/<diag>.md` for the relevant metric. If the diagnostic references a
  `metric_id`, cross-load the metric definition from the Data System namespace that owns
  it.
- **Which procedure to follow given a condition** (branching logic): load
  `decision-trees/<tree>.md` for the situation.
- **Examples of past runs or resolved incidents** (for calibration): load `examples/`.

## Stable vs stateful

Stable (changes only on real process revision): the SOP trigger, the diagnostic failure
modes, the decision tree branching logic. These carry `review-on-edit` freshness.

Stateful (needs periodic check): the escalation contacts, the metric thresholds used as
diagnostic signals, the frequency of known incident types. Review these when the
underlying metrics or team structure changes.

## Open disputes

This is an example namespace so it carries no real disputes. In a production Operating
Library namespace, contested topics such as whether a particular anomaly is expected or
a bug, or disagreements on escalation thresholds, would live in `synthesis/`.

## What this namespace drives

A real Operating Library namespace canon should improve:

- how fast an operator or agent diagnoses a known problem type
- whether the right person is contacted at the right escalation threshold
- whether recurring tasks are executed consistently with no steps skipped
- how quickly a new team member can run an unfamiliar process

## Archive and provenance

This example carries no `archive/`. Use `support/` for:

- records of past SOP revisions and the reasons for each change
- incident post-mortems that informed a diagnostic update

## Common misreadings

- Redefining a metric in a diagnostic node instead of referencing it by `metric_id`.
  The Data System namespace owns the definition; the diagnostic only uses the identifier.
- Treating SOPs as decision trees. SOPs are linear, triggered procedures. Decision trees
  are branching structures for choosing between procedures. Keep them in separate folders.
- Putting live incident state in this namespace. This is a knowledge namespace. Incident
  tracking and live queue state belong in the operational app layer.
- Writing a diagnostic for a metric that has no metric node in a Data System namespace.
  Always create the metric node first; then write the diagnostic.

## Map

```text
knowledge/_examples/operating-library-example/
  INDEX.md                                      # this retrieval router (you are here)
  canon/
    README.md                                   # what canon means here (navigational)
    core-doctrine.md                            # compressed first-principles synthesis (knowledge node)
    agent-load-order.md                         # load order by query class (navigational)
  procedures/
    README.md                                   # what a procedure (SOP) node is and what it must contain
    sop-example-daily-metric-review.md          # example SOP with trigger, inputs, steps, escalation
  diagnostics/
    README.md                                   # what a diagnostic node is and how it uses metric_id
    diag-example-order-count-drop.md            # example diagnostic referencing metric-example-order-count
  decision-trees/
    README.md                                   # what a decision tree node is
  examples/
    README.md                                   # past resolved examples for calibration
  references/
    README.md                                   # external references (runbooks, vendor docs)
  metrics/
    README.md                                   # optional: local metric references (when tied to diagnosis)
  synthesis/
    README.md                                   # within-namespace synthesis (navigational)
  support/
    README.md                                   # provenance and SOP revision history (navigational)
  playbooks/
    README.md                                   # procedures for maintaining this namespace itself
```

This scaffold is validator-exempt from the base-surface requirement (it lives under
`knowledge/_examples/`). Frontmatter on real nodes is valid and complete.
