# Surface Contract Rules

This is the operative contract for surfaces. It states what a surface must declare before it is
built or connected, and what the validator checks. The reasoning, the three-plane model, and the
five surface classes live in the doctrine nodes [[surface-boundary]] and [[surface-classes]];
this file does not restate the reasoning, it states the rule.

A surface is a thin adapter over the Infinite Brain. It reads the truth plane (git canon), owns
state only in the runtime plane (the operational substrate), renders through the render plane,
and writes durable change back into the truth plane only through a visible promotion event. Live
queue state never enters git. A surface never becomes the only durable home of approved
knowledge, never hides canonical semantics in a private runtime schema, and never mutates canon
without a visible promotion event.

## The nine-item declaration

Every surface declares all nine items. The declaration lives as one file per surface under
`_system/surface-registry/`, registered in `_system/surface-registry/INDEX.md`, and linked from
the owning department `INDEX.md`. The file also declares a `class:` of S1 through S5 (see
[[surface-classes]]).

1. **Truth sources read.** Which repos, namespaces, and canon files the surface reads, and
   whether each read is a read-only projection or a read for proposal. Default is read-only.
2. **Owned runtime state.** The explicit list of state the surface owns in the runtime plane.
   This state lives in the operational substrate, never in git canon. If the substrate is served or
   mutated through a bounded bridge capability, declare that bridge and its substrate path here or
   in item 7; the runtime plane remains a plane, not a primitive.
3. **Disallowed ownership.** What the surface must never become the only home of. Always
   includes approved knowledge, canonical semantics, and any meaning the truth plane owns.
4. **Write paths.** Each write typed as read-only projection, runtime-state write, draft write,
   or promotion event. A surface with no promotion-event write makes no durable change to canon.
5. **Promotion and approval gates.** Which writes require a visible promotion event, which
   require a human gate, and which approval receipt applies.
6. **Identity and auth boundary.** Which identity the surface and its embedded agent runtime act
   under, scoped to least privilege, with credentials resolved by reference per the
   secret-reference model.
7. **Agent runtime binding.** Which harness serves the surface chat and write path (Claude Code,
   Codex, or Agent SDK), with a portability statement: the surface must keep working if the
   harness is swapped. If a repo-native bridge tool exposes runtime state or deterministic
   capabilities to the surface, declare that bridge explicitly here.
8. **Observability and metering.** How the surface exposes session identifiers, usage data, cost
   data, and failure telemetry; whether the source is direct, SDK-derived, gateway-derived, or
   provider-side; which join key is used for deferred reconciliation; whether the closeout write is
   immediate or deferred; and how those receipts are written into `sessions/` closeout.
9. **Self-host posture.** Where the surface runs, what it depends on, and whether the operator
   can run it standalone from a clone of the repo, a render app, and an agent process, with no
   proprietary backend holding truth.

## Promotion events

Durable change to the truth plane happens only through one of six visible, typed events recorded
in git, executed by the agent runtime or a human: read-only (no promotion), runtime-state write
(stays runtime), draft to canon-candidate to canon, run to memory, intake capture to node, and
closeout to distilled planning truth. An invisible substrate write that becomes authoritative
meaning is not a promotion; it is a second source of truth and is disallowed.

## Editing executable entities

A surface that edits an agent or skill markdown writes the canonical `entities/<type>/<name>.md`
file, never the `.claude/` or `.codex/` runtime shim, preserves the dual frontmatter and
wikilinks, runs the validator, and lands a visible commit. The gate scales with lifecycle: a
`scratch` or `research` entity in a personal repo needs only a commit; a `canon` entity in a
department or company-canon repo follows the promotion path.

## What the validator checks

`_system/validate.sh` runs `check_surface_declarations`: for each live surface declaration under
`_system/surface-registry/` (every `.md` that is not `INDEX.md`, `README.md`, or a `_`-prefixed
template), it confirms all nine declaration items are present. The check is a no-op while no
surface is registered. Judgment calls (has a store drifted into a hidden second source) stay with
a curator agent and the review workflows; the validator owns only declaration completeness.

## What this is not

This is the operative contract, not the reasoning. The reasoning is [[surface-boundary]] and
[[surface-classes]]. The surface is not a new entity type; it is a contract over the existing
ontology, the way a department is an assembly and not a primitive. No surface is built by this
file; building surfaces is out of scope until the operator lifts that gate. The runtime plane is
likewise not a new entity type. A runtime bridge may be implemented as a repo-native tool when the
surface needs a stable bounded interface to runtime state or deterministic execution.

See:

- [[surface-boundary]]
- [[surface-classes]]
- `_system/surface-registry/INDEX.md`
- `secret-reference-model` (playbook and `_system/` secret rules)
