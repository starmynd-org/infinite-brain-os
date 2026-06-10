# Canon: intake-fabric-example

This is the canon layer for the `intake-fabric-example` namespace scaffold. It is
navigational. It is not a knowledge node and does not carry node frontmatter.

## What canon means here

Canon for an intake-fabric namespace is thin by design. The intake fabric is a root OS
layer at `intake/`: its operational structure, schemas, and routing rules live there. The
canon in this knowledge namespace holds only the compressed first-principles rationale for
why intake is structured the way it is, what the three-layer split means, and what
guarantees the split provides.

An agent reading this canon will understand what intake is for, where to find the live
fabric, and what belongs in intake versus in a destination namespace. That is the
complete job of this canon.

## What lives in canon here

- `core-doctrine.md`: the compressed synthesis of intake-fabric doctrine. Full node
  frontmatter, `derived_from` edges, `verified_at`, `verified_by`, `## Changelog`.
- `agent-load-order.md`: which files to load in which order for which query class.
  Navigational only.

No `current-truth.md`. The intake fabric's current state (queue contents, connector
status, routing counts) lives in the operational app layer, not in canon.

## How canon is updated

The three-layer split decision is locked architecture (contract Part 5). Canon here changes
only when the operator revises the fundamental structure of intake. When the routing rules
or playbooks at `intake/` change, that does not require a canon update here: it requires
an update to `intake/routing/` and a note in the intake README. Canon here tracks the
structural rationale, not the operational details.

Update process: propose revision in a decision node at `decisions/`, operator reviews,
approved revision is promoted to `core-doctrine.md` with a `## Changelog` entry.
