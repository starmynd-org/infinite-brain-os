---
id: "knowledge-doctrine-example-example-discipline-pillar"
aliases: ["knowledge-doctrine-example-example-discipline-pillar", "doctrine-example-example-discipline-pillar", "example-discipline-pillar"]
type: "Knowledge"
namespace: "doctrine-example"
lifecycle_state: "research"
summary: "Example pillar node for the Doctrine profile scaffold. Shows frontmatter, edge structure, and body shape for a foundational claim."
confidence: 0.85
retrieval_class: "identity"
export_class: "internal"
edges:
  - target: "[[knowledge-doctrine-example-canon-core-doctrine]]"
    relation: "anchors"
    confidence: 0.9
created: "2026-05-30"
---

This node is an example. In a real namespace, a pillar holds the foundational claim that
everything else in the namespace derives from. There is usually one to three pillars per
namespace. Pillars use `retrieval_class: "identity"` because they are the identity-level
truth for the domain.

## The claim (example)

A first-principles discipline is built on one irreducible claim. Everything else is
derived: concepts elaborate the claim, decisions apply it, playbooks enact it.

The claim for a discipline named "example discipline" is: a system that cannot state its
own foundational claim cannot be improved systematically, because there is no fixed
reference point to measure improvement against.

## Why this claim is load-bearing (example)

Without a stated foundational claim, every improvement is local and disconnected. Two
agents working in the same domain may reach opposite conclusions because they are
optimizing against different implicit baselines.

Stating the claim in a pillar node makes it auditable. An operator can read the pillar
and decide whether the claim is still valid. If the claim changes, the operator revises
the pillar and triggers a canon update.

## What this pillar does not cover (example)

How to discover a foundational claim for a new domain is not covered here. That is a
synthesis question tracked in `synthesis/`. The applications of this claim to specific
decisions are tracked in `decisions/`.

## Pillar note

This pillar is part of an example scaffold. Replace this content with the real
foundational claim for your domain.
