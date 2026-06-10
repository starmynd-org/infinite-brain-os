# Retrieval in v3.1: Direct Git Read

This document explains how retrieval works in this repo and how to use it correctly.
Read this before asking why a node is not appearing in search results.

---

## The principle

**Git is the source of truth, and the working tree is the retrieval surface.**

In v3.1 there is no gbrain installation, no separate index, no MCP server required
for search. Claude Code and Codex read the local git tree directly using their
native primitives: Read, Grep, and Glob. The local clone of this repo plus any
sibling canon or department repos the user has cloned is the entire retrieval
surface.

See INFINITE-BRAIN-V3-SPEC.md Section 12 for the full design rationale.

---

## What gets searched

Agents search node-bearing markdown files in:

1. **This personal repo**: every file under `knowledge/`, `memory/`, `entities/`,
   `outputs/`, `data/`, `projects/`, `intake/`, and `workflows/`.
2. **Sibling canon repos**: if the operator has cloned `../company-canon/`,
   `../department-{name}/`, or other canon repos as siblings, agents include
   their `knowledge/` and `entities/` trees in the search root.

GitHub team permissions determine which canon repos the operator has access to;
cross-repo reads on disk respect that boundary because the operator can only
clone what they can read.

---

## What gets filtered

Agents read each matched file's frontmatter and apply a lifecycle filter:

- **`canon`** nodes always count.
- **`research`** nodes count in this personal repo (your refined work).
- **`candidate`** nodes count when relevant (under-review work).
- **`scratch`** nodes are excluded by default. They are too noisy.

If you want scratch nodes included for a specific query, say so explicitly when
you prompt the agent.

---

## How agents do it

The `[[agent-research-assistant]]` pattern is:

1. `Glob` to enumerate node-bearing markdown files under the relevant subtrees.
2. `Grep -i -l` with the topic and likely synonyms to narrow to files that
   plausibly mention it.
3. `Read` the frontmatter (and body, if confirmed relevant) of the top matches.
4. Filter by `lifecycle_state`.
5. Synthesize.

For path-shaped queries ("all decisions about pricing") `Glob` alone is enough.
For free-text retrieval, `Grep` does the heavy lift.

---

## When you might add an index later

Direct read scales well to thousands of nodes on a modern machine. If a
deployment ever outgrows it (very high node counts, very large vault sharded
across many repos, or strict latency requirements), an optional retrieval
adapter may be added:

- A vector store keyed on node id.
- A dedicated MCP retrieval server.
- A pre-built `ripgrep`-backed cache.

These are adapters at the edge. They do not change the entity model. The
canonical files in `entities/`, `knowledge/`, `memory/`, etc. remain the source
of truth. The optional adapter is purely a search accelerator.

This is consistent with v3.1 Principle 3 (ports and adapters): runtime is an
adapter at the edge, the canonical model is the core.

---

## The schema reference

This personal repo contains local validation assets under `_system/`, but the fuller
shared canon schema is still owned by `company-canon/_system/FRONTMATTER-SCHEMA.md`.
To consult that upstream schema once the canon repo is cloned, ask Claude Code:

```
Read the frontmatter schema from the company-canon repo.
```

Claude Code will resolve the file via `Read` on the cloned sibling repo path.
If the canon repo is not cloned alongside, the operator clones it first.
