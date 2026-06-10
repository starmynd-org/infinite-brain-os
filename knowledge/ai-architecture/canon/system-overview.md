---
id: "knowledge-ai-architecture-canon-system-overview"
aliases: ["knowledge-ai-architecture-canon-system-overview", "ai-architecture-system-overview", "system-overview"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "The single read-this-first map of the whole Infinite Brain OS: the entity set, the AI shadow department assembly layer, the root intake, tool, and repo registries, the intake-operations to infinite-brain-ops stewardship loop, what each part is for, how they compose, and how the system is oriented and navigated."
confidence: 0.93
retrieval_class: "identity"
export_class: "internal"
verified_at: "2026-05-31"
verified_by: "operator-pending"
edges:
  - target: "[[core-doctrine]]"
    relation: "derived_from"
    confidence: 0.95
  - target: "[[problem-to-architecture]]"
    relation: "informs"
    confidence: 0.9
  - target: "[[skills]]"
    relation: "references"
    confidence: 0.85
  - target: "[[agents]]"
    relation: "references"
    confidence: 0.85
  - target: "[[commands]]"
    relation: "references"
    confidence: 0.85
  - target: "[[rules]]"
    relation: "references"
    confidence: 0.85
  - target: "[[workflows]]"
    relation: "references"
    confidence: 0.85
  - target: "[[deterministic-workflows]]"
    relation: "references"
    confidence: 0.85
  - target: "[[workflow-loops]]"
    relation: "references"
    confidence: 0.85
  - target: "[[knowledge-namespaces]]"
    relation: "references"
    confidence: 0.85
  - target: "[[knowledge-nodes]]"
    relation: "references"
    confidence: 0.85
  - target: "[[data-nodes]]"
    relation: "references"
    confidence: 0.85
  - target: "[[memory-nodes]]"
    relation: "references"
    confidence: 0.85
  - target: "[[output-nodes]]"
    relation: "references"
    confidence: 0.85
  - target: "[[projects]]"
    relation: "references"
    confidence: 0.85
  - target: "[[tools]]"
    relation: "references"
    confidence: 0.85
  - target: "[[metrics]]"
    relation: "references"
    confidence: 0.85
  - target: "[[department-model]]"
    relation: "references"
    confidence: 0.88
  - target: "[[surface-boundary]]"
    relation: "supports"
    confidence: 0.88
  - target: "[[planning-to-execution-ladder]]"
    relation: "supports"
    confidence: 0.88
  - target: "[[system-vs-doctrine-boundary]]"
    relation: "supports"
    confidence: 0.88
created: "2026-05-31"
---

## Read this first

This is the single map of the whole Infinite Brain operating system. Read it before you
build anything, before you choose an entity type, and before you decide where a piece of
work lives. It tells you what every entity type is, how they compose into one system, and
how the system is oriented and navigated. When you need the compressed first-principles
reasoning behind the architecture, read [[core-doctrine]]. When you need to convert a raw
problem into this shape, read [[problem-to-architecture]].

The Infinite Brain is a git-backed knowledge operating system for an AI-first operator.
Its job is to make a corpus of knowledge, decisions, and procedures reliably retrievable
and safely executable by AI agents, across changes of model, client, and vendor. Its
business aim is broader than personal productivity: to let whole business functions become
AI-first shadow departments with a thin human layer on top.
Everything in the system is one of a small fixed set of typed entities, each with a home
folder so both a file-reading agent and Obsidian know what it is and where it lives.

## The entity set

The OS has a fixed entity set plus a few root operating layers. Each canonical entity type
links to its own canon file with the full shape, frontmatter, and governing rules.

Executable entities (canonical in `entities/`, mirrored to `.claude/` and `.codex/`):

- [[skills]]: reusable techniques an agent applies in a session.
- [[agents]]: bounded specialist workers that own a recurring reasoning task.
- [[commands]]: direct-invocation shortcuts with a stable intent.
- [[rules]]: cross-cutting norms and constraints read at session start.

Work entities:

- [[workflows]]: agentic reasoning pipelines in `workflows/`.
- [[deterministic-workflows]]: n8n automations in `automations/n8n/`, each JSON paired
  with a brain-record `.md`.
- [[workflow-loops]]: autonomous improvement loops, a composed pattern over the entities
  above rather than a new top-level type.
- [[projects]]: scoped work containers in `projects/{name}/`.

Knowledge-graph entities (in `knowledge/`):

- [[knowledge-namespaces]]: the `knowledge/<namespace>/` unit, profile-declared over a
  shared base.
- [[knowledge-nodes]]: pillars, concepts, decisions, and playbooks.
- [[metrics]]: the shared typed metric primitive.

Other node types:

- [[data-nodes]]: pointers to live data, never the data itself.
- [[memory-nodes]]: reviewed learnings distilled from experience.
- [[output-nodes]]: produced artifacts with lineage back to what made them.

For starter or lightweight deployments, the system intentionally permits a thin data layer:
define the metric semantics and the source contracts first, then point the live resolution at
a managed implementation such as your data-platform CLI or at a client-owned adapter. The semantic
contract belongs in the brain even when the underlying pipelines are not yet bespoke.

Tools:

- [[tools]]: the tool entity and the broader execution-dependency surface, now surfaced
  through the root `tools/` registry as well as deeper tool-contract or data-system
  namespaces when needed.

Root operating registries:

- root `departments/`: operating assembly by business function
- root `tools/`: execution dependency registry
- root `secrets/`: secret-reference and credential-policy registry
- root `repo-registry/`: cross-repo ownership, purpose, and digestion registry
- root `sessions/`: conversation archive and closeout ledger

## Department assemblies

The real operating unit of ROI is not a single agent or workflow. It is the department-sized
assembly described in [[department-model]]. Departments are not new low-level entity types. They
are structured groupings over the existing ontology:

- intake surfaces
- knowledge namespaces
- agents
- skills
- workflows
- tools
- metrics
- human review gates

The recommended physical home for that assembly is the root `departments/` layer. Each
department should have a start-here guide, a head-of-department agent, explicit intake,
linked namespaces, a charter, and a daily update that rolls into a wider brief.

Two departments now matter especially for the brain operating on itself:

- `intake-operations`: owns source capture, durable receipts, routing suggestions, and the
  first-pass "this might matter" call.
- `infinite-brain-ops`: owns the second-pass structural decision about what the brain
  should become because of that signal.

Shared platform functions often deserve the same treatment. A standalone `devops-platform`
department is the default pattern for cross-cutting GitHub, CI/CD, deployment, environment,
secrets, and observability work. Domain departments should usually consume that substrate,
not reinvent it independently.

## How the types compose

The types are not a flat list. They form layers that hand off to each other:

- A [[knowledge-namespaces|namespace]] holds [[knowledge-nodes]], its `canon/` synthesis,
  its `synthesis/` derived thinking, and its `support/` provenance. It is the durable home
  for understanding.
- A [[projects|project]] scopes work and routes each task to a mode: manual, [[workflows|
  workflow]], [[agents|agent]], or swarm. The parent task stays the planning anchor.
- A [[workflows|workflow]] runs a procedure; when it needs determinism it extracts the
  deterministic subflow to a [[deterministic-workflows|deterministic workflow]]; when it
  needs judgment it calls an [[agents|agent]]; when it adds feedback and iteration it
  becomes a [[workflow-loops|workflow loop]].
- An [[agents|agent]] applies [[skills]], obeys [[rules]], reads [[knowledge-nodes]] and
  [[tools]], and writes [[output-nodes]] and [[memory-nodes]].
- A [[metrics|metric]] is defined once and referenced by data, dashboard, and operating
  nodes across namespaces by `metric_id`.
- A department assembly groups those pieces around one business function so AI can own the
  first pass and humans can sit on top as a thin review and exception layer.
- The root `tools/` registry makes execution dependencies explicit so departments, agents,
  and workflows do not have to guess what systems exist. Each serious tool entry should
  also classify the tool's system fit so readers know whether it is architecture-shaping,
  shared OS infrastructure, client delivery infrastructure, or department-local support.
- The root `secrets/` registry makes credential references explicit so tools, surfaces,
  workflows, and future namespace consumers do not invent parallel secret maps or inline
  provider-specific details everywhere.
- The root `repo-registry/` makes cross-repo dependencies explicit so departments and planners
  do not have to guess which repo owns what function or where a digestion target lives.

The default data posture for a starter repo is therefore not "build a full warehouse before
the repo is useful." It is "define the numbers once, declare whether they are live, manual,
or not wired, and bind them to either Example Co or a client-owned adapter without redefining
the semantics."

The composition rule is the one in [[core-doctrine]]: one entity, one durable home, no
second source of truth. A pattern that spans many homes (a loop, an intake flow) is named
explicitly but does not become a new entity.

## How the system is oriented and navigated

Four disciplines orient every agent that reads the OS.

1. **INDEX-and-canon-first load discipline.** An agent answering any namespace question
   loads the namespace `INDEX.md` (the retrieval router, not a folder list) and then its
   `canon/core-doctrine.md` before expanding into the deeper graph. It loads only what the
   query needs. The right small set of nodes beats loading the whole namespace. The
   per-namespace controller is `canon/agent-load-order.md`.
2. **The `_system`-versus-doctrine split.** `_system/` owns the operative contract: the
   namespace registry, schema and rule files, and `validate.sh`, which states what must be
   true and how it is checked. `knowledge/ai-architecture/` owns the reasoning: why the
   architecture is shaped this way. Each links to the other and neither restates it. The
   test in [[system-vs-doctrine-boundary]]: if changing the text changes what the validator
   accepts, it is operative; if it changes how someone thinks, it is doctrine.
3. **The surface boundary.** Every adapter (Obsidian, Claude Code, Codex, n8n, Paperclip,
   swarm sprints) is a surface that reads the brain and may own session, queue, and draft
   state, but may never become the only durable home of approved knowledge or mutate canon
   without a visible promotion event. The contract is in [[surface-boundary]].
   Tool-contract namespaces should restate that boundary in OS-specific terms for the
   surface they cover, including what the surface is and is not allowed to own.
4. **The planning ladder.** All work hangs off one canonical ladder: `initiative`, then
   `project`, then `task`. Specialized execution layers (workflow, run, swarm sprint, wave)
   hang off the parent task without changing the ontology. The ladder is in
   [[planning-to-execution-ladder]].

## The promotion path that feeds the graph

Material moves through one disciplined path, not straight into canon. Inbound items land
in the root `intake/` fabric, get a routing decision, and leave a processed receipt. The
distilled signal becomes a [[knowledge-nodes|node]]. Raw provenance lands in `support/`;
derived interpretive work lands in `synthesis/`; operator-approved compressed synthesis is
promoted to `canon/`. Repeated operator correction becomes structure (a rule, playbook,
decision, or canon revision) rather than repeated chat. This is how the brain learns
without inflating canon into a second copy of the corpus.

The repo also carries a root `sessions/` layer for AI chat registration, transcript copies,
and closeout reviews. It is not part of the ontology and not a knowledge namespace. It is
the durable audit trail for sessions that touched the repo. The session record and closeout
review are the high-signal retrieval surface; the raw transcript is provenance loaded on
demand when an agent needs exact history, tool traces, or lost-chat recovery.

For items with structural PKM implications, there is now an explicit stewardship hop:

```text
source record -> processed receipt -> PKM opportunity -> disposition -> files changed or task created
```

That hop belongs to the handoff from `intake-operations` to `infinite-brain-ops`. It is how
the system traces not only "what came in" but "what did the brain become because of it."

## Governing rules and doctrine

This overview is the orientation layer over the canon spine. The compressed
first-principles reasoning is [[core-doctrine]]. The operative contract for the whole OS
lives in `_system/` (registry, schemas, `validate.sh`); the reasoning for why the split
exists is [[system-vs-doctrine-boundary]]. The eleven entity types and their routing are
stated operatively in `CLAUDE.md` and `AGENTS.md`; this overview synthesizes them into one
map and links each type to its full canon file. To turn a fresh problem into this shape,
go to [[problem-to-architecture]]. To turn a business function into a real AI-first
department, go to [[department-model]] and
[[translate-business-function-into-ai-shadow-department]].

## Changelog

- 2026-05-31: initial system-overview canon (canon-depth expansion, sprint
  v2-rollout-and-ops-hardening).
- 2026-05-31: updated to reflect the root `tools/` registry and the intake-operations to
  infinite-brain-ops stewardship loop.
