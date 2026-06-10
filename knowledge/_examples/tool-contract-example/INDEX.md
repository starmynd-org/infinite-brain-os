# tool-contract-example

This is a reduced-base EXAMPLE scaffold for the Tool Contract profile (Profile B). It is
not a real namespace. Copy it as a starting point when creating a new namespace whose job
is to tell an agent exactly how to call a tool or API correctly.

The subject used here is a generic "example-api": a fictional API with a create-record
operation. Nothing here is a real integration contract.

## Profile

Tool Contract (Profile B, Provisional). This profile is for namespaces whose job is to
document how to call a tool or API correctly, including payload shapes, auth patterns,
error handling, and worked examples. The canon file of record is `canon/core-contract.md`
in place of the standard `core-doctrine.md`. Additive folders on top of the shared base:
`operations/`, `concepts/`, `decisions/`, `references/`, `examples/`. See
[[namespace-profiles]] for the full profile registry.

## Load first

1. [[core-contract]]: the locked operational contract for this tool or API. Read whole
   before any operation.
2. [[agent-load-order]]: what to load next by query class.
3. [[canon/README]]: what canon means for a tool contract namespace.

Top files after canon:

- `operations/INDEX.md`: the fast router for recommended calls and call selection.
- `operations/create-record.md`: the characteristic operation. Shows how one operation
  is documented: endpoint, payload shape, auth note, error patterns.
- `examples/create-record-payload.json`: a valid sample payload for the create-record
  operation.
- `playbooks/build-tool-contract-from-public-docs.md`: example multi-step procedure for
  building a real tool-contract namespace from public docs.

## Required system-fit statement

Every real tool-contract namespace should carry a short explicit statement, usually in
`canon/core-contract.md`, that answers:

- which fit class applies: `ai-architecture-component`, `os-operational-tool`,
  `client-or-external-delivery-tool`, or `department-local-tool`
- what part of the OS the tool serves
- what the tool is allowed to own
- what remains outside the tool boundary

Only the `ai-architecture-component` class should usually roll into
`knowledge/ai-architecture/` doctrine. The others still need the statement, but their
main rollup is typically to a tool entry, department surface, client surface, or
workflow.

## Required verification note

Every real tool-contract namespace should say what was actually exercised during the
build. At minimum, the namespace should record for its key calls whether they are:

- `live-tested`
- `dry-run-tested`
- `doc-derived`
- `known-broken`

That note should live in `support/` so future agents can quickly see whether a call was
proven, merely documented, or later found to have drifted.

## Query classes

- **How to call an operation** (correct call, payload shape, required fields): load the
  `operations/INDEX.md` router first, then the relevant file in `operations/`, then check
  `examples/` for a worked payload.
- **What call should I make** (choose the right operation quickly): load
  `operations/INDEX.md`, then the recommended operation node, then the matching example
  payload.
- **Auth and credential pattern** (how auth works, what credentials are needed): load
  [[core-contract]], then the relevant `concepts/` file.
- **Error handling** (what errors occur, how to handle them): load `concepts/error-patterns.md`
  and the relevant `operations/` file.
- **Decisions** (why this integration was designed this way): load `decisions/`.
- **Reference material** (API docs pointers, rate limits, changelog): load `references/`.
- **How to build a real namespace from docs** (repeatable build procedure): load
  `playbooks/build-tool-contract-from-public-docs.md`.
- **Open disputes** (open questions about the contract): load `synthesis/`.

## Stable vs stateful

Stable (changes only when the API itself changes): the core contract, payload field
names, error code enumerations, auth mechanism. Carry `review-on-edit` freshness.

Stateful (needs periodic review): base URL, rate limits, auth token lifetime, any field
marked as "check current docs". Carry `periodic` freshness and a `verified_at` date.

## Open disputes

No real disputes exist in an example scaffold. In a real tool contract namespace, track
disputed or unclear contract points in `synthesis/`.

## What this namespace drives

In a real namespace, list the agents, workflows, or automations that depend on this
contract. If no agent reads this contract, question whether the namespace is needed.

## Archive and provenance

This example carries no `archive/`. Provenance notes (where the contract was sourced
from, migration from an older version) live in `support/`.

## Common misreadings

- Treating `core-contract.md` as a copy of the upstream API docs. Canon compresses and
  interprets; it does not restate the full docs. Link to the full docs in `references/`.
- Putting worked example payloads directly in `operations/`. Use the `examples/` folder
  for sample payloads; keep `operations/` for the contract description.
- Skipping the `operations/` file and going directly to `examples/`. The example payload
  only makes sense with the operation contract loaded first.
- Treating the namespace as if canon alone is enough to choose calls. Canon gives the
  global contract; `operations/INDEX.md` gives the actual call router.

## Map

```text
knowledge/_examples/tool-contract-example/
  INDEX.md                          # this retrieval router (you are here)
  canon/
    README.md                       # navigational: what canon means here
    core-contract.md                # knowledge node: locked tool contract
    agent-load-order.md             # navigational: load order by query class
  operations/
    INDEX.md                         # operational router: recommended calls and call selection
    README.md                       # navigational: what goes in operations/
    create-record.md                # knowledge node: example operation contract
  concepts/
    README.md                       # navigational: what goes in concepts/
  decisions/
    README.md                       # navigational: what goes in decisions/
  references/
    README.md                       # navigational: what goes in references/
  examples/
    README.md                       # navigational: what goes in examples/
    create-record-payload.json      # sample payload for create-record
  playbooks/
    README.md                       # navigational: what goes in playbooks/
    build-tool-contract-from-public-docs.md
  synthesis/
    README.md                       # navigational: what goes in synthesis/
  support/
    README.md                       # navigational: what goes in support/
```

The operative registry entry for a real namespace of this profile lives at
`_system/namespaces/<slug>.md`.
