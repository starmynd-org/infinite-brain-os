# Canon Layer Schema (Operative)

This file is the operative canon contract: the field-by-field "what" a builder writes
into `canon/` and the structural rules the linter checks. The "why" canon exists, what it
is and is not, lives in [[canon-layer]] under `knowledge/ai-architecture/concepts/`. The
changelog mechanics live in [[canon-changelog-rules]]. This file carries no node
frontmatter (it lives under `_system/`).

Canon is the compressed, operator-approved, provenance-bearing first-principles synthesis
an agent loads first for a namespace. It is small relative to the graph it sits over. The
depth model is the synthesized Boyd HTML docs, dense first-principles writing, not a thin
one-line loader.

## Canon posture enum

Every namespace declares a `canon_posture` in its `_system/namespaces/<ns>.md` registry
entry. The posture sets which canon files are required.

```text
full | thin | none
```

- `full`: README, core-doctrine, agent-load-order all required. For mature, retrieval-heavy
  namespaces.
- `thin`: README, a short core-doctrine, and agent-load-order required, but core-doctrine
  may be brief. For namespaces with a small but real reasoning layer.
- `none`: no `canon/` folder. Only for starter and example namespaces, which must declare
  the omission in their `INDEX.md`.

Current assignments (from contract Part 3.5): `full` for `ai-architecture`, `ooda-john-boyd`,
`david-deutsch`, `example-marketing` (plus `current-truth.md`); `thin` for `garytan`;
`none` for `personal-operator`.

## Required files by posture

### canon_posture: full

Three files required:

- `canon/README.md`: what canon means in this namespace, how it was approved, and how to
  update it. Navigational, NOT a knowledge node, no node frontmatter. Validator-exempt.
- `canon/core-doctrine.md`: the compressed first-principles synthesis. A full knowledge
  node WITH the canon frontmatter below. This is the heart of canon.
- `canon/agent-load-order.md`: what to load first for this namespace and why. Navigational,
  NOT a knowledge node, no node frontmatter. Validator-exempt.

Optional with posture full:

- `canon/current-truth.md`: only for stateful namespaces (for example
  `example-marketing`) that carry live-but-canonical facts such as current offer, current
  positioning, current public claims. A full knowledge node WITH node frontmatter, because
  it states truth.
- `canon/open-questions.md`: transitional only. See the transitional rule below.

### canon_posture: thin

Same three required files as `full`: README, core-doctrine, agent-load-order. The
difference is that `core-doctrine.md` may be short. A thin namespace gets a thin canon,
not an empty ritual and not a skipped canon.

### canon_posture: none

No `canon/` folder. The namespace must declare in its `INDEX.md` (section 2, Profile) that
it carries no canon and why. Only valid for starter and example namespaces.

### Profile override: tool-contract

A `tool-contract` namespace uses `canon/core-contract.md` as its canon file of record, in
place of or alongside `core-doctrine.md`. The frontmatter requirements below apply to
`core-contract.md` exactly as they apply to `core-doctrine.md`.

## Required frontmatter on the canon core node

`canon/core-doctrine.md` (or `canon/core-contract.md`, or `canon/current-truth.md`)
carries the standard knowledge-node frontmatter PLUS these canon-specific fields:

```yaml
---
id: "knowledge-<namespace>-canon-core-doctrine"
aliases: ["knowledge-<namespace>-canon-core-doctrine", "<namespace>-core-doctrine"]
type: "Knowledge"
namespace: "<namespace>"
lifecycle_state: "canon"
summary: "one-line description"
confidence: 0.9
retrieval_class: "identity"
export_class: "internal"
verified_at: "2026-05-30"
verified_by: "the-operator"
edges:
  - target: "[[<source-pillar-or-concept>]]"
    relation: "derived_from"
    confidence: 0.9
created: "2026-05-30"
---
```

Required canon-specific fields and rules:

- `verified_at`: the date the operator last approved this canon revision. Date only,
  `YYYY-MM-DD`.
- `verified_by`: who approved it. Canon is operator-approved; this names the approver.
- `derived_from` edges: one or more edges with `relation: derived_from` pointing at the
  pillars, concepts, decisions, and archive synthesis this canon compresses. Every
  load-bearing claim in canon must trace to a source node through these edges. Canon with
  no `derived_from` edges is not canon; it is an unsourced assertion.
- `lifecycle_state: canon`: the core node is in the canon lifecycle state.
- `## Changelog` section at the bottom of the body: records each operator-approved
  revision with a date and a one-line reason. Mechanics in [[canon-changelog-rules]].

## The open-questions transitional rule

Unresolved questions do not live permanently in canon. `canon/open-questions.md` is
transitional only: it is allowed during a namespace upgrade or canon revision window, and
the target state moves those questions into `synthesis/` (for derived reasoning) or
`intake/` (for unprocessed inbound). A canon that keeps a permanent open-questions list
has drifted from the contract. A curator agent surfaces a stale `open-questions.md` during
review; it is not a deterministic validator check because "stale" is a judgment.

## Canon minimalism

Canon is small relative to the graph it sits over. Specific rules:

- Canon synthesizes and compresses. It does not paraphrase `pillars/` node by node. A
  canon node that restates pillars one for one has failed the compression test.
- Canon is the distillation, not the corpus. A namespace with hundreds of nodes still has
  canon measured in a few files.
- Canon is not a copy of `pillars/`, not a parking lot for open questions, not runtime
  state, not raw archive, and not a public export. The public surface (`llms.txt`) is
  generated FROM canon, it is not canon.
- Canon enters only through the promotion path: raw source to support to synthesis to
  canon-candidate to operator-approved canon. See [[promotion-path-rules]].

## What the validator checks vs what a curator checks

- `validate.sh` (deterministic): for a namespace with `canon_posture: full`, the three
  required canon files exist; `canon/README.md` and `canon/agent-load-order.md` are
  exempt from node-frontmatter checks while `canon/core-doctrine.md` and
  `canon/current-truth.md` require node frontmatter; `derived_from` and other
  `[[wikilink]]` edge targets resolve to real files; the em-and-en-dash ban holds.
- A curator agent (fuzzy): confirms canon actually compresses rather than copies pillars,
  that `verified_at` is not badly stale, that `open-questions.md` is genuinely
  transitional and not a permanent dump, and that no in-progress synthesis has leaked into
  canon. Run via [[canonize-a-namespace]] and the monthly canon review.
