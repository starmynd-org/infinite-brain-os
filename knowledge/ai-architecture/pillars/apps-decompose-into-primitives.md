---
id: "apps-decompose-into-primitives"
aliases: ["apps-decompose-into-primitives", "app-primitive-north-star", "self-hosting-app-os"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "North-star pillar: a real application is not a monolith to host but a composition of the OS core primitives (namespaces, agents, skills, workflows, tools) with a thin surface UX on top, self-hosted by the Claude Code or Codex agent runtime in a shareable repo. The CRM old app is the first proof. The test: can the core primitives absorb real app development without leaving the primitives."
confidence: 0.88
retrieval_class: "identity"
export_class: "internal"
verified_at: "2026-06-03"
verified_by: "operator-pending"
edges:
  - target: "[[surface-classes]]"
    relation: "depends_on"
    confidence: 0.92
  - target: "[[surface-boundary]]"
    relation: "depends_on"
    confidence: 0.9
  - target: "[[core-doctrine]]"
    relation: "derived_from"
    confidence: 0.9
  - target: "[[entity-tools]]"
    relation: "depends_on"
    confidence: 0.85
created: "2026-06-03"
---

# Apps Decompose Into Primitives, Self-Hosted by the Agent Runtime

## Read this first: the north star

This is a program north star that keeps getting lost across chats and agents. It is written here,
in the doctrine layer, so every commander and agent loads it before touching application work.

The test the OS is trying to pass: **can the core primitives of `infinite-brain-os` absorb
real application development without leaving the primitives?** A real app should not be hosted as a
foreign monolith bolted onto the repo. It should decompose into the OS's native primitives, with
only a thin surface UX on top, and the runtime should be the agent itself (Claude Code or Codex),
not a separate application backend.

This is a direct consequence of the architecture already settled in [[core-doctrine]]: the
consumer is a grep-and-read agent over the working tree (section 5), Claude Code and Codex are
adapters not owners (section 10), and a surface declares what it reads and owns and may never
become a second source of truth (section 1). The north star takes that to its conclusion for whole
applications.

## The decomposition contract: app piece to primitive

Every part of an application maps to a primitive that already exists in this OS. Port one piece at
a time; what cannot map to a higher primitive gets packaged as a custom tool.

| Application piece | Target primitive | Home |
|-------------------|------------------|------|
| Data and content | Namespace | `knowledge/<ns>/` |
| Judgment and pipeline roles | Agent | `entities/agents/` |
| Reusable technique | Skill | `entities/skills/` |
| Multi-step procedure (with judgment) | Agentic workflow | `workflows/` |
| Deterministic flow (no judgment) | Deterministic workflow | `automations/n8n/` |
| Bounded capability or script | Tool (in-repo custom tool) | `tools/<name>/` pointed at by `tools/<name>.md` |
| Read and visualization view | S1 surface | thin render over namespaces |
| Cockpit, queue, approval board | S2 surface | thin render plus runtime state |
| Composer and authoring | S3 surface | drafts that promote into truth |
| Chat and write path | S4 agent runtime | embedded Claude Code or Codex |
| Sync and report runs | S5 deterministic surface | runs over the namespaces |
| The irreducible remainder | Custom tool plus a thin surface | `tools/<name>/` plus an S-class surface |

The custom-tool pattern is already proven in this repo: `tools/youtube_ingest/` is a real in-repo
Python package (cli, extractor, pipeline, platform) pointed at by a `tools/` node, per
[[entity-tools]]. The remainder of any app is packaged the same way.

The discipline for deciding which primitive a given piece of an app should become, and how the
primitives call each other, is [[choosing-the-right-primitive]], distilled operatively in
`_system/primitive-selection-rules.md`.

## The runtime model: the agent is the backend

A surface that needs a chat, a decision, or a write path **embeds an S4 runtime** (Claude Code,
Codex, or an Agent SDK process) rather than building its own model backend. This is settled in
[[surface-classes]]. The end state has no separate application server: the thin surface renders the
namespaces and stages actions, and the embedded agent runtime executes them by triggering the
sub-primitives (agents, skills, workflows, tools) over the working tree, promoting durable change
through visible git events under approval. The surface stays thin. It never owns truth.

## The distribution vision: a shareable, self-hosting repo

The same repo shape is meant to be shared. Once it works here, a similar repo is handed to others,
who run it in their own Claude Code or Codex to self-host and run everything. The product is the
repo of primitives plus an agent runtime. Nothing is hosted for the user; the user brings the
runtime. This is why the durable layer is plain Markdown and YAML in git, why surfaces are thin,
and why the runtime is a replaceable adapter. Anti-lock-in (core-doctrine section 10) is what makes
the repo portable enough to share.

## The first proof: the CRM old app

The CRM old app (`ai-crm-tool`, a Next.js application in the handover drop) is the first real test
case. Its data is already migrated into `email-campaign-production` and `drift-brand`; its pipeline
roles are declared as agents; its workflow is declared. What remains to prove the north star is the
hard part: turn its scripts into in-repo custom tools, package the irreducible runtime as a custom
tool, build a thin surface UX that triggers all of these through an embedded S4 runtime, run it
inside this repo with no external app server, and confirm the surface-classes taxonomy holds.

This proof also closes an open architecture gate: [[surface-classes]] is explicitly provisional and
must be validated by a first built surface before it can be promoted to canon. Building the CRM as
primitives is that validation.

## Success criteria for the north star

1. Every piece of the CRM app maps to a named primitive, with the mapping recorded.
2. The app's scripts and irreducible runtime are in-repo tools, not pointers to an external app.
3. A thin surface UX runs inside `infinite-brain-os`, reads the namespaces as truth, and
   triggers the agents, skills, workflows, and tools through an embedded Claude Code or Codex
   runtime, with no separate application backend.
4. The surface owns only view and runtime state and promotes durable change through visible git
   events, never becoming a source of truth.
5. The whole thing self-hosts from the repo plus an agent runtime, so the same shape can be shared.
6. The surface-classes taxonomy is confirmed by the built surface and is promotable to canon.

## Status

This is the operative north star for application work in this OS. It is research-state doctrine,
operator-pending. It anchors the CRM-as-primitives proof program. Any agent or commander doing
application work loads this node first so the goal stops getting lost.
