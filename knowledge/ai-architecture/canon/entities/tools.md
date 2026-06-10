---
id: "knowledge-ai-architecture-canon-entity-tools"
aliases: ["knowledge-ai-architecture-canon-entity-tools", "ai-architecture-entity-tools", "entity-tools"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Canon for the Tool entity: a pointer node in tools/ for a bounded capability with a stable interface, either an external MCP integration registered in .mcp.json or an in-house repo-native capability whose implementation lives in the repo, with the node describing the capability and referencing credentials, never inlining secrets."
confidence: 0.9
retrieval_class: "domain"
export_class: "internal"
verified_at: "2026-05-31"
verified_by: "operator-pending"
edges:
  - target: "[[system-overview]]"
    relation: "part_of"
    confidence: 0.9
  - target: "[[core-doctrine]]"
    relation: "derived_from"
    confidence: 0.88
  - target: "[[surface-boundary]]"
    relation: "bounded_by"
    confidence: 0.85
  - target: "[[deterministic-workflows]]"
    relation: "related_to"
    confidence: 0.8
created: "2026-05-31"
---

## What it is

A **Tool** is a pointer node. It lives in `tools/` and describes a bounded capability with a
stable interface, reused by callers. The capability takes one of two shapes:

- an **external integration**, an MCP server or API registered in `.mcp.json`, where the node
  points at the external service
- an **in-house repo-native capability**, built here, whose implementation lives in the repo
  and is pointed at by the node (for example the `tools/youtube_ingest/` package pointed at by
  `tools/youtube-ingestion-platform.md`)

In both shapes the node is the brain's record of the capability, not the capability's
implementation. It names what the capability is, how it is called, and where its secrets live,
with secrets referenced rather than inlined. The dividing line versus a [[workflows|workflow]]
or [[agents|agent]] is bounded-capability versus orchestration-with-judgment, not in-house
versus external: a workflow or agent calls tools.

## When to use it (and when not)

Create a tool node when the brain needs a durable description of a capability, external or
in-house, so agents and workflows know it exists, what it does, and how to bind its
credentials. Do not create a tool node for a built-in harness capability that needs no record
of its own, and do not put secret values in the node; reference them through the
secret-reference model. A tool node is documentation and binding, not the running server or
package.

## Required shape

- **Folder**: `tools/`. For an external integration the MCP server is registered in
  `.mcp.json`; for an in-house capability the implementation lives in the repo (commonly a
  subfolder of `tools/`) and the node points at it.
- **Frontmatter**: standard node fields plus `type` appropriate to the tool pointer.
- **Body**: describe the capability, the operations it exposes, how it is invoked, and a
  link to the credential reference. Secrets are referenced through the secret-reference
  model, never written into the node. When the dependency is material, point at one or
  more stable `secret_ref.id` values in the root `secrets/` registry. Also state the
  tool's system fit: whether it is architecture-shaping, OS-operational, client-facing,
  or department-local, and what boundary that implies.

## How it relates to the other entity types

A tool node is referenced by the [[agents]] that call the integration, by the
[[workflows]] and [[deterministic-workflows]] that use it as a step, and by [[data-nodes]]
when the tool reads or writes a live source. It is a surface in the control-model sense: an
adapter the brain reaches through, bound by safe credential rules and never the owner of
durable knowledge.

When the tool materially shapes the operating model itself, its registry node should say so
explicitly and point at the relevant `knowledge/ai-architecture/` doctrine plus any deeper
tool-contract namespace. Most tools will not meet that bar. They still need a system-fit
statement, but it should usually stop at the owning departments, clients, workflows, or
runtime surfaces.

## Governing rules and doctrine

The reasoning that a tool is a bounded surface reached through approved adapters, and that
runtime credentials bind safely without entering canon, is in [[surface-boundary]] and
[[core-doctrine]]. The operative secret-reference model lives in the `secret-reference-model`
playbook and `_system/` rules; the durable reference home is the root `secrets/` registry; the
MCP registration is in `.mcp.json`. See [[system-overview]] for how tools sit in the entity set.

## Changelog

- 2026-05-31: initial Tool entity canon.
- 2026-06-01: broadened the Tool definition to a bounded capability that may be an external
  MCP integration or an in-house repo-native capability, reconciling the canon with the lived
  pattern (`youtube-ingestion-platform` and its `tools/youtube_ingest/` implementation) and the
  surface architecture refinement. verified_by remains operator-pending.
