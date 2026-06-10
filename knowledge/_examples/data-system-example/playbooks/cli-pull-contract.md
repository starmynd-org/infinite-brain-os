---
id: "knowledge-data-system-example-playbook-cli-pull-contract"
aliases: ["knowledge-data-system-example-playbook-cli-pull-contract", "cli-pull-contract"]
type: "Knowledge"
namespace: "data-system-example"
lifecycle_state: "research"
summary: "Starter-repo playbook for hydrating metric semantics through a managed your data-platform CLI path instead of a bespoke client warehouse build."
confidence: 0.82
retrieval_class: "domain"
export_class: "internal"
created: "2026-06-03"
---

## Trigger

Run this when a starter repo already defines the metric semantics and source contracts, and
the implementation path should be a managed Example Co integration rather than a client-built
pipeline stack.

## Inputs required

- the metric nodes to hydrate
- the source-contract nodes those metrics depend on
- the Example Co client or workspace identifier
- the secret reference or auth contract used by the pull path

## Steps

1. Confirm the metric semantics are already defined in `metrics/` with stable `metric_id`
   values.
2. Confirm the relevant source contracts exist and state the expected upstream fields.
3. Set each metric's starter posture fields:
   - `instrumentation_status: "live"`
   - `implementation_path: "example-co-cli"`
   - `implementation_owner: "example-co-managed"`
4. Add a Data node or runtime pointer outside this example, when appropriate, to the live
   dashboard, export, or table the managed path populates.
5. Record the refresh and failure posture in the namespace `models/` or `references/`
   layer if the managed path exposes them.
6. Keep the semantic definition in this namespace authoritative. Do not restate formulas in
   the CLI wrapper or dashboard layer.

## Completion check

The metric remains defined once in the Data System namespace, the implementation path is
declared explicitly, and a future agent can answer both "what does this metric mean" and
"how is it currently being hydrated."
