# Public LLM Index Policy

This file is the operative policy for public LLM index surfaces (`llms.txt` and similar).
It states which profiles may expose a public index, what the generator reads, what stays
internal, and the generation and regeneration rules. The "why" lives in the
`ai-architecture` doctrine: [[public-llm-index-export-posture]] sets the posture and
[[internal-index-vs-public-llm-index]] explains the two-artifact boundary. This file owns
the executable policy and does not restate the doctrine.

## Core posture

`llms.txt` is an export and discovery surface, not internal architecture (contract Part
10). It is a thin public summary generated from `canon/`, regenerated when canon changes,
never hand-authored as a separate truth. The internal `INDEX.md` is the rich retrieval
router for trusted agents; the public `llms.txt` is a downstream output. They are different
artifacts and never collapse into one.

## Which profiles expose a public index

Exposure is opt-in, decided per namespace, and recorded in the
`_system/namespaces/<ns>.md` registry. It is never a default.

Most relevant (may expose, subject to operator decision):

- Tool Contract: external integrators may legitimately discover the contract.
- Data System: external readers may discover available data and metric definitions.
- Design System: partners may discover visual canon.
- Component Library: integrators may discover approved components and deployment rules.
- Content Strategy: external readers may discover positions and angles.

Least relevant (no public index by default):

- Private thinker canon (`ooda-john-boyd`, `david-deutsch`): internal reasoning corpora with no
  external-discovery job.
- The operator starter namespace (`personal-operator`).
- Doctrine namespaces that hold internal architecture (`ai-architecture`), unless the
  operator decides a subset should be publicly discoverable.

A namespace that is not meant for external discovery exposes no `llms.txt`. A namespace
without an approved export posture in its registry gets no public index; that is the
expected state for most private namespaces.

## What the generator reads

The generator reads `canon/` and nothing else as content source:

- It reads `canon/core-doctrine.md` (or `canon/core-contract.md` for Tool Contract) as the
  primary source.
- For stateful namespaces it also reads `canon/current-truth.md` (for example
  `example-marketing` current offer and positioning).
- It NEVER reads raw `pillars/`, `concepts/`, `decisions/`, `support/`, `synthesis/`,
  `archive/`, or `intake/` directly into the public file. If a fact is not in canon, it
  does not reach the public index. This is the canon-only rule, and it is the single most
  important line in this policy.

The generator reads canon, never raw notes. Routing the public surface through canon means
the public claim and the internal trusted claim share one source and cannot silently
diverge.

## What stays internal

Everything not promoted into operator-approved canon stays internal and never reaches the
public surface:

- `support/` provenance and migration receipts
- `synthesis/` derived thinking and open questions
- `intake/` records and receipts
- any node whose `export_class` is `internal` or `department`, even if it sits in canon

## The export_class gate

The generator respects `export_class` as a hard gate. A node or claim is publishable only
if its `export_class` is `public`. A node marked `internal`, `department`, or `company`
never appears in a `public` export, even when it lives in canon. This makes
`export_class` the single place that decides what is publishable, so internal-only leakage
is a generation-rule guarantee rather than a manual-review problem.

A canon node intended for public export must therefore carry `export_class: public`. Canon
nodes default to the namespace `export_class`; promoting a claim to public exposure is an
explicit frontmatter decision, reviewed by the operator.

## Generation and regeneration rules

- The public file is generated, not edited. Never hand-edit `llms.txt`.
- Regenerate `llms.txt` whenever canon changes. Drift between canon and `llms.txt` is a
  signal to regenerate, not to patch the public file by hand.
- The generator emits a thin summary with links, not a full router. It does not reproduce
  the `INDEX.md` query classes, open disputes, or output linkage; those are internal.
- The generator records its source: the public file states it was generated from canon on a
  given date, so a reader can tell it is derived and a reviewer can detect staleness against
  the canon `verified_at`.

## Severity and enforcement

- A hand-edited `llms.txt` that diverges from canon: FUZZY, surfaced by the
  `canon-usage-review` workflow and the curator, not a validate.sh gate, because the
  validator cannot tell a regeneration from a hand edit.
- A namespace exposing a public index without an approved export posture in its registry:
  FUZZY today, surfaced by review.
- A `public` claim sourced from a node with `export_class` not `public`: caught by the
  generator at generation time (the gate refuses it); the curator audits generator output.

The initial build defines the posture and this policy. Per-namespace public-index generation is
queued, not run.

## Notes

This file owns the executable policy: canon-only source, opt-in by profile,
`export_class` gate, regenerate-never-edit. The posture decision lives in
[[public-llm-index-export-posture]] and the two-artifact boundary in
[[internal-index-vs-public-llm-index]]. The internal `INDEX.md` schema lives in
`_system/namespace-index-schema.md`; the public surface defined here is its downstream
export, not a competing router.
