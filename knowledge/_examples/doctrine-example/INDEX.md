# doctrine-example

This is a reduced-base EXAMPLE scaffold for the Doctrine profile (Profile A). It is not
a real namespace. Copy it as a starting point when creating a new namespace whose job is
to hold durable concepts, principles, and decisions. Replace the example content with
real content for your subject.

The subject used here is "first-principles discipline": a generic, neutral topic that
makes all placeholder roles obvious. Nothing here is canonical doctrine about any real
domain.

## Profile

Doctrine (Profile A). This profile is for namespaces whose job is to hold durable
concepts, principles, and decisions that agents should reason from. Additive folders
on top of the shared base: `pillars/`, `concepts/`, `decisions/`. Optional: `archive/`
when full-source preservation matters (omitted here). See [[namespace-profiles]] for the
full profile registry.

## Load first

1. [[core-doctrine]]: compressed first-principles synthesis for this namespace. Read
   whole before any other node.
2. [[agent-load-order]]: tells you what to load next by query class.
3. [[canon/README]]: what canon means here and how it is updated.

Top files after canon:

- [[example-discipline-pillar]]: the foundational pillar. The one claim that the rest
  of the namespace derives from.

## Query classes

- **Core principles** (what are the foundational claims): load [[core-doctrine]],
  [[example-discipline-pillar]].
- **Definitions and models** (what a term or framework means): load `concepts/`.
- **Past decisions** (why a direction was chosen): load `decisions/`.
- **How to apply** (procedures and patterns): load `playbooks/`.
- **Open disputes** (what is unsettled): load `synthesis/`.

## Stable vs stateful

Stable doctrine (changes only when a real revision is approved): pillars, core
foundational concepts, settled decisions. Carry `review-on-edit` freshness.

Stateful (needs periodic review): open questions and contradiction notes tracked in
`synthesis/`. This example namespace carries no live facts, so no `canon/current-truth.md`.

## Open disputes

No real disputes exist in an example scaffold. In a real namespace, track contested or
unresolved questions in `synthesis/`, never in `canon/`.

## What this namespace drives

In a real namespace, list the outputs, agents, decisions, or projects this canon should
improve. If a piece of doctrine drives nothing, question whether it belongs.

## Archive and provenance

This example carries no `archive/`. In a namespace where full-source preservation
matters, add `archive/` alongside `support/`. Keep migration receipts in `support/`;
keep derived reading in `synthesis/`.

## Common misreadings

- Treating `canon/` as a copy of `pillars/`. Canon compresses and synthesizes across the
  graph; it does not paraphrase nodes.
- Putting open questions in `canon/`. Open questions belong in `synthesis/`.
- Using this example as real doctrine. It is a structural template, not a knowledge
  source.

## Map

```text
knowledge/_examples/doctrine-example/
  INDEX.md                        # this retrieval router (you are here)
  canon/
    README.md                     # navigational: what canon means here
    core-doctrine.md              # knowledge node: compressed synthesis
    agent-load-order.md           # navigational: load order by query class
  pillars/
    example-discipline-pillar.md  # knowledge node: example pillar
  concepts/
    README.md                     # navigational: what goes in concepts/
  decisions/
    README.md                     # navigational: what goes in decisions/
  playbooks/
    README.md                     # navigational: what goes in playbooks/
  synthesis/
    README.md                     # navigational: what goes in synthesis/
  support/
    README.md                     # navigational: what goes in support/
```

The operative registry entry for a real namespace of this profile lives at
`_system/namespaces/<slug>.md`.
