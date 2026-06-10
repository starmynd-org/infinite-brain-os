---
id: "knowledge-design-system-example-canon-core-doctrine"
aliases: ["knowledge-design-system-example-canon-core-doctrine", "design-system-example-core-doctrine"]
type: "Knowledge"
namespace: "design-system-example"
lifecycle_state: "research"
summary: "Compressed first-principles synthesis for the design-system-example profile scaffold."
confidence: 0.85
retrieval_class: "identity"
export_class: "internal"
verified_at: "2026-05-30"
verified_by: "the-operator"
derived_from:
  - target: "[[namespace-profiles]]"
    relation: "derived_from"
    confidence: 0.9
edges:
  - target: "[[namespace-profiles]]"
    relation: "implements"
    confidence: 0.9
created: "2026-05-30"
---

A design system is a single approved source of visual and stylistic truth for a product
or brand. Its purpose is to make visual decisions once and distribute them as constraints
that every implementation respects. Three principles govern a well-formed design system
canon.

## Principle 1: Decisions before values

Design principles and the constraints they impose come first. Token values are derived
from principles, not chosen arbitrarily. An agent or implementer who does not know the
principles cannot judge whether a new token value is correct or a break in the system.
Canon captures the principles and their rationale; `tokens/` captures the values they
authorize.

## Principle 2: Token, not implementation

A design system approves tokens and the rules for applying them. It does not own
implementation code. Source code stays in its implementation repository. The design
system namespace links to it, approves its token usage, and flags deviations. This
prevents the namespace from becoming a second copy of the codebase.

## Principle 3: Example over exception

Usage examples in `examples/` demonstrate how a token applies to a real component or
pattern. The example is authoritative for that application. Exceptions require a canon
update, not a workaround. Workarounds accumulate debt; exceptions revise doctrine.

## Retrieval note

An agent answering a token-value query loads `tokens/` after this file. An agent
answering a principle query loads `pillars/` after this file. An agent answering a
usage or compliance query loads `examples/` after this file. See `agent-load-order.md`.

## Changelog

- 2026-05-30: Created as part of the V2 profile example scaffold (design-system profile,
  illustrative content). Not deep content; structural proof only.
