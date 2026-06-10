# data-system-example

This is a reduced-base EXAMPLE scaffold for the data-system profile. It is not a real
namespace. It exists so an agent or operator can copy this folder when starting a new
Data System namespace, see the correct structure in a real but minimal state, and
understand what each layer is for. No production data flows through here. All nodes are
illustrative.

This example also shows the starter-repo posture: a thin semantic layer with explicit
implementation paths. The metrics are defined once here; a managed substrate such as
your data-platform CLI may hydrate them, a non-Example Co client may map its own sources into the same
contract, or a metric may remain intentionally `not-wired`.

## Profile

data-system. This profile documents data flow from source APIs through extraction,
transforms, warehouse layers, metric definitions, and dashboard use. The metric primitive
([[metric-primitive-schema]]) is the keystone: a metric node defined here carries lineage
back to the source and connects forward to the operating library that diagnoses it.

## Load first

Canon entry points, in order:

1. [[data-system-example/canon/README]]: what canon means in a Data System namespace.
2. [[data-system-example/canon/core-doctrine]]: the compressed first-principles synthesis
   for data system design. Read this before expanding into any specific layer.
3. [[data-system-example/canon/agent-load-order]]: what to load next by query class.

Top nodes after canon:

- [[metric-example-order-count]]: the example Metric node. Shows the metric primitive
  in full: metric_id, format, polarity, aggregation, expression, depends_on, lineage edges.
- [[source-contract-example-orders-api]]: the source contract stub. Shows how a source
  API is described before any pipeline is built.

## Query classes

- **Source and extraction** (what is the source, what does the raw contract say): load
  [[source-contract-example-orders-api]], then expand to `architecture/` for the data flow map.
- **Metric definition** (what does a metric mean, how is it calculated): load
  [[metric-example-order-count]], then follow `depends_on` edges to transform and model nodes.
- **Lineage trace** (where does a number come from, which transforms and models feed it):
  load [[metric-example-order-count]], then load `transforms/` and `models/` nodes in the
  `depends_on` chain.
- **Pipeline and refresh** (how often does data arrive, what runs the load): load
  `pipelines/` nodes and `models/` for refresh cadence.
- **Starter implementation posture** (is this live through Example Co, manually maintained,
  or client-mapped): load `playbooks/cli-pull-contract.md`,
  `playbooks/bring-your-own-data-mapping.md`, and
  `references/starter-instrumentation-statuses.md`.

## Stable vs stateful

Stable (changes only on real schema revision): the source contract, the metric expression,
the transform logic, the warehouse model schema. These carry `review-on-edit` freshness.

Stateful (needs periodic check): the refresh cadence, the pipeline health status, the
data freshness timestamp. These should carry `periodic` freshness posture.

## Open disputes

This is an example namespace so it carries no real disputes. In a production Data System
namespace, contested topics such as metric definition disagreements or schema versioning
choices would live in `synthesis/` as contradiction maps.

## What this namespace drives

A real Data System namespace canon should improve:

- which metrics flow into dashboards and reports
- how analysts and agents answer "where does this number come from"
- how the pipeline team knows when a source contract has changed
- how the operating library diagnoses a metric anomaly (via shared metric_id)
- how a starter repo stays useful before bespoke client data engineering exists

## Archive and provenance

This example carries no `archive/`. Use `support/` for:

- the schema migration receipt when a source API version changes
- the source-priority table when two sources conflict on the same field

## Common misreadings

- Treating the Metric node as a dashboard widget. A Metric node is a typed knowledge
  node with lineage and a shared `metric_id`; the dashboard widget reads the metric.
- Defining the same metric in both the Data System and the Operating Library. Define it
  once here; the Operating Library references it by `metric_id`.
- Putting transform SQL directly in the metric node. The metric node holds the expression
  at the business-logic level. The SQL lives in the transform node the metric depends on.
- Storing live refresh logs in this namespace. Refresh logs are operational state; only
  the model schema and refresh cadence belong here.
- Confusing "thin starter" with "no data system." The starter posture still defines the
  metrics and pull contract; it only defers bespoke implementation depth.

## Map

```text
knowledge/_examples/data-system-example/
  INDEX.md                              # this retrieval router (you are here)
  canon/
    README.md                           # what canon means here (navigational)
    core-doctrine.md                    # compressed first-principles synthesis (knowledge node)
    agent-load-order.md                 # load order by query class (navigational)
  architecture/
    README.md                           # the data flow map for this namespace
  source-contracts/
    README.md                           # what a source contract is and what fields it carries
    source-contract-example-orders-api.md  # example source contract node
  pipelines/
    README.md                           # what a pipeline node documents
  transforms/
    README.md                           # what a transform node documents
  models/
    README.md                           # what a model node documents
  metrics/
    README.md                           # what a metric node is and why it uses the metric primitive
    metric-example-order-count.md       # example Metric node with full metric primitive frontmatter
  references/
    README.md                           # external references and upstream docs
    starter-instrumentation-statuses.md # live/manual/not-wired contract
  synthesis/
    README.md                           # within-namespace synthesis (navigational)
  support/
    README.md                           # provenance and migration receipts (navigational)
  playbooks/
    README.md                           # repeatable procedures for maintaining this namespace
    cli-pull-contract.md       # managed implementation path for starter repos
    bring-your-own-data-mapping.md      # client-managed implementation path
```

This scaffold is validator-exempt from the base-surface requirement (it lives under
`knowledge/_examples/`). Frontmatter on real nodes is valid and complete.
