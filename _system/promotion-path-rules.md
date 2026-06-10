# Promotion Path Rules

Operative rules for moving material up the lifecycle: from raw source, through support and
synthesis, to canon. This file owns the "what each transition requires" and "how to check
it." The "why" lives in the ai-architecture doctrine: [[canon-layer]], [[what-canon-means]],
and [[correction-loop-absorption]]. This file does not restate that reasoning.

## The promotion path

```text
raw source  ->  support  ->  synthesis  ->  canon-candidate  ->  canon
```

Material moves left to right. Each arrow is a transition with explicit entry requirements.
A node may sit at any stage. Most material never reaches canon, and that is correct: canon
is small relative to the graph it sits over.

Map of stages to homes:

| Stage | Home | What lives here |
|-------|------|-----------------|
| raw source | `knowledge/<ns>/archive/`, `intake/` | unprocessed captures, full-source preservation |
| support | `knowledge/<ns>/support/` | provenance, migration receipts, source-priority tables |
| synthesis | `knowledge/<ns>/synthesis/`, root `synthesis/` | derived reading, contradiction maps, canon-candidate packages |
| canon-candidate | `knowledge/<ns>/synthesis/` (marked candidate) | a synthesis proposed for promotion into canon |
| canon | `knowledge/<ns>/canon/` | operator-approved compressed first-principles synthesis |

The `support` versus `synthesis` boundary is sharp: `support/` is mechanical and historical
(provenance, migration), `synthesis/` is interpretive and current (derived thinking). Do
not put synthesis in `support/`; do not put migration receipts in `synthesis/`.

Session artifacts in `sessions/` may feed this path, but they are not themselves a stage in
the knowledge-promotion ladder. Treat them as upstream source and audit material:
transcripts, closeout reviews, and session summaries can justify a memory node, a support
note, a synthesis node, or a task, but they do not bypass the stage transitions below.

## Transition 1: raw source to support

A raw capture becomes support material when its provenance is recorded.

Requires:

- the source is preserved (in `archive/` or referenced from `intake/`) so the original is
  recoverable.
- a support entry records where the material came from, when it was captured, and its
  source-priority rank relative to competing sources.

This transition does not assert any new claim. It only makes the source traceable.

## Transition 2: support to synthesis

Support material becomes synthesis when someone derives a reading from it.

Requires:

- a `synthesis/` node that states a derived position, not a restatement of the source.
- `derived_from` edges to the support and source nodes it draws on.
- `lifecycle_state: research` or higher (a synthesis node is not `scratch` once it asserts).

Synthesis artifact types: contradiction map, best-current-reading, what-changed review,
canon-candidate. See [[namespace-architecture-v2]] for the type definitions.

## Transition 3: synthesis to canon-candidate

A synthesis node becomes a canon-candidate when it is nominated for canon.

Requires:

- `lifecycle_state: candidate` on the node.
- a canon-candidate package: the proposed compressed claim, the `derived_from` provenance,
  and an explicit statement of what existing canon it changes or extends (or that it is net
  new).
- a check against [[what-canon-means]]: a candidate must be compressed first-principles
  synthesis, not a parking lot for open questions and not a paraphrase of `pillars/`.

Canon-candidate detection (spotting a synthesis node that is ready to nominate) is a
curator check (fuzzy). Promotion is never automatic.

## Transition 4: canon-candidate to canon (operator approval gate)

This is the only transition with a hard operator approval gate. No agent promotes to canon
on its own authority.

Requires ALL of:

- explicit operator approval recorded on the canon node via `verified_by` and `verified_at`
  frontmatter.
- `derived_from` edges to the pillars, concepts, decisions, and archive synthesis the canon
  claim compresses (provenance-bearing canon).
- a `## Changelog` entry on `canon/core-doctrine.md` recording the date and a one-line
  reason for the addition or revision, per [[canon-changelog-rules]].
- `lifecycle_state: canon` on the promoted node.
- the canon node is compressed and small relative to the graph: it synthesizes, it does not
  copy nodes.

Until the operator approves, the material stays in `synthesis/` as a candidate. Open
questions never live permanently in canon; they stay in `synthesis/` or `intake/`.

- Operator approval gate: human, not deterministic, not agent.
- `derived_from`, `verified_by`, `verified_at`, and `## Changelog` presence on a
  `canon_posture: full` namespace: enforced by `validate.sh` (deterministic).
- Whether the synthesis is genuinely canon-worthy: curator check plus operator decision
  (fuzzy then human).

## Promotion is per-claim, not per-file

A file can hold both settled and unsettled material during a transition. Promote the
specific claim, not the whole file by default. A synthesis node may have one claim promoted
into canon while the rest stays in synthesis. Track the promoted claim through its
`derived_from` edges so the canon node points back at its synthesis origin.

## Checklist before promoting to canon

- operator has approved, recorded in `verified_by` and `verified_at`.
- `derived_from` edges trace every canon claim to its sources.
- a `## Changelog` entry exists with date and one-line reason.
- the claim is compressed synthesis, checked against [[what-canon-means]].
- no open questions are being parked in canon.
- `lifecycle_state` set to `canon` on the node.
- the originating synthesis node retains its edges so the trail is intact.

## Related operative rules

- [[canon-changelog-rules]]: the changelog entry format and when an entry is required.
- [[deprecation-and-supersession-rules]]: retiring or superseding a canon claim.
- [[stable-id-and-alias-rules]]: ids survive the move up the path; never rename on promote.

## Related skills and playbooks

- [[promote-support-to-canon]]: the skill that walks a node up this path (may not exist yet
  as of 2026-05-30; this rule file is its operative contract).
- [[canonize-a-namespace]]: the playbook that builds a namespace canon layer from its
  synthesis and support material.
