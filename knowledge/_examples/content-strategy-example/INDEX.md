# content-strategy-example

This is a reduced-base EXAMPLE scaffold for profile `content-strategy` (Profile F). It is
not a real namespace. It is a structural reference that operators and agents can copy
when starting a real content-strategy namespace. The content here is deliberately small
and illustrative, not authoritative.

A real content-strategy namespace would hold the actual pillars, content angles, and
evidence linking a specific product or brand to its markets. This scaffold shows the
shape, frontmatter patterns, folder roles, and cross-linking conventions.

## Profile

Content Strategy (Provisional). This profile holds themes, positions, angles, and how
they connect to marketing, product, doctrine, and evidence. It uses the shared base plus
`pillars/`, `concepts/`, `angles/`, `examples/`, and `references/`. It cross-links
heavily to `example-marketing`, `ai-architecture`, and thinker namespaces.

This example uses `lifecycle_state: research` on real nodes to reflect their status as
illustrative drafts, not approved canon.

## Load first

Canon entry points, in order:

1. [[core-doctrine]]: the compressed content-strategy canon. In a real namespace this is
   the synthesized first-principles reasoning about why the content program exists and
   what it is designed to do.
2. [[agent-load-order]]: which files to load for which query type.
3. [[canon/README]]: what canon means in this namespace and how to update it.

Top files after canon:

- [[content-strategy-pillar]]: the foundational pillar. What the content program stands
  for and what problems it solves for the audience.
- [[signal-to-angle]]: the characteristic angle-building concept. How a raw insight from
  doctrine or data becomes a publishable angle.
- [[ai-operator-angle]]: an example angle node showing the shape.

## Query classes

- **What pillars govern this content program** (what we stand for, what we will not do):
  load [[content-strategy-pillar]], [[core-doctrine]].
- **Which angles are active and what are they grounded in**: load [[ai-operator-angle]],
  then expand in `angles/` by scanning for `lifecycle_state: candidate`.
- **What examples exist for this angle or pillar**: load the matching node in `examples/`.
- **What references or evidence underpin a claim**: load `references/` nodes linked from
  the angle or concept.
- **How to pitch or brief a piece from this strategy**: load `playbooks/brief-a-piece.md`.

## Stable vs stateful

Stable (changes only on real strategic revision): the content pillars, the core doctrine,
the angle-construction concepts. These carry `review-on-edit` freshness.

Stateful (needs periodic review): active angles, example nodes, references. These tie to
current product positioning and evidence, so they decay when the product or market moves.
A real namespace would declare `freshness_posture: periodic` for `angles/` and `examples/`.

## Open disputes

In a real namespace, contested questions live in `synthesis/`. Examples of what would
live here:

- Whether a given angle overlaps too much with an adjacent pillar (angle dilution).
- Whether an example should be promoted to a canonical illustrative case.

In this scaffold: no real disputes. `synthesis/README.md` shows what goes here.

## What this namespace drives

A real content-strategy namespace drives:

- editorial calendars and content briefs
- campaign briefs handed to the marketing team
- social-post and newsletter angle selection
- link decisions: which doctrine or product concept a piece should reinforce

If content canon drives none of those, question whether the pillar or angle belongs.

## Archive and provenance

`support/` holds provenance for any content angles or pillars that were migrated from
legacy docs, plus retrieval eval queries for this namespace. No migration history exists
in this scaffold. A real namespace would add source-priority tables when migrating from a
prior content doc or brand guide.

## Common misreadings

- Treating `angles/` as an editorial calendar. Angles are templates or attack vectors for
  a theme; a calendar is operational state and belongs in the project layer or the
  the connector app app, not here.
- Putting audience research or competitive analysis in this namespace. Those are reference
  material or Data System nodes. Link from `references/`; do not duplicate.
- Confusing a content pillar with a brand pillar. Brand pillars live in
  `example-marketing`. Content pillars live here and declare their relation to brand
  pillars via `example-marketing` cross-links.

## Map

```text
knowledge/_examples/content-strategy-example/
  INDEX.md                             # this retrieval router (example)
  canon/
    README.md                          # what canon means here (navigational)
    core-doctrine.md                   # compressed content-strategy canon (knowledge node)
    agent-load-order.md                # load order by query class (navigational)
  pillars/
    content-strategy-pillar.md         # example foundational pillar
  concepts/
    signal-to-angle.md                 # example concept node (angle construction)
  angles/
    README.md                          # what goes in angles/
    ai-operator-angle.md               # example angle node
  examples/
    README.md                          # what goes in examples/
  references/
    README.md                          # what goes in references/
  playbooks/
    README.md                          # (reduced base: not populated in scaffold)
  synthesis/
    README.md                          # what goes in synthesis/
  support/
    README.md                          # provenance and migration only
```
