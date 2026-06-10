# Tool Registry Rules

`tools/` is the root operating registry for execution dependencies. It is the place to
declare what tools exist in the OS, what they are for, which departments and namespaces rely
on them, and where deeper contracts, runtime surfaces, and credential references live.

`tools/` is not a replacement for deep tool documentation. When a tool needs substantial
documentation, API-call guidance, payload examples, or integration doctrine, that material
should live in a tool-contract or data-system namespace under `knowledge/`. The registry
entry points to that deeper layer.

## Required shape

The root registry should contain:

```text
tools/README.md
tools/<tool-slug>.md
```

Optional:

```text
tools/_template.md
```

Each tool file should be a durable registry entry, not a scratch note.

## Minimum fields and sections

Each tool registry entry should state:

- tool name
- purpose
- tool type
- current status
- system fit class
- owner department(s)
- related namespace(s)
- main workflows and agents that depend on it
- runtime or source location
- auth or credential boundary
- risks or limitations
- next migration or build step if the tool is not yet integrated

When the tool depends on managed credentials, it should also point at one or more stable
`secret_ref.id` values from the root `secrets/` registry.

This can be expressed through frontmatter plus a short written body.

## System fit classification

Every serious tool entry should say how the tool fits into the wider OS, not just what
the vendor does. Use one primary fit class:

- `ai-architecture-component`
- `os-operational-tool`
- `client-or-external-delivery-tool`
- `department-local-tool`

The written body should also answer:

- what part of the OS this tool serves
- what the tool is allowed to own
- what remains outside the tool boundary
- whether the tool should roll up into `_system/` and `knowledge/ai-architecture/`

Only the `ai-architecture-component` class should routinely drive AI-architecture doctrine
updates. The other classes still need a system-fit statement, but they should usually roll
up into tool, department, client, or workflow surfaces rather than pretending to be
architecture canon.

## Tool types

Use a short, explicit classification such as:

- `api`
- `ui-app`
- `data-source`
- `automation-runtime`
- `mcp-server`
- `export-adapter`
- `integration-service`

If a tool spans more than one type, choose one primary `tool_type` and explain the rest in
the body.

## Status values

Use one primary status:

- `planned`
- `live`
- `limited`
- `deprecated`

The status should describe whether the Infinite Brain OS can actually use the tool in
practice, not whether the vendor exists.

## Department and namespace linkage

When a tool clearly belongs to one or more departments, use:

```yaml
departments: [personal-health]
```

When a tool clearly supports one or more namespaces, use:

```yaml
related_namespaces: [personal-health]
```

These help cross-reference tools with `departments/` and `knowledge/`, but the written
registry entry remains the primary durable surface.

## Optional `tools:` guidance for other entities

When an agent, workflow, namespace node, or department surface has a strong dependency on one
or more specific tools, it may declare:

```yaml
tools: [order-ledger, example-mcp]
```

Use this when the tool dependency materially affects:

- execution
- routing
- review context
- runtime projections

Do not add `tools:` just because a tool is mentioned in passing. Use it where it improves
retrieval and ownership clarity.

## Optional `secret_refs:` guidance for tool entries

When a tool has a strong dependency on one or more specific runtime-bound credentials, it may
declare:

```yaml
secret_refs: [stable-secret-id]
```

Use this when the credential materially affects:

- whether the tool is actually operable
- which runtime may call it
- which surface or workflow may bind it
- how ownership and rotation are tracked

Do not inline the raw secret or copied environment variable content. Point at the root
`secrets/` registry instead.

## Boundary with knowledge namespaces

Use `tools/` when the main need is:

- discoverability
- routing
- ownership
- dependency mapping

Use a namespace under `knowledge/` when the main need is:

- detailed API-call or UI-operation guidance
- payload or schema canon
- ETL or data-model logic
- deep integration doctrine

The registry entry should link to the deeper namespace when one exists.

## Metering boundary for runtime tools

When a tool, gateway, or provider-side audit surface materially participates in session usage
capture, its registry entry or deeper contract should also say:

- whether it is a direct, SDK-derived, gateway-derived, or provider-side metering source
- which session identifier or join key it preserves
- whether it can support closeout-time lookup or only delayed reconciliation

This keeps session metering architecture explicit without forcing vendor-specific API details into
the root session rules.

When a deep tool-contract namespace exists, keep the system-fit story consistent across
both layers:

- `tools/<tool>.md`: shallow registry view of fit, ownership, and boundary
- `knowledge/<namespace>/canon/core-contract.md`: deeper contract view of fit, ownership,
  allowed operations, and exclusions

Related:

- `_system/secret-registry-rules.md`
- `secrets/README.md`
