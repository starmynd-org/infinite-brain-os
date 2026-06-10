# intake-fabric-example

This is a reduced-base EXAMPLE scaffold for profile `intake-fabric` (Profile H). It is
not a real namespace. It documents the intake-fabric profile, its doctrine, its
structural decisions, and how operators and agents should interact with the real intake
fabric.

IMPORTANT: the live intake fabric is at the repo root under `intake/`, not here. This
namespace holds only the distilled doctrine, the structural decisions, and
process-pointing playbooks. It does not hold queues, source records, or routing state.
Those live at `intake/` and in the operational app layer.

An agent answering "what is intake" or "how does intake processing work" loads this
namespace first, then follows links to `intake/` for the live operational scaffold.

## Profile

Intake Fabric (Stable as a root layer). Profile H in the architecture contract. The
intake fabric is not an ordinary knowledge namespace: its live operational layer lives at
repo root `intake/`. This `knowledge/intake-fabric-example/` namespace exists only to
hold distilled doctrine, decisions about the three-layer split, and playbooks that point
to the real `intake/` scaffold. See [[intake-fabric-namespace]] for the full architectural
rationale.

This example uses `lifecycle_state: research` on all nodes to reflect their status as
illustrative scaffolding.

## Load first

Canon entry points, in order:

1. [[core-doctrine]]: the compressed intake-fabric doctrine. What intake is, what the
   three-layer split means, and what this namespace does versus what `intake/` does.
2. [[agent-load-order]]: which files to load for which query class.
3. [[canon/README]]: what canon means in this namespace and how to update it.

After canon:

- [[three-layer-split-decision]]: the locked architectural decision separating connector
  state, durable intake records, and knowledge-layer doctrine.
- [[intake/README]] (at repo root): the live intake scaffold README.

## Query classes

- **What is the intake fabric and where does it live**: load [[core-doctrine]], then
  `intake/README.md` at repo root.
- **Why does intake have a three-layer split**: load [[three-layer-split-decision]],
  [[core-doctrine]] section 2.
- **How to process an inbound item through intake**: load
  [[how-to-process-an-intake-item]], which points to `intake/playbooks/`.
- **Where do processed items from intake land in knowledge**: load [[core-doctrine]]
  section 3, then follow the routing doctrine at `intake/routing/destination-rules.md`.
- **What record schemas govern intake**: load `intake/schemas/` at repo root. The schema
  documentation lives there, not here.

## Stable vs stateful

Stable (durable doctrine): the three-layer split decision, the canon that intake never
owns truth, the separation of connector state from durable records. These change only
when the architectural decision is revisited.

Stateful (changes with operational context): the routing destination map, the playbooks
for specific source families, the schema versions. These live in `intake/` and are
reviewed when new sources are added or when routing rules change. This knowledge namespace
does not track that state.

## Open disputes

No live disputes in this scaffold. In a real namespace built from this scaffold, open
disputes would live in `synthesis/` if the intake-fabric profile had one. Because Profile
H is a thin knowledge namespace pointing to a root layer, synthesis is intentionally
absent from this scaffold. Contested routing decisions would instead be documented in
`intake/routing/` with a decision receipt.

## What this namespace drives

This namespace drives:

- an agent's ability to understand the three-layer split and know where to look for live
  queue state versus durable records
- correct routing of inbound items by operators and agents who read intake doctrine before
  using `intake/`
- onboarding: an agent or new operator who reads this namespace first can navigate the
  full intake fabric without confusion about what belongs where

## Archive and provenance

`support/README.md` describes provenance conventions and points to the migration history
at `intake/`. No archive folder exists in this namespace because intake never owns truth.
Historical context lives in `support/`.

## Common misreadings

- Looking here for live queues or source records. Those live at `intake/sources/` and
  `intake/processed/` at repo root. This namespace holds only doctrine.
- Assuming this namespace holds the authoritative routing rules. Routing doctrine lives at
  `intake/routing/destination-rules.md`. This namespace explains why that structure exists.
- Treating intake as a knowledge namespace. Intake is a root OS layer. It captures and
  routes. The destination namespace owns the durable canon. Intake never owns truth.
- Expecting synthesis here. Profile H is thin by design. Derived thinking from processed
  intake items should go into the destination namespace where the item was routed, not
  back into the intake-fabric namespace.

## Map

```text
knowledge/_examples/intake-fabric-example/
  INDEX.md                             # this retrieval router (example)
  canon/
    README.md                          # what canon means here (navigational)
    core-doctrine.md                   # compressed intake-fabric doctrine (knowledge node)
    agent-load-order.md                # load order by query class (navigational)
  decisions/
    README.md                          # what goes in decisions/
    three-layer-split-decision.md      # the locked three-layer split decision
  playbooks/
    README.md                          # points to live intake/playbooks/ at repo root
    how-to-process-an-intake-item.md   # a thin pointer playbook
  support/
    README.md                          # provenance and migration pointer

Live intake scaffold (NOT in this namespace):
  intake/                              # repo root intake/ scaffold
    README.md
    sources/
    processed/
    routing/
    playbooks/
    namespaces/
    schemas/
```
