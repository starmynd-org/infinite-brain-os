# Capability Registry Rules

This file governs `departments/CAPABILITIES.md`, the cross-department callable index the fleet coordinator reads when
it decides whether work should delegate into another department.

The registry is a durable contract surface. It is not live state, a queue, or a run ledger. It says
what a department can be asked to do, under what conditions, and with what hard flags. It does not say
whether a specific call is in flight today.

## Purpose

Use the capability registry to answer:

- what callable capabilities exist across the department fleet
- which department owns each capability
- what the caller must provide
- what the caller should expect back
- what preconditions must already be true
- which callers are allowed to invoke the capability
- whether the capability is external or canon-touching by contract

## Entry shape

Each capability entry in `departments/CAPABILITIES.md` must carry this exact field set:

- `Capability`
- `Owning department`
- `Interface`
- `Cost class`
- `Allowed callers`
- `Hard flags`

The `Interface` field must always break into:

- `Inputs`
- `Outputs`
- `Preconditions`

Keep the shape identical across entries so the fleet coordinator can parse the registry mechanically without
department-specific adapters.

## Field rules

### Capability

Name the callable unit, not the whole department. Use a stable slug-like label plus a short plain-
English title when helpful.

Good:

- `intake-routing-and-receipt`
- `platform-delivery-health-diagnosis`
- `client-architecture-onboarding-plan`

Bad:

- `finance department`
- `marketing help`

### Owning department

Exactly one department owns the capability. Cross-department collaboration can be named in
preconditions or allowed callers, but shared ownership is not allowed in the registry row.

### Interface

Describe the callable contract, not the internal method.

- `Inputs`: the minimum information the caller must supply
- `Outputs`: the artifact, packet, recommendation, or routed result the caller gets back
- `Preconditions`: facts that must already be true before the call is valid

Do not hide a required prerequisite inside prose elsewhere in the entry.

### Cost class

Use one of:

- `low`
- `medium`
- `high`
- `human-gated`

This is a rough execution and coordination cost signal for routing, not a billing system.

### Allowed callers

List the departments, lanes, or caller classes that may invoke the capability. If a capability is
department-internal only, say so explicitly. If the fleet coordinator is expected to call it, list the fleet coordinator explicitly.

### Hard flags

Every capability entry must state:

- `external: true | false`
- `canon-touching: true | false`

These flags use the same semantics as `entities/rules/trigger-taxonomy.md` and
`entities/rules/signal-vocabulary.md`.

## Registry discipline

- The registry is callable index, not workflow prose. Link or reference implementation surfaces only
  where needed for clarity.
- The registry is not permissionless. If a caller is not listed under `Allowed callers`, the fleet coordinator should
  treat the capability as unavailable by default.
- The registry is not the runtime scheduler. Invocation, queuing, and completion live outside git.
- If a capability's preconditions or hard flags change materially, update the registry in the same
  change that updates the owning department contract.
- If a capability becomes obsolete, remove or replace it intentionally. Do not leave stale call shapes
  for the fleet coordinator to guess at.
