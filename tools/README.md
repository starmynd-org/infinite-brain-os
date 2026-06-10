---
id: "tools-readme"
aliases: ["tools-readme", "tool-registry"]
type: "Doc"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Root registry for tools used by the Infinite Brain OS, its departments, and its namespaces."
confidence: 0.9
retrieval_class: "identity"
export_class: "public"
created: "2026-05-31"
---

# Tools Registry

`tools/` is the root operating registry for execution dependencies.

Use this folder to answer:

- what tools exist in this OS
- what each tool is for
- which departments depend on it
- which namespaces reason about it
- what workflows and agents use it
- whether it is live, planned, limited, or deprecated
- which secret references it depends on, when that dependency is material

This is a routing and ownership surface, not a substitute for deep tool documentation.

## When to use `tools/`

Use `tools/` for:

- execution dependency discovery
- department-level tool mapping
- runtime location and status tracking
- linking tools to workflows, agents, and namespaces

Use `knowledge/` for deeper tool-contract or data-system documentation when a tool needs
serious API, UI, schema, or ETL treatment.

## What counts as a Tool

A Tool is a bounded capability with a stable interface, reused by callers. Two shapes qualify:

- **External integration**: an MCP server or API registered in `.mcp.json`. The node points at
  the external service.
- **In-house repo-native capability**: a capability built here whose implementation lives in
  the repo, pointed at by a tool node. The implementation is the runtime; the node is the
  durable pointer describing the capability.

In both cases the node is documentation and binding, not the running implementation, and secrets
are referenced through the secret-reference model, never inlined. A Tool differs from a Workflow
or Agent by being a bounded capability rather than orchestration-with-judgment; a Workflow or
Agent calls Tools.

When a tool needs managed credentials, the tool entry should point at one or more stable
`secret_ref.id` values in the root `secrets/` registry rather than copying environment-variable
names or provider-specific secret-manager prose into every caller.

## Current entries

- [[example-mcp]]
- [[order-ledger]] (the worked example: the candle studio's order-export API)

Add one node per tool from `_template.md` and list it here.

## Core rule

The tool registry is explicit. Agents should not have to guess what tools exist from random
workflow prose or scattered notes.

See:

- `_system/tool-registry-rules.md`
- `secrets/README.md`
- `_system/department-assembly-rules.md`
- `_system/department-runtime-contract.md`
