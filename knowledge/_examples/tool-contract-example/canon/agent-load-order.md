# Agent Load Order: tool-contract-example

This file is navigational. It tells agents what to load next after reading
`core-contract.md`, by query class.

## Always load first

`core-contract.md` in full. It states the auth mechanism, error contract, and
cross-cutting constraints that apply to every operation. Do not skip it.

## By query class

**Making a specific call** (what endpoint to hit, what payload shape to send):
Load `core-contract.md`, then the relevant file in `operations/`, then confirm with a
sample payload in `examples/`.

**Auth or credential question** (how to get a token, when it expires):
Load `core-contract.md` (auth section), then any `concepts/` file on auth if present.

**Error handling** (what to do when a specific code is returned):
Load `core-contract.md` (error contract), then the `operations/` file for the failing
call.

**Design rationale** (why this integration is shaped this way):
Load `decisions/`.

**Rate limits, SLAs, changelog** (current operational parameters):
Load `references/`.

**Open questions** (disputed or unclear contract points):
Load `synthesis/`.

## What not to load first

Do not load `operations/` before `core-contract.md`. Operations assume the auth and
error contract is already understood. An agent that goes directly to an operation file
without the contract may call with wrong headers or handle errors incorrectly.

## Navigational note

This file does not carry node frontmatter. It is a navigational aid for agents, not a
knowledge node.
