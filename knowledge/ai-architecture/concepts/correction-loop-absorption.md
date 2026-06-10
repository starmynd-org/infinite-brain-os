---
id: "knowledge-ai-architecture-correction-loop-absorption"
aliases: ["knowledge-ai-architecture-correction-loop-absorption", "ai-architecture-correction-loop-absorption"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Repeated human correction becomes durable structure (a rule, playbook, decision, or canon revision), not repeated chat. Three questions decide what gets absorbed and where it lives."
confidence: 0.9
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[correction-loop-rules]]"
    relation: "implements"
    confidence: 0.9
  - target: "[[canon-layer]]"
    relation: "depends_on"
    confidence: 0.88
created: "2026-05-30"
---

# Correction Loop Absorption

## Summary

When a human corrects an agent on the same point more than once, the correction is a
defect in durable structure, not a one-off chat fix. The correction should be absorbed
into a rule, a playbook, a decision, or a canon revision so the agent stops needing the
correction (contract Part 11, X research lesson 2). Correcting in chat alone guarantees
the same correction next session.

## Content

A correction loop is the pattern where an agent produces output, a human corrects it, the
agent complies for that turn, and the underlying structure stays unchanged so the next
session reproduces the original error. Each repeat is wasted operator attention and a
signal that some durable surface is missing or wrong.

Absorption converts that recurring correction into a structural change one time. After
absorption, the agent loads the corrected structure and produces the right output without
the human having to intervene again. The goal is to spend a correction once and bank it,
not to re-pay it every session.

## The three questions

Every candidate correction is triaged with three questions. They decide whether to absorb
and where the correction lives.

- What correction recurs. Name the specific, repeated correction in concrete terms. A
  one-time fix for a one-off task is not a loop and does not get absorbed. A correction
  that has appeared twice or more, or that the operator predicts will recur, is a loop.
- What structure absorbs it. Choose the durable home by the kind of correction. A
  constraint on how to write or act becomes a rule. A repeatable procedure that was done
  wrong becomes or amends a playbook. A choice between options that keeps getting
  relitigated becomes a decision node. A shift in first-principles understanding becomes a
  canon revision.
- Where it lives. Route the structure to the right namespace and folder, then link it so
  the loading agent actually reads it. Absorption that lands in a file no agent loads has
  not closed the loop.

## Routing the absorbed correction

The four target structures map to distinct homes.

- Rule: `entities/rules/` when the correction is a standing constraint on voice, format,
  or behavior across sessions.
- Playbook: `knowledge/<namespace>/playbooks/` when the correction fixes how a recurring
  procedure is executed.
- Decision: `knowledge/<namespace>/decisions/` when the correction settles a choice that
  was being relitigated, recording the reasoning so it is not reopened.
- Canon revision: `knowledge/<namespace>/canon/core-doctrine.md` when the correction
  changes the compressed first-principles understanding. A canon revision is the heaviest
  absorption and follows the canon contract: it is operator-approved, provenance-bearing,
  and recorded in the canon `## Changelog`.

## When not to absorb

Not every correction is a loop. A correction tied to a single throwaway artifact, a
correction the operator marks as context-specific, or a correction that contradicts
settled canon without a deliberate revision should stay in chat. Absorbing one-offs bloats
the durable surface and trains agents on noise. The recurrence test in the first question
is the gate.

## Edges

- `implements` the correction-loop rules, which carry the operative triage and routing
  procedure this concept explains.
- `depends_on` the canon-layer concept because the heaviest absorption target, a canon
  revision, follows the canon contract.

## Notes

Operative rules live in [[correction-loop-rules]]. This node owns the why and the
three-question test; the rules file owns the executable procedure and the recurrence
threshold. Curator agents surface correction-loop candidates as a fuzzy check; the operator
approves canon revisions.
