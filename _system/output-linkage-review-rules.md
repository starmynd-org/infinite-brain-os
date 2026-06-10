# Output Linkage Review Rules

This file states the operative rules for output linkage: the requirement that every
namespace declares what its canon drives, and the review that confirms the canon actually
drives those outputs. Output is first-class (contract Part 11, X research lesson 4): a
namespace that produces no outputs is a museum, not an operating layer. The "why" lives in
the `ai-architecture` doctrine ([[correction-loop-absorption]] for how outputs feed back as
corrections, and the output-is-first-class pillar); this file owns the executable
requirement and the review procedure.

## The requirement

Every serious namespace `INDEX.md` carries a `## What this namespace drives` section
(contract Part 6, section 7 of the required INDEX section order). This is the
output-linkage surface. It names the outputs, projects, or decisions this namespace canon
should improve.

The section is required. Its presence is DETERMINISTIC: `validate.sh` can confirm the
heading exists in a serious namespace `INDEX.md`. Whether the content is honest, that is,
whether the canon actually drives the listed outputs, is FUZZY and owned by the
output-linkage review (the `review-output-linkage` skill and the `canon-usage-review`
workflow).

## What the section must contain

The `## What this namespace drives` section lists, as bullets, the concrete consumers of
this namespace canon. Each bullet names one driven artifact and links to it where it lives
in the repo. Allowed driven-artifact types:

- an output (`outputs/`): a produced artifact whose lineage frontmatter links back to this
  namespace
- a project (`projects/<name>/PLAN.md`): a project whose plan cites this namespace as input
- a decision (an `ai-architecture` or other-namespace decision node) shaped by this canon
- an entity (a skill, agent, or workflow in `entities/` or `workflows/`) that reads this
  namespace as its knowledge source
- a downstream namespace that depends on this canon (a cross-namespace edge per
  `_system/cross-namespace-edge-rules.md`)

A bullet that names a driven artifact without a link is incomplete. Use `[[wikilink]]` or a
relative path so the link resolves and the base broken-link check (in
[[namespace-lint-rules]]) covers it.

If a namespace genuinely drives nothing yet (a newly canonized namespace), the section
states that explicitly: "Drives no outputs yet as of 2026-05-30; queued consumers: ...".
An empty or absent section on a serious namespace is a defect, not a valid "drives
nothing" state.

## The review: does canon actually drive outputs

Reviewing output linkage is FUZZY judgment. The reviewer (a curator agent running the
`review-output-linkage` skill, or the operator during a `canon-usage-review`) checks each
direction:

- Forward: for each artifact the `INDEX.md` claims this namespace drives, confirm the
  artifact exists, links back, and was actually shaped by this canon rather than listed
  aspirationally.
- Backward: scan `outputs/`, `projects/`, recent decisions, and consuming entities for any
  artifact that clearly draws on this namespace canon but is not listed in
  `## What this namespace drives`. An unlisted real consumer is a gap to add.
- Dead canon: flag canon nodes that drive no listed output and have no plausible consumer.
  Canon that drives nothing is a candidate for demotion to `synthesis/` or `archive/`, or a
  signal that an output should exist and does not. This is the inverse of an orphan: the
  node is linked internally but produces no external value.

The review does not gate a build wave. It runs on the `canon-usage-review` cadence
(periodic, per `_system/freshness-review-rules.md`) and surfaces findings to the operator.

## How to record output linkage

- In the namespace `INDEX.md`, the `## What this namespace drives` section is the canonical
  declaration. It is hand-curated by the agent doing namespace work and updated whenever a
  new consumer appears.
- In a driven output, project, or decision, record the reverse edge: a `derived_from`,
  `informed_by`, or `grounded_in` edge whose target is the namespace canon node it draws
  on. This makes the link traversable in both directions and lets the backward review find
  unlisted consumers deterministically by edge.
- When the output-linkage review finds a gap (a real consumer not listed, or listed canon
  driving nothing), record the finding in the `canon-usage-review` workflow output and, if
  it changes structure, route it through the correction loop per
  `_system/correction-loop-rules.md` so the fix becomes a rule or an INDEX edit, not a
  repeated note.

## Severity summary

- Missing `## What this namespace drives` section on a serious namespace: DETERMINISTIC,
  error (validate.sh).
- Section present but a listed artifact has no resolving link: DETERMINISTIC, error
  (base broken-link check).
- Listed artifact does not actually draw on the canon, or a real consumer is unlisted, or
  canon drives nothing: FUZZY, surfaced by review, not a wave gate.

## Notes

This file owns the executable output-linkage requirement and the review procedure. The
doctrine that output is first-class and that linkage feeds the correction loop lives in the
`ai-architecture` namespace; see [[correction-loop-absorption]]. The INDEX section schema
lives in `_system/namespace-index-schema.md`; this file specifies what the
`## What this namespace drives` section must contain and how it is reviewed.
