# Canon Changelog Rules

Operative rules for the `## Changelog` section that every canon core-doctrine node carries.
This file owns the "what" and "how to check." The "why" (canon stays trustworthy only when
every revision is visible and approved) lives in the ai-architecture doctrine:
[[canon-layer]] and [[what-canon-means]]. This file does not restate that reasoning.

## Rule 1: every canon core-doctrine ends with a Changelog

Every `canon/core-doctrine.md` node, and every `canon/current-truth.md` node, MUST end with
a `## Changelog` section as the last section of the body. Profile override: a Tool Contract
namespace's `canon/core-contract.md` carries the same `## Changelog` requirement.

The changelog is the audit trail of operator-approved revisions to compressed canonical
truth. A canon node without a changelog is incomplete.

- Enforced by `validate.sh` (deterministic): a node at `lifecycle_state: canon` that is a
  canon core-doctrine, current-truth, or core-contract file must contain a `## Changelog`
  section.

## Rule 2: entry format is date plus one-line reason

Each changelog entry is a single bullet: the date, then a one-line reason. The reason names
what changed and why, concretely.

```markdown
## Changelog

- 2026-05-30: Initial canon synthesis approved. Compresses the four V2 pillars into the
  load-first doctrine for ai-architecture.
- 2026-06-04: Added the metric-primitive cross-link after the Data System namespace landed.
- 2026-06-18: Retired the standalone retrieval-adapter claim; superseded by the named-consumer
  doctrine in the load-order policy.
```

Format rules:

- date is `YYYY-MM-DD`, matching the `created` date convention.
- one line per entry. If a revision needs a paragraph to explain, the explanation belongs in
  `synthesis/` and the changelog line points to it.
- newest entries at the bottom, oldest at the top, append-only. Do not reorder or rewrite
  prior entries; a correction to canon is a new entry, not an edit of an old one.
- no em dashes, no en dashes. Use commas or colons.
- no placeholder text. If a reason is genuinely not yet known, the revision is not ready to
  approve.

## Rule 3: when a changelog entry is required

A new changelog entry is required whenever the canon node's substantive content changes
under operator approval. Specifically:

- the initial creation of the canon node (the first entry).
- adding a new compressed claim to canon.
- revising an existing canon claim (changing what it asserts).
- retiring or superseding a canon claim, per [[deprecation-and-supersession-rules]].
- changing `derived_from` provenance in a way that alters which sources back a claim.

A new entry is NOT required for:

- a typo fix, a formatting change, or a link target rename that does not change meaning.
- updating `verified_at` on a re-verification that confirmed no content change (record this
  in `verified_at` frontmatter, not the changelog).

When in doubt, the test is: did the compressed truth change. If yes, add an entry.

## Rule 4: changelog pairs with the operator approval gate

The changelog is the visible half of the operator approval gate from [[promotion-path-rules]].
Every changelog entry corresponds to an operator-approved revision. The node's
`verified_by` and `verified_at` frontmatter records who approved and when; the changelog
records what changed and why in one line. The two MUST be consistent: the latest
`verified_at` date should match or follow the newest substantive changelog entry.

- The approval itself is a human gate (operator), not deterministic and not agent.
- `verified_by` and `verified_at` presence on a `canon_posture: full` node is enforced by
  `validate.sh` (deterministic).
- Whether the one-line reason accurately describes the change is a curator check (fuzzy).

## Rule 5: the changelog is per canon node, not per namespace

Each canon node carries its own changelog. A namespace with `core-doctrine.md` and
`current-truth.md` has two changelogs, one per file. Do not centralize canon history into a
single namespace-level log; the changelog lives with the claim it tracks so an agent reading
one canon node sees that node's full revision history inline.

## Checklist before committing a canon revision

- a `## Changelog` section exists and is the last section of the body.
- a new entry is added if and only if substantive content changed (Rule 3).
- the entry is `YYYY-MM-DD: one-line reason`, no em or en dashes, no placeholder.
- entries are append-only; prior entries unchanged.
- `verified_by` and `verified_at` are set and consistent with the newest entry.
- operator approval is recorded (the gate in [[promotion-path-rules]]).

## Related operative rules

- [[promotion-path-rules]]: the operator approval gate the changelog makes visible.
- [[deprecation-and-supersession-rules]]: a retired canon claim still needs a changelog entry.
- [[canon-layer-schema]]: the full canon core-doctrine frontmatter and section contract.
