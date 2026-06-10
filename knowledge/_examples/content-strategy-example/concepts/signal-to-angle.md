---
id: "knowledge-content-strategy-example-signal-to-angle"
aliases: ["knowledge-content-strategy-example-signal-to-angle", "signal-to-angle"]
type: "Knowledge"
namespace: "content-strategy-example"
lifecycle_state: "research"
summary: "How to construct a content angle from a raw signal: start from a concrete observation, identify which pillar it illuminates, then form a claim connecting signal to pillar consequence."
confidence: 0.82
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[content-strategy-pillar]]"
    relation: "supports"
    confidence: 0.85
  - target: "[[core-doctrine]]"
    relation: "implements"
    confidence: 0.8
created: "2026-05-30"
---

## What an angle is

An angle is a specific, opinionated claim that connects a concrete signal to a content
pillar. It is not a topic. "AI and operators" is a topic. "Most operators who say they
use AI still spend four hours a day on decisions an AI agent could make because they have
not defined the boundary" is an angle. The angle names the problem, implies the audience,
and stakes a position.

## The construction sequence

1. **Identify the signal.** A signal is a concrete observation: a data point, a
   behavioral pattern seen in customer calls, a specific failure mode, a published
   research result, a real decision made by a named operator. Signals are factual. They
   live in `references/` as reference nodes.

2. **Match the signal to a pillar.** Ask which content pillar this signal illuminates or
   challenges. If the signal does not connect to any pillar, it is not a content signal
   for this namespace. It may belong in a different namespace or in intake as raw
   material.

3. **Form the claim.** State the consequence of the signal relative to the pillar. The
   claim should be specific enough that a reader could disagree with it. A claim no one
   would disagree with is a platitude, not an angle.

4. **Name the audience assumption the angle challenges.** Every strong angle challenges
   one assumption the target audience holds. If you cannot name the assumption, the angle
   is not sharp enough.

## How to record an angle

Write the angle as a node in `angles/`. The node carries:

- the claim as a `summary` in frontmatter
- a `## Signal` section citing the reference node
- a `## Pillar connection` section naming the pillar and the consequence
- a `## Challenged assumption` section
- edges to the reference node and the pillar node

## What makes an angle weak

- The signal is generic, not concrete.
- The pillar connection is asserted but not shown.
- The challenged assumption is obvious or widely agreed with.
- The claim is a rephrasing of the pillar with no added specificity.
