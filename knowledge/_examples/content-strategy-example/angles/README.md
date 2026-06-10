# angles/

This folder holds the active content angles for this namespace. Each angle is a specific,
opinionated claim connecting a concrete signal to a content pillar.

## What belongs here

A node in `angles/` represents one angle: a claim, its signal source, its pillar
connection, and the audience assumption it challenges. Angles at `lifecycle_state:
candidate` are approved for content production. Angles at `lifecycle_state: research`
are under development. Angles at `lifecycle_state: archive` have been retired.

## What does not belong here

- Editorial calendar entries or scheduled post dates. Those are operational state.
- Raw signals or research. Raw signals belong in `references/` or in `intake/`.
- Brand pillars or positioning statements. Those belong in `example-marketing`.

## Cross-linking convention

Every angle node carries edges to:

- the pillar node it serves (relation: `implements`)
- the reference node(s) that supply its signal (relation: `grounded_in`)
- any `examples/` node that shows the angle in practice (relation: `produces`)

## Maintenance

Review `angles/` nodes in `lifecycle_state: research` on each monthly content review.
Promote to `candidate` when the claim is sharp and the signal is grounded. Archive when
the signal is stale or the pillar connection no longer holds.
