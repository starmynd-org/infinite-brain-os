# Profile Lint Rules

This file states the per-profile lint emphasis: the structural facts each profile requires
beyond the shared base, and whether each is checked deterministically by `validate.sh` or
as fuzzy judgment by a curator agent. The general check list and the
deterministic-versus-fuzzy split live in [[namespace-lint-rules]] and [[namespace-linting]];
this file owns only the profile-specific additions.

A profile changes which structural facts are required and therefore what the linter checks.
The base checks in [[namespace-lint-rules]] apply to every serious namespace; the rules
below stack on top, scoped to the profile declared in the namespace
`_system/namespaces/<ns>.md` registry entry. The eight profiles and their folder schemas
are defined in `_system/namespace-profiles.md`.

Most per-profile content checks are FUZZY today: deciding whether a payload example is
adequate, whether an endpoint is stale, or whether an SOP trigger is well-formed needs
judgment. The DETERMINISTIC parts are file-presence and folder-presence facts a script can
compute. Each rule is tagged.

## Profile B: Tool Contract

Required additive folders (DETERMINISTIC, via `expected_folders`): `operations/`,
`concepts/`, `decisions/`, `references/`, `examples/`. Canon file of record:
`canon/core-contract.md` (DETERMINISTIC presence check).

Lint emphasis:

- Tool-contract operation missing a payload example: an operation node that describes a
  call but carries no request or response payload example. FUZZY (a script can detect a
  missing `examples/` folder DETERMINISTICALLY, but cannot judge whether a present example
  actually covers the operation).
- Stale endpoint: an endpoint, base URL, or version that no longer matches the live API.
  FUZZY, and freshness-scoped per `_system/freshness-review-rules.md`.
- Parameter name inconsistency: the same parameter named differently across operation
  nodes. FUZZY.

## Profile C: Data System

Required additive folders (DETERMINISTIC, via `expected_folders`): `architecture/`,
`source-contracts/`, `pipelines/`, `transforms/`, `models/`, `metrics/`, `references/`.
Uses the shared metric primitive (`_system/metric-primitive-schema.md`).

Lint emphasis:

- Metric without lineage: a metric node (`type: "Metric"`, keyed by `metric_id`) with no
  edges to its Data System lineage nodes (source, transform, model, refresh). The
  metric-primitive frontmatter presence (`metric_id`, `format`, `polarity`, `aggregation`,
  `expression`) is DETERMINISTIC; whether the declared lineage edges point at real source
  and transform nodes is FUZZY at the semantic level but the presence of at least one
  `derived_from` or `depends_on` lineage edge is DETERMINISTIC.
- Starter data-system ambiguity hidden instead of declared: a starter-reduced Data System
  namespace that leaves metrics semantically defined but does not state whether each is
  `live`, `manual`, or `not-wired`, or whether the implementation path is Example Co-managed
  or client-managed. FUZZY today; the namespace must make the implementation posture legible
  even when full pipelines are deferred.
- Model without refresh logic: a model node that does not state how and when it refreshes.
  FUZZY.
- Pipeline not mapped to a transform: a pipeline node with no edge to a transform it
  feeds. FUZZY at the semantic level; presence of any outbound edge from a pipeline node is
  DETERMINISTIC (covered by the base orphan warning).

## Profile D: Design System

Required additive folders (DETERMINISTIC, via `expected_folders`): `pillars/`, `tokens/`,
`assets/`, `examples/`, `references/`.

Lint emphasis:

- Missing asset examples: a component or pattern documented with no usage example in
  `examples/` and no asset reference in `assets/`. Presence of the `examples/` and
  `assets/` folders is DETERMINISTIC; whether a specific component has an example is FUZZY.
- Component usage not mapped to a token: a component whose styling does not reference a
  declared token. FUZZY.

## Profile E: Component Library

Required additive folders (DETERMINISTIC, via `expected_folders`): `components/`,
`patterns/`, `examples/`, `deployment/`, `references/`.

Lint emphasis:

- Component without a usage playbook: a component node with no linked usage procedure.
  FUZZY; presence of `playbooks/` is DETERMINISTIC (base check).
- Missing deployment notes: a component with no entry in `deployment/`. Presence of
  `deployment/` is DETERMINISTIC; per-component coverage is FUZZY.

## Profile F: Content Strategy

Required additive folders (DETERMINISTIC, via `expected_folders`): `pillars/`, `concepts/`,
`angles/`, `examples/`, `references/`.

Lint emphasis:

- Angle with no supporting evidence or position: an angle node that does not link to a
  concept, pillar, or evidence node. FUZZY; outbound-edge presence is the base orphan
  warning (DETERMINISTIC).
- Cross-link health: Content Strategy cross-links heavily to `example-marketing`,
  `ai-architecture`, and thinker namespaces; a broken cross-namespace link is caught by the
  base broken-link check (DETERMINISTIC). Cross-namespace edge rules live in
  `_system/cross-namespace-edge-rules.md`.

## Profile G: Operating Library

Required additive folders (DETERMINISTIC, via `expected_folders`): `procedures/`,
`diagnostics/`, `decision-trees/`, `examples/`, `references/`. May add `metrics/` when tied
to metric diagnosis (uses the metric primitive).

Lint emphasis:

- SOP without a trigger: a procedure node that does not state the condition that fires it.
  FUZZY.
- Diagnostic without a next action: a diagnostic node that names a symptom but no next
  action or remediation step. FUZZY.
- Procedure without an escalation condition: a procedure that does not say when to escalate
  or hand off. FUZZY.
- Metric diagnosis link: when an Operating Library namespace carries `metrics/`, each metric
  diagnosis node references the same `metric_id` the Data System lineage uses; the metric is
  defined once and cross-linked (contract Part 9). Presence of the shared `metric_id` is
  DETERMINISTIC; whether the diagnosis is accurate is FUZZY.

## Profile H: Intake Fabric

Intake lives at repo root under `intake/`, not under `knowledge/<namespace>/`. Its
structural checks are the intake completeness rules in [[namespace-lint-rules]]. Lint
emphasis:

- Processed item without a routing decision: a processed receipt in `intake/processed/`
  with no linked routing decision. DETERMINISTIC (validate.sh intake completeness, error).
- Routed item without a destination link: a routing decision that names a chosen
  destination but carries no link to the destination file or namespace. DETERMINISTIC
  (validate.sh intake completeness, error).
- Receipt without source backlink: a processed receipt with no link back to its source
  record. FUZZY today; candidate to promote to DETERMINISTIC once the receipt schema
  (`intake/schemas/processed-receipt.md`) is locked. The why lives in
  [[intake-fabric-namespace]] and consumption rules in `_system/namespace-intake-rules.md`.

## Profile A: Doctrine

Doctrine (`ai-architecture`, `ooda-john-boyd`, `david-deutsch`, `garytan`,
`example-marketing`) carries the base plus `pillars/`, `concepts/`, `decisions/`, and
`archive/` when full-source preservation matters. It has no extra content-presence emphasis
beyond the base checks and the canon checks in [[namespace-lint-rules]], because doctrine
is stable reasoning rather than executable contract or decaying state. Freshness review is
light per `_system/freshness-review-rules.md` (review-on-edit, not periodic), except
`example-marketing`, which carries `canon/current-truth.md` and is freshness-scoped.

## Notes

This file lists per-profile emphasis only. The general checks, severities, and run
instructions live in [[namespace-lint-rules]]. The folder schemas these rules reference
live in `_system/namespace-profiles.md`. When a profile is promoted from Provisional to
Stable after its first real namespace validates the schema, revisit its emphasis here and
promote any FUZZY check that has become deterministic.
