---
id: "knowledge-content-strategy-example-canon-core-doctrine"
aliases: ["knowledge-content-strategy-example-canon-core-doctrine", "content-strategy-example-core-doctrine"]
type: "Knowledge"
namespace: "content-strategy-example"
lifecycle_state: "research"
summary: "Example canon for a content-strategy namespace: content serves doctrine, not trends; angles are grounded in pillars and evidence; the program exists to move a specific audience toward a specific decision."
confidence: 0.8
retrieval_class: "identity"
export_class: "internal"
verified_at: "2026-05-30"
verified_by: "scaffold-only-not-operator-approved"
edges:
  - target: "[[content-strategy-pillar]]"
    relation: "derived_from"
    confidence: 0.85
  - target: "[[signal-to-angle]]"
    relation: "derived_from"
    confidence: 0.8
  - target: "[[namespace-profiles]]"
    relation: "informed_by"
    confidence: 0.9
created: "2026-05-30"
---

## Read this first

This node shows what a content-strategy canon looks like. It is a real node with real
frontmatter and a real synthesis, but the content is illustrative rather than
authoritative. In a real namespace, this would be operator-approved and would compress
the specific content program for a named product or brand.

A content-strategy namespace answers two questions: what does this content program stand
for, and how does it convert that stance into pieces that move an audience toward a
decision. Everything else in the namespace serves those two questions.

## 1. Content serves doctrine, not trends

The content program is downstream of doctrine, not upstream of it. Doctrine lives in
`example-marketing`, `ai-architecture`, and thinker namespaces. The content-strategy
namespace translates that doctrine into audience-facing language. When a trend appears,
the question is not "can we make content about this" but "does this trend give us a
better vehicle to deliver a pillar." If the answer is no, ignore the trend. If yes,
build an angle from the pillar and use the trend as a surface.

This discipline prevents the common failure mode where a content calendar fills with
timely but incoherent pieces that share no strategic DNA.

## 2. Angles are grounded, not invented

An angle is not a topic. It is a specific attack vector on a pillar, grounded in
evidence or real doctrine. The construction rule in [[signal-to-angle]]: start from a
signal (a data point, a concrete observation, a decision made), identify which pillar it
illuminates or challenges, then state a claim that connects the signal to the pillar
consequence. The claim is the angle. Evidence and references then fill `references/`.

An angle without a signal is an opinion. An angle without a pillar connection is a
content topic, not a content strategy. Both are weak.

## 3. The program exists to move an audience toward a decision

Content that does not change what someone believes, plans, or does is content for its own
sake. The output of a content program is not posts or articles. The output is a shift in
the audience's model of the problem, which eventually moves them toward a product or
decision that the operator cares about. Each pillar names the shift it is designed to
produce. Each angle names the specific belief it is challenging or reinforcing. Each
example in `examples/` shows whether the mechanism worked.

## 4. Cross-links matter more here than in most namespaces

A content-strategy namespace cross-links extensively because content is downstream of
almost every other namespace. It links to `example-marketing` for brand positioning, to
`ai-architecture` and thinker namespaces for doctrine to translate, and to Data System
namespaces for the evidence that grounds angles. These links are not decorative. They are
the source of truth for angle grounding. An angle that cites no doctrine or evidence node
is a candidate for removal.

## Changelog

- 2026-05-30: initial example scaffold (sprint ai-architecture-namespace-v2-upgrade).
