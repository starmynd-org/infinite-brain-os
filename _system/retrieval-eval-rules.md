# Retrieval Eval Rules

Operative rules for the retrieval evaluation gate: each serious namespace ships a small
set of representative queries with expected load sets or answers, so the upgrade is
falsifiable. This file is the executable rule layer. The retrieval consumer and load order
the eval tests against are governed by [[retrieval-load-order-policy]]; the why retrieval
is the operating layer is in [[retrieval-over-raw-memory]].

Scope: guardrail G9 (evaluation gates) and contract Part 13. An eval set turns "the
namespace looks done" into "an agent can retrieve the right fragments for these queries."

## Why every serious namespace gets an eval set

Rule EVAL-1: a namespace upgrade is not falsifiable without an eval set. A reorganized
namespace can look complete and still fail to surface the right fragments for real tasks.
The eval set is the test: it names queries an agent will actually ask and the load set or
answer that proves retrieval works.

Rule EVAL-2: an eval set is required for every serious namespace. Starter and example
namespaces (`personal-operator`, reduced-base namespaces that say so in `INDEX.md`) are
exempt. Profile example namespaces in `knowledge/_examples/` ship an eval set because they
double as reference implementations.

## Size and content of an eval set

Rule EVAL-3: an eval set has five to ten representative queries. Fewer than five does not
cover the namespace's query classes; more than ten is maintenance burden that decays.

Rule EVAL-4: each eval query records:

- the query as an agent would phrase it (a real task, not a keyword)
- the matching `INDEX.md` query class, when one applies
- the expected load set: the specific files the agent should load to answer, in load order,
  OR the expected answer when the query has a single correct factual answer
- a one-line pass criterion (the load set resolves and contains the load-bearing fact, or
  the answer matches)

Rule EVAL-5: the eval set covers the namespace's distinct query classes. If `INDEX.md`
declares four query classes, the eval set has at least one query per class. A namespace
that carries live-but-canonical facts includes at least one query that must hit
`canon/current-truth.md`.

## Eval location

Rule EVAL-6: the eval set lives at `knowledge/<namespace>/support/retrieval-eval.md`. It is
provenance-adjacent: it records what the namespace must be able to answer, which is part of
its support trail. Files under `knowledge/*/support/` are exempt from node-frontmatter
checks, so the eval file is clean operative markdown with an H1 title and `##` sections, not
a node.

Rule EVAL-7: a sprint-level eval set may live at `_build/eval/` in the sprint folder when
the eval spans multiple namespaces or is being authored before the namespace is upgraded.
The per-namespace home is the durable location; the sprint-level home is transitional.

## The no-eval-no-merge gate

Rule EVAL-8: a serious namespace upgrade does not merge until its eval set exists and its
queries resolve correctly against the upgraded structure. No eval, no merge. An eval set
whose queries do not resolve is a failing upgrade, not a documentation gap.

Rule EVAL-9: the gate is run by the agent or operator closing the upgrade: load each query's
expected files by the load order in [[retrieval-load-order-policy]], confirm they resolve
and carry the load-bearing fact, and confirm any single-answer query returns the expected
answer. Record pass or fail per query in the eval file.

Rule EVAL-10: the initial build defines this rule and seeds eval sets for `ai-architecture` and
the profile examples. Full per-namespace eval authoring for the other namespaces is queued
in the audit packets, not blocking the sprint.

## Example queries by profile

These are the worked examples the eval author imitates. Each is phrased as a real task and
paired with what a passing retrieval looks like.

- Doctrine (`ai-architecture`, `ooda-john-boyd`): "What does Boyd mean by orientation, and why
  does it sit at the center of the OODA loop." Expected load set: the namespace `INDEX.md`,
  `canon/core-doctrine.md`, and the orientation concept node. Pass criterion: the load set
  resolves and the concept node states orientation's role without the agent reading the
  full archive.
- Data System (a future ga4 or meta-ads namespace): "Trace ROAS to its source and
  calculation." Expected load set: the metric node for ROAS (by `metric_id`), its Data
  System lineage nodes (source contract, transform, model, refresh), through to the
  dashboard use. Pass criterion: the load set resolves and the lineage chain is unbroken
  from source to definition.
- Tool Contract (a future tool namespace): "Make the correct create-document call."
  Expected load set: `canon/core-contract.md` and the create-document operation node with
  its payload example. Pass criterion: the load set resolves and the payload example shows
  the exact parameter names and shape.

## What validate.sh enforces vs what a curator decides

Deterministic (validate.sh):

- the eval file's `[[wikilinks]]` and relative links to expected-load-set files resolve
- the eval file is under `support/` and is exempt from node-frontmatter checks while still
  subject to the em and en dash ban

Fuzzy (curator or operator at the merge gate, not validate.sh):

- whether the five to ten queries are actually representative of how agents query the
  namespace
- whether the expected load set is the minimal sufficient set or is padded
- whether a query's load set truly carries the load-bearing fact (validate.sh confirms the
  files resolve; only a reader confirms the fact is present)
- whether every query class is covered

validate.sh can confirm the expected files exist and links resolve. It cannot judge whether
the eval queries are representative or whether the loaded fragments actually answer the
query. The no-eval-no-merge judgment is the operator's and the curator's.

## Anti-patterns

- Shipping a serious namespace upgrade with no eval set. The gate forbids it.
- Writing eval queries as keywords instead of real tasks.
- Padding the expected load set with loosely relevant files; the eval should reward the
  minimal sufficient set.
- Authoring an eval that passes only because it expects the whole namespace to be loaded.
- Leaving the eval file as the only place a query class is documented; query classes live
  in `INDEX.md`, the eval tests them.

## Notes

The load order the eval tests against lives in [[retrieval-load-order-policy]]. The why
behind retrieval as the operating layer lives in [[retrieval-over-raw-memory]]. This file
owns the eval-set size, content, location, the no-eval-no-merge gate, and the profile
example queries. The eval set is the falsifiable proof that an upgrade improved retrieval,
not just structure.
