# emberline-studio

The worked example domain namespace: a fictional small e-commerce candle business,
Emberline Candle Studio. It exists so a new adopter can see one complete, tiny namespace
with every moving part in place before building their own. Study it, then replace it with
your own first namespace (or delete it once you have one).

## Posture

Reduced base, registered in `_system/namespaces/emberline-studio.md`. It carries only
`INDEX.md`, `canon/`, and `concepts/`: the smallest namespace the contract allows. A
serious namespace adds `playbooks/`, `support/`, and `synthesis/` (see
`_system/namespace-profiles.md`).

## What each file teaches

- `canon/brand-essentials.md`: a canon node. Operator-approved, verification fields, a
  changelog, identity-class retrieval. The single source of truth the studio's agents load
  first.
- `concepts/seasonal-collection.md`: a research-state concept node. Defined, linked, and
  ready to be refined or promoted.

## How it connects

The namespace is one corner of the example set. The brand voice rule
(`entities/rules/studio-brand-voice.md`) derives from the canon node. The product
description skill reads it. The example department (`departments/example-studio-ops/`)
assembles all of it. Follow the edges from `canon/brand-essentials.md` outward.
