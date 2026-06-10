---
id: "knowledge-ai-architecture-canon-layer"
aliases: ["knowledge-ai-architecture-canon-layer", "ai-architecture-canon-layer"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "The canon layer is a compressed, operator-approved, provenance-bearing first-principles synthesis that an agent loads first for a namespace."
confidence: 0.9
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[canon-layer-schema]]"
    relation: "explains"
    confidence: 0.9
  - target: "[[what-canon-means]]"
    relation: "related_to"
    confidence: 0.92
  - target: "[[promote-support-to-canon]]"
    relation: "informs"
    confidence: 0.85
  - target: "[[core-doctrine]]"
    relation: "references"
    confidence: 0.88
created: "2026-05-30"
---

## Summary

The canon layer is the compressed reasoning entry point for a namespace. It holds the
operator-approved, provenance-bearing synthesis of the best current first-principles
understanding, and an agent loads it before it expands into the deeper graph. This node
is the "why" behind canon. The operative schema, the field-by-field contract a builder
follows, lives in [[canon-layer-schema]] under `_system`.

## What canon is

Canon is the thing a future agent should reason from first.

- A compressed synthesis, not a node-by-node paraphrase of `pillars/`. It pulls the
  graph together into a small set of load-bearing claims.
- Operator-approved. Material enters canon only after the operator signs off, which is
  what separates a settled claim from in-progress synthesis.
- Provenance-bearing. The canon node records `derived_from` edges to the pillars,
  concepts, decisions, and archive synthesis it compresses, so any claim is traceable.
- Small relative to the graph it sits over. A namespace with hundreds of nodes still has
  a canon measured in a few files, because canon is the distillation, not the corpus.

The depth model for canon is the synthesized Boyd HTML docs in
`zz_archived/Resources/PKM/john-boyd/docs`: dense first-principles writing, not a thin
one-line loader.

## What canon is not

- Not a copy of `pillars/`. Pillars are atomic foundational truths; canon is the
  synthesis that reasons across them.
- Not a parking lot for open questions. Unresolved material lives in `synthesis/` or
  `intake/`. The one exception is a brief transitional window during a namespace upgrade.
- Not runtime state, not raw archive, not a public export. Live queues stay in the app
  layer, raw sources stay in `archive/`, and the public surface is generated from canon
  rather than being canon.

## Required canon files

Serious namespaces carry three required canon files:

- `canon/README.md`: what canon means in this namespace, how it was approved, and how to
  update it. Navigational, not a knowledge node. See [[README]].
- `canon/core-doctrine.md`: the compressed first-principles synthesis. A full knowledge
  node with `derived_from`, `verified_at`, `verified_by`, and a `## Changelog`. This is
  the heart of canon. See [[core-doctrine]].
- `canon/agent-load-order.md`: what to load first for this namespace and why.
  Navigational, not a knowledge node. See [[agent-load-order]].

## Optional canon files

- `canon/current-truth.md`: only for stateful namespaces such as `example-marketing`
  that carry live-but-canonical facts like the current offer, current positioning, or
  current public claims. A full knowledge node, because it states truth.
- `canon/open-questions.md`: transitional only. The target state moves these into
  `synthesis/` or `intake/` once the upgrade settles. Canon does not keep a permanent
  question list.

Profile override: a Tool Contract namespace uses `canon/core-contract.md` as its canon
file of record, in place of or alongside `core-doctrine.md`.

## Provenance and changelog

Canon stays trustworthy because every revision is visible. The `core-doctrine.md` node
carries `derived_from` edges to its sources, `verified_at` and `verified_by`
frontmatter, and a `## Changelog` section that records each operator-approved revision
with a date and a one-line reason. The mechanical rules for this live in
[[canon-layer-schema]] and the changelog rules under `_system`; this node explains why
the discipline exists: canon that drifts without a recorded approval stops being canon.

## Canon by posture

Canon scales with namespace maturity, so a thin namespace gets a thin canon rather than
an empty ritual.

- Full canon (README, core-doctrine, agent-load-order): `ai-architecture`, `ooda-john-boyd`,
  `david-deutsch`, and `example-marketing` (which adds `current-truth.md`).
- Thin canon (README, a short core-doctrine, agent-load-order): `garytan`.
- No canon: `personal-operator`, which is a starter and template only and says so in its
  `INDEX.md`.

## Edges

- `explains` the operative schema [[canon-layer-schema]]: this node is the reasoning,
  that file is the contract.
- `related_to` [[what-canon-means]]: the operator's own definition of canon.
- `informs` [[promote-support-to-canon]]: the promotion path that fills canon.

## Notes

The single most common failure mode is treating canon as either a loader or a dumping
ground. It is neither. Canon is small, synthesized, approved, and traceable. When in
doubt about whether a claim belongs in canon, check it against [[what-canon-means]] and
the promotion path before writing.
