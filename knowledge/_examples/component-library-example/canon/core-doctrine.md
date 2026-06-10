---
id: "knowledge-component-library-example-canon-core-doctrine"
aliases: ["knowledge-component-library-example-canon-core-doctrine", "component-library-example-core-doctrine"]
type: "Knowledge"
namespace: "component-library-example"
lifecycle_state: "research"
summary: "Compressed first-principles synthesis for the component-library-example profile scaffold."
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

A component library namespace is the approval and governance layer for reusable UI
components, not a second copy of the implementation. Three principles govern how it
works.

## Principle 1: Approve and link, do not duplicate

Source code lives in the implementation repository. The namespace records the approval
decision, the usage rules, the constraints, and a link to the canonical implementation
location. If a component record ever duplicates code, the code will drift from the
implementation and become actively misleading.

This means the namespace's job is clear: it answers "is this component approved for
use here, and what are the rules" rather than "what is the code."

## Principle 2: A component record is a usage contract

An approved component record carries three things beyond the component name:

1. The usage playbook: when to use the component and when not to.
2. The constraints: what must remain true about how it is composed or configured.
3. The implementation link: where to find the source in the implementation repository.

Without all three, the record is incomplete. An incomplete record is a misleading
record: an agent loading it cannot determine whether a given usage is approved.

## Principle 3: Patterns are compositions

A pattern is a named, approved combination of components for a recurring UI need. It
lives in `patterns/`, not in `components/`. The distinction matters: a component is
atomic; a pattern is composed. An agent answering "how do I build a search results
page" loads `patterns/`, not `components/`.

## Retrieval note

An agent answering a component-approval query loads `components/` after this file.
An agent answering a composition or layout query loads `patterns/` after this file.
An agent answering a deployment query loads `deployment/` after this file. See
`agent-load-order.md`.

## Changelog

- 2026-05-30: Created as part of the V2 profile example scaffold (component-library
  profile, illustrative content). Not deep content; structural proof only.
