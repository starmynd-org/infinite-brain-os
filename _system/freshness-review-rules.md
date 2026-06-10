# Freshness Review Rules

Operative rules for profile-scoped freshness review: which posture applies to which
namespace, how `verified_at` and `verified_by` are used, and the review cadence per
posture. This file is the executable rule layer. The procedure that runs it lives in
[[review-namespace-health]].

Scope: guardrail G10 (profile-scoped freshness) and contract Part 7.2 (the
`freshness_posture` registry field). Freshness and contradiction review apply where state
decays, not uniformly to stable doctrine.

## Why posture is scoped, not blanket

Rule FRESH-1: freshness review is scoped by the namespace `freshness_posture`, not applied
uniformly. Stable doctrine does not decay on a clock; live facts do. Reviewing stable
canon on a periodic timer wastes attention and trains a false sense that doctrine has a
shelf life. Reviewing live state only on edit lets stale facts sit in canon.

The posture is declared in `_system/namespaces/<ns>.md` under `freshness_posture` and
surfaced in the namespace `INDEX.md` `Stable vs stateful` section.

## The three postures

Rule FRESH-2: `freshness_posture` is one of exactly three values.

- `review-on-edit`: freshness is checked whenever canon or a load-bearing node in the
  namespace changes. There is no clock. This is the default for stable doctrine. The fact
  that nothing changed means nothing decayed.
- `periodic`: freshness is checked on a scheduled namespace review (for example monthly)
  in addition to on edit. Use for namespaces whose facts drift slowly but do drift, where
  no edit event reliably signals the drift.
- `live`: freshness is checked most often because the namespace carries facts that decay
  fast (current offer, current positioning, current public claims, current pipeline
  state). Live state is reviewed on every relevant edit and on the most frequent cadence.

Rule FRESH-3: stable doctrine is `review-on-edit`, not `periodic`. Do not put a periodic
freshness timer on a namespace whose content is durable first-principles doctrine. A Boyd
or Deutsch concept does not expire on a schedule; it changes only when the operator's
understanding changes, which is an edit event.

## Posture by namespace (current set)

Rule FRESH-4: the current namespaces carry these postures. The registry entry is the
source of record; this table is the locked baseline for the sprint.

| Namespace | Profile | Freshness posture | Why |
|-----------|---------|-------------------|-----|
| `ai-architecture` | doctrine | `review-on-edit` | Stable architecture doctrine; changes only when understanding changes. |
| `ooda-john-boyd` | doctrine | `review-on-edit` | Durable thinker doctrine over a preserved archive. |
| `david-deutsch` | doctrine | `review-on-edit` | Durable thinker doctrine over a preserved archive. |
| `garytan` | doctrine | `review-on-edit` | Durable thinker doctrine; thin canon. |
| `example-marketing` | content-strategy | `live` | Carries live-but-canonical facts (current offer, current positioning, current public claims) in `canon/current-truth.md`. |
| `personal-operator` | starter | `review-on-edit` | Starter and template only; no canon. |

Rule FRESH-5: a Data System namespace (when built) is `live` or `periodic` on its metric
and model facts, because source schemas, refresh logic, and metric values decay. A Tool
Contract namespace is `periodic` or `live` on endpoints and payloads, because APIs change.
Doctrine namespaces stay `review-on-edit`.

## verified_at and verified_by usage

Rule FRESH-6: `canon/core-doctrine.md` and `canon/current-truth.md` carry `verified_at`
(date the canon was last confirmed to reflect current truth) and `verified_by` (who
confirmed it: the operator or a named curator agent). These are frontmatter fields, not
prose.

Rule FRESH-7: `verified_at` is updated only when a human or curator actually re-confirmed
the content against current truth. It is not bumped automatically on any edit. A
formatting edit does not change `verified_at`; a confirmation that the doctrine still
holds does.

Rule FRESH-8: freshness is judged by comparing `verified_at` against the latest material
edits in the namespace. If load-bearing nodes changed after `verified_at`, canon may have
drifted and is queued for a confirmation pass. A `live`-posture `current-truth.md` whose
`verified_at` is older than the cadence window is stale and must be re-verified before it
is trusted.

Rule FRESH-9: detail nodes (concepts, decisions, playbooks) do not require `verified_at`.
The freshness contract attaches to canon and to live-but-canonical facts, which are the
surfaces an agent trusts without expanding into the graph.

## Cadence by posture

Rule FRESH-10: the deterministic pass (`bash _system/validate.sh`) runs on every edit and
before any wave closes, regardless of posture. Only the fuzzy freshness pass is cadenced.

- `review-on-edit`: fuzzy freshness pass when canon or a load-bearing node changes. No
  clock.
- `periodic`: fuzzy freshness pass on the scheduled namespace review, plus on edit.
- `live`: fuzzy freshness pass most often, on every relevant edit and on the most frequent
  scheduled cadence, because live state decays fastest.

## What validate.sh enforces vs what a curator decides

Deterministic (validate.sh):

- `canon/core-doctrine.md` and `canon/current-truth.md` carry `verified_at` and
  `verified_by` (presence check; part of canon checks)
- `freshness_posture` in the registry entry is one of `review-on-edit`, `periodic`, `live`

Fuzzy (curator or freshness-reviewer agent, not validate.sh):

- whether canon still reflects current truth (the actual freshness judgment)
- whether `verified_at` is stale relative to material edits
- whether a `live` fact (offer, positioning, public claim) has changed in the world
- whether a posture should change because a namespace's content started decaying

validate.sh cannot judge whether a statement is still true. It can only check that the
freshness metadata is present and well-formed. The judgment stays with a human or curator
agent.

## Notes

The procedure that executes this, including the step that compares `verified_at` against
recent edits and queues a refresh, lives in [[review-namespace-health]]. This file owns
the posture enum, the per-namespace posture assignment, and the cadence rule. When a
namespace's content begins to decay, change its `freshness_posture` in the registry rather
than overriding the cadence per review.
