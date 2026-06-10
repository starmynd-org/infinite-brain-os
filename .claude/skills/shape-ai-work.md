---
id: "skill-shape-ai-work"
aliases: ["skill-shape-ai-work", "shape-ai-work"]
type: "Skill"
namespace: "personal-operator"
lifecycle_state: "research"
summary: "Turn a messy human problem into the smallest valid AI-shaped entity system without over-packaging, hidden autonomy, or category errors."
confidence: 0.96
retrieval_class: "identity"
export_class: "internal"
description: "Use this skill before building new entities when the real problem is still fuzzy and the system needs to decide what should become knowledge, workflow, agent, project, task, or swarm."
edges:
  - target: "[[intake-fabric-namespace]]"
    relation: "references"
    confidence: 0.85
created: "2026-05-29"
---

# shape-ai-work

Use this skill before creating new entities when the problem is still messy.

## Goal

Find the smallest valid entity set that can represent the work correctly.

## Decision ladder

1. Is this an inbound item or durable understanding? (the intake-versus-canon gate)
2. Is the problem clear enough to model?
3. Is the main output durable understanding?
4. Is the main output repeated action?
5. Is there scoped work that needs tasks?
6. Is the work swarm-shaped?
7. Is explicit human approval required?

## Intake versus canon routing (V2)

Before mapping the work to an entity, decide whether it is inbound or durable. This is
the first and most common category error to avoid.

- If the work is an **inbound item** that just arrived and has not been processed, it
  goes to **intake**, not into a namespace. A captured X thread, a bookmarked article, a
  YouTube transcript, a forwarded email, an unprocessed idea: these land as intake
  records under `intake/sources/<source>/`, get a routing decision, and only then move
  into a durable home. Do not write an unprocessed inbound item straight into a namespace
  as if it were settled understanding. See [[intake-fabric-namespace]] for why intake is
  a root OS layer and not an ordinary knowledge namespace.
- If the work is **durable understanding** that has been digested and is ready to be
  retrieved and reasoned from, it goes to a **namespace** under `knowledge/<namespace>/`:
  a concept, decision, playbook, synthesis note, or, when operator-approved and
  compressed, canon. The destination namespace owns the truth; intake never owns truth.
- The path between them is the promotion path: a captured item leaves a processed receipt
  in `intake/processed/`, and the distilled signal moves into the namespace. When an item
  is both (an inbound source that produces durable understanding), keep the receipt in
  intake and route the understanding to the namespace. Do not collapse the two.

## Mapping rules

- unprocessed inbound item -> intake record plus routing decision (not a namespace yet)
- durable understanding -> knowledge, decision, playbook, memory
- repeated deterministic action -> workflow
- repeated bounded reasoning -> agent
- reusable method -> skill
- direct invocation shortcut -> command
- cross-cutting norm -> rule
- scoped work -> project plus tasks
- multi-lane governed execution -> swarm-backed task plus sprint package

## Anti-patterns

- writing an unprocessed inbound item straight into a namespace instead of routing it
  through intake first
- choosing swarm because the work sounds ambitious
- choosing agent when a knowledge node or checklist is enough
- encoding governance in hidden runtime behavior
- splitting simple work into too many entity types

## Output contract

Return:

1. problem classification
2. smallest recommended entity set
3. recommended execution mode
4. what stays human-only
5. next builder skills to use

