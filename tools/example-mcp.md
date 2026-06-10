---
id: "tool-example-mcp"
aliases: ["tool-example-mcp", "example-mcp"]
type: "Tool"
namespace: "personal-operator"
lifecycle_state: "research"
summary: "Example MCP pointer describing an optional retrieval adapter."
confidence: 0.8
retrieval_class: "identity"
export_class: "internal"
edges:
  - target: "[[agent-research-assistant]]"
    relation: "used_by"
    confidence: 0.7
created: "2026-05-20"
---

# Tool: gbrain MCP Server (Example Optional Retrieval Adapter)

> **v3.1 note:** This file describes gbrain as an example of an OPTIONAL retrieval
> adapter. v3.1 does not require any retrieval adapter; agents read git directly via
> Claude Code's Read, Grep, and Glob primitives. Install gbrain only if a deployment
> outgrows direct read at very high node counts (typically several thousand nodes).
> See `INFINITE-BRAIN-V3-SPEC.md` Section 12 for the retrieval contract.

When installed, gbrain provides semantic retrieval over the Infinite Brain knowledge graph
via the Model Context Protocol. It is an edge component, never a system of record.

## What it does

When installed, gbrain indexes the Markdown node files in this repo and the connected
canon repos. It exposes a search interface via MCP so Claude Code can retrieve relevant
nodes by natural-language query without loading every file.

gbrain is read-only. It never writes to git or modifies any node. It is an index,
not a store. If gbrain is lost or corrupted, re-indexing from git restores it fully.

## Registration

If you choose to install gbrain, this tool is registered in `.mcp.json` at the repo
root. By default the `.mcp.json` in this template ships with `mcpServers` empty and
the gbrain block parked in `_optional_examples`; move the block into `mcpServers` to
activate it. See that file for the exact server startup command and environment variables.

## Available tools

Once connected, Claude Code has access to:

| MCP tool | Description |
|----------|-------------|
| `mcp__gbrain__search` | Full-text and semantic search across indexed nodes |
| `mcp__gbrain__get_node` | Retrieve a single node by id |
| `mcp__gbrain__list_by_type` | List all nodes of a given entity type |
| `mcp__gbrain__list_by_lifecycle` | List all nodes at a given lifecycle_state |
| `mcp__gbrain__edges` | Return the outgoing edges from a node |

## Usage in a session

```
Search for all Knowledge nodes about customer segmentation.
```

If gbrain is installed as an optional adapter, agents may call `mcp__gbrain__search`;
otherwise, agents use Read, Grep, and Glob directly against the local clone. You do not
need to invoke either path manually; refer to the work in natural language and Claude
Code routes the call to whichever retrieval surface is available.

## Index scope

gbrain indexes:
1. This personal repo: all nodes with `lifecycle_state: research, candidate, or canon`.
   (Nodes at `scratch` are not indexed to keep the retrieval signal clean.)
2. The connected company-canon repo.
3. The connected department repo.

See `.mcp.json` for the `GBRAIN_REPOS` configuration.

## Updating the index

The index rebuilds automatically when Claude Code connects to the MCP server.
It can also be triggered manually:

```
npx @gbrain/mcp-server rebuild
```

Run this after a large batch of new nodes to ensure the index is fresh.

## Relationship to git

gbrain holds the index. Git holds the nodes. If they disagree, git wins.
Never treat gbrain search results as authoritative if they conflict with the
actual file on disk. Always prefer `Read` over `mcp__gbrain__get_node` when
you need to see the exact current state of a file.
