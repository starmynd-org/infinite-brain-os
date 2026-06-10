---
id: "knowledge-ai-architecture-canon-core-doctrine"
aliases: ["knowledge-ai-architecture-canon-core-doctrine", "ai-architecture-core-doctrine", "core-doctrine"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Compressed first-principles synthesis of the Infinite Brain architecture: one control model, AI shadow departments as the real ROI unit, namespace-first topology, a canon layer over a graph, retrieval over raw memory, profile-aware design, synthesis and intake as first-class layers, explicit PKM stewardship from intake-operations to infinite-brain-ops, the root tools, secrets, and repo registries, correction to structure, harness portability, output linkage, the metric primitive, and public export as an outward surface. Operating gaps and planned additions are tracked in synthesis, not in canon."
confidence: 0.95
retrieval_class: "identity"
export_class: "internal"
verified_at: "2026-06-10"
verified_by: "the-operator"
edges:
  - target: "[[infinite-brain-control-model]]"
    relation: "derived_from"
    confidence: 0.95
  - target: "[[ai-shadow-departments]]"
    relation: "derived_from"
    confidence: 0.92
  - target: "[[department-assembly-model]]"
    relation: "derived_from"
    confidence: 0.9
  - target: "[[planning-to-execution-ladder]]"
    relation: "derived_from"
    confidence: 0.94
  - target: "[[surface-boundary]]"
    relation: "derived_from"
    confidence: 0.93
  - target: "[[deterministic-workflow-boundary]]"
    relation: "derived_from"
    confidence: 0.9
  - target: "[[knowledge-graph-namespace-first-topology]]"
    relation: "derived_from"
    confidence: 0.95
  - target: "[[pm-agent-posture]]"
    relation: "derived_from"
    confidence: 0.9
  - target: "[[swarm-launch-governance]]"
    relation: "derived_from"
    confidence: 0.92
  - target: "[[infinite-brain-namespace-architecture-v2]]"
    relation: "derived_from"
    confidence: 0.9
  - target: "[[retrieval-over-raw-memory]]"
    relation: "derived_from"
    confidence: 0.92
  - target: "[[profile-aware-knowledge-graph-design]]"
    relation: "derived_from"
    confidence: 0.9
  - target: "[[canon-layer]]"
    relation: "derived_from"
    confidence: 0.9
  - target: "[[correction-loop-absorption]]"
    relation: "derived_from"
    confidence: 0.88
  - target: "[[metric-primitive]]"
    relation: "derived_from"
    confidence: 0.85
  - target: "[[intake-fabric-namespace]]"
    relation: "derived_from"
    confidence: 0.88
  - target: "[[internal-index-vs-public-llm-index]]"
    relation: "derived_from"
    confidence: 0.85
  - target: "[[system-overview]]"
    relation: "anchors"
    confidence: 0.9
  - target: "[[problem-to-architecture]]"
    relation: "anchors"
    confidence: 0.88
created: "2026-05-30"
---

## Read this first

This is the canon of the `ai-architecture` namespace. It is the compressed
first-principles synthesis a future agent should reason from before it expands into the
graph below it. Read it whole. Then load the specific pillar, concept, or decision the
question needs, using [[agent-load-order]] as the controller.

The Infinite Brain is a git-backed knowledge operating system for an AI-first operator.
Its job is to make a corpus of knowledge, decisions, and procedures reliably retrievable
and safely executable by AI agents, today and after the tools change. Its business aim is
to make whole functions operable as AI-first shadow departments with a thin human layer on
top. Everything below is a consequence of taking that job seriously. The architecture has
one control model, one ontology, one physical topology, and a small set of layered
disciplines that keep the graph trustworthy as it scales into many namespaces and then
assembles those namespaces into departments.

## 1. The control model: one planning ladder, a source-of-truth split, bounded adapters

The architecture is built around one durable rule, expanded in
[[infinite-brain-control-model]]: planning, governance, and durable knowledge stay
canonical in git, while execution, queue state, and tool-specific runtime state stay in
the operational substrate that owns them. There are three system layers and they do not
overlap:

1. **Git-backed canon** for project intent, doctrine, rules, workflows, and durable
   summaries. This is the source of truth for what is known and decided.
2. **Operational state** for live tasks, queues, in-flight approvals, runs, and swarm
   fanout. This is mutable, fast, and not authoritative about meaning.
3. **Analytical history** for throughput, telemetry, and trend analysis. This is
   numbers, not doctrine.

Because the layers are clean, many AI-facing adapters can exist without forking the
truth: Obsidian as a reading surface, Claude Code and Codex as execution clients, n8n as
deterministic workflow runtime, Paperclip as cockpit and operational projection, and
swarm sprint folders as specialized execution packaging. Each adapter is a **surface**,
and the surface boundary in [[surface-boundary]] is non-negotiable: a surface declares
what it reads, what state it may own, what write paths it uses, whether promotion or
approval is required, and which identity it acts under. A surface may own session state,
preferences, queue and review state, and drafts with a clear writeback path. A surface
may never become the only durable home of approved knowledge, hide canonical semantics
in a private runtime schema, or mutate canon without a visible promotion event. Useful
interfaces drift into second sources of truth unless this contract is explicit, so it is
made explicit.

The planning ladder in [[planning-to-execution-ladder]] is the canonical anchor for all
work: `initiative`, then `project`, then `task`. Specialized execution layers (workflow
definition, run, swarm sprint, wave) hang off the parent task without changing the
ontology. The parent task stays the planning anchor even when work routes to `manual`,
`workflow`, `agent`, or `swarm`. This rejects three anti-patterns directly: making each
swarm sprint a canonical project, creating a second backlog in the sprint folders, and
letting a cockpit surface redefine the ladder. The deterministic-versus-agentic boundary
in [[deterministic-workflow-boundary]] sits alongside this: deterministic work (n8n JSON,
shell, validators) is paired with a brain record but runs where determinism is cheap;
agentic reasoning runs where judgment is required. Routing across modes is visible and
human-gated. The PM-agent in [[pm-agent-posture]] chooses the lowest-cost safe mode,
recommends swarm readily for substantial multi-agent work, emits routing rationale and
missing prerequisites, and stops short of launch authority. Swarm launch itself is
governed by [[swarm-launch-governance]]: a structurally valid canonical task, an explicit
swarm execution mode, a file-backed human-granted approval receipt, and bounded closeout
writeback of only distilled planning truth. Routing may recommend; it may never bypass
the gate.

## 2. The business unit is the AI shadow department

The architecture is not merely a clean way to store knowledge. Its real economic unit is the
AI shadow department. This is the lesson behind the computer-in-the-corner problem in the
older computer era and the AI-toolbar problem now: local productivity gains do not become
company-level ROI unless the whole function is redesigned. One worker moving faster inside a
broken chain does not fix the chain.

The Infinite Brain therefore assumes the target operating state is an AI-first department with
comprehensive intake, its own knowledge, its own execution surfaces, and a thin human layer on
top. The thin human layer still owns goals, approvals, and hard exceptions, but the first pass
belongs to AI. This is why intake is so load-bearing, why the system needs department start-here
guides, and why each department should have a head-of-department agent and its own daily
update. The department itself is not a new low-level entity type. It is an assembly over the
ontology, expressed through the root `departments/` layer and the links it makes visible.

There is also a useful split inside the meta-system itself:

- `intake-operations` owns capture, normalization, durable receipts, and the first-pass
  routing suggestion.
- `infinite-brain-ops` owns the structural PKM decision: what should change in the brain,
  what should become support or synthesis, what should become a canon candidate, and what
  should instead become a task, tool entry, workflow, or new department implication.

That split prevents the intake function from quietly becoming the canon function and makes
the stewardship path auditable.

The same logic applies to software delivery. Cross-cutting GitHub, CI/CD, deployment,
environment, secrets, and observability capabilities usually belong in a shared platform
department rather than being redefined independently by every domain department.

The same logic also applies to repo sprawl. Once the OS spans many repos, those repos need an
explicit registry so departments can state which repos they own, consume, or plan to digest.
Without that registry, cross-repo planning silently collapses back into human memory.

Every real department should also carry a charter. The assembly surface answers what the
department contains; the charter answers what it is trying to optimize and how success is
measured. Without both, the department is incomplete.

## 3. Namespace-first topology and the shared base

The knowledge graph is organized physically by namespace first, not by node type first.
This is settled in [[knowledge-graph-namespace-first-topology]] and reaffirmed in V2 by
[[infinite-brain-namespace-architecture-v2]]. The unit is `knowledge/<namespace>/`, and
each namespace holds its own typed subfolders and, where migration matters, its own full
archive colocated with it. The global registry lives in `_system/namespaces/`. The
reasons hold: it matches how operators browse, it makes partial sharing and repo-splitting
straightforward, it keeps full PKM possible because doctrine and raw archive live
together, and it makes migration audits tractable because each namespace has one physical
home. Type-first layout is rejected as the long-term topology; it does not scale to many
namespaces and full-source migrations. Cross-namespace links remain expected. Storage by
namespace is for browsability and portability, not isolation.

Every serious namespace shares one **base surface set**, defined in
[[profile-aware-knowledge-graph-design]] and the operative profile registry: `INDEX.md`,
`canon/`, `playbooks/`, `support/`, and `synthesis/`. A profile adds folders to this base.
A profile never removes a base surface and never invents a competing ontology. The shared
base is what lets one set of review rules, one validator, and one load-order discipline
work across every namespace. Starter and example namespaces may carry a reduced base and
must say so in their `INDEX.md`.

Namespace-first topology does not mean repo-blind topology. The OS may span several repos, so a
separate repo-registry layer is justified for cross-repo ownership, purpose, and digestion
tracking.

## 4. The canon layer: compressed reasoning over a graph

Each serious namespace carries a `canon/` layer, explained in [[canon-layer]] and
[[what-canon-means]]. Canon is the compressed, operator-approved, provenance-bearing
first-principles synthesis a future agent thinks from before expanding into the graph.
It is closer to the synthesized Boyd HTML docs than to a one-line loader. Canon
synthesizes and compresses across pillars, concepts, and decisions; it does not paraphrase
them node by node. It is small relative to the graph it sits over. It is the first thing
an agent loads. It carries `derived_from` edges to what it compresses, `verified_at` and
`verified_by` frontmatter, and a `## Changelog`.

What canon is not: not a copy of `pillars/`, not a parking lot for open questions
(unresolved material lives in `synthesis/`), not runtime state, not raw archive, not a
public export. The promotion path is strict: raw source flows to `support/` (provenance
recorded), then to `synthesis/` (derived reading), then to a canon-candidate, then to
canon on operator approval. The canon discipline is what keeps the top layer trustworthy
as the graph grows: without it, canon either inflates into a second copy of the corpus or
decays into a stale loader. The required canon files for a full-canon namespace are
`README.md` (navigational), `core-doctrine.md` (this node), and `agent-load-order.md`
(navigational). Stateful namespaces add `current-truth.md`; this one does not, because it
holds durable doctrine.

## 5. Retrieval over raw memory: name the consumer

Memory is raw material; retrieval is the operating layer. The right small fragments beat
a large undifferentiated context. This is the core thesis in
[[retrieval-over-raw-memory]], and it is why the whole architecture exists: a pile of
notes is not a brain, a retrievable graph is. The decisive move is to **name the consumer**
and design surfaces for that real reader. Today the consumer is Claude Code and Codex
file-reading agents that retrieve by grep and read against the working tree. There is no
external index in the baseline; the local clone plus any sibling canon repos is the entire
retrieval surface. Surfaces are therefore designed for a grep-and-read agent: rich
`INDEX.md` routers, canon entry points, resolvable wikilinks, kebab-case type-prefixed
ids, and tight nodes that fit a context window. MCP or RAG is a possible future adapter,
not a present dependency. If a retriever is ever planned, the retrieval load-order policy
names it; until then it is not assumed. This is the difference between architecture that
serves a real reader and architecture that serves an imagined one.

## 6. Profile-aware graph design: eight profiles, one ontology

Different knowledge domains need different folder shapes, but they must not fork the
ontology. The resolution, in [[profile-aware-knowledge-graph-design]] and
[[namespace-profiles]], is one ontology and eight profiles over the shared base. Each
profile adds folders and a lint emphasis; none replaces the base. The eight, locked in
[[namespace-profile-set-v1]]:

- **Doctrine** (Stable): durable concepts, principles, decisions. Adds `pillars/`,
  `concepts/`, `decisions/`, optional `archive/`. This namespace is Doctrine.
- **Tool Contract** (Provisional): how to call a tool or API correctly. Canon file of
  record is `core-contract.md`.
- **Data System** (Provisional, highest near-term value): source-to-dashboard data flow.
  Uses the metric primitive.
- **Design System** (Provisional): approved visual and stylistic canon.
- **Component Library** (Provisional): approved reusable implementation patterns; source
  code stays in its implementation repo.
- **Content Strategy** (Provisional): themes, positions, angles, and their links to
  marketing, product, doctrine, and evidence.
- **Operating Library** (Provisional): how to execute recurring work and diagnose
  problems. May use the metric primitive for diagnosis.
- **Intake Fabric** (Stable as a root layer, not a knowledge namespace): inbound capture
  and routing, lives at root `intake/`.

Stable means a real namespace validates the schema; Provisional means the schema is
defined from analysis and must be validated against the first real namespace of that type.
Provisional profiles ship as reference scaffolds in `knowledge/_examples/`, which doubles
as the second and third reference implementations. Profiles with shared DNA (Design System
and Component Library; Tool Contract, Data System, and Operating Library) are kept distinct
for now and revisited only if two real namespaces prove they collapse. The required base
and profile surfaces are enforced by [[required-namespace-surfaces]].

## 7. Synthesis as first-class

Derived thinking that is neither raw archive nor settled canon node gets its own home.
Synthesis is first-class, with two levels: `knowledge/<namespace>/synthesis/` for
within-namespace derived work (contradiction maps, best-current-reading notes,
what-changed reviews, canon-candidate packages) and `synthesis/` at repo root for
cross-namespace work that no single namespace should own. The synthesis-versus-support
boundary is sharp and load-bearing: `support/` holds provenance, migration receipts, and
source-priority tables (mechanical and historical); `synthesis/` holds interpretive,
current, derived intellectual work. Do not put synthesis in `support/`; do not put
migration receipts in `synthesis/`. Open disputes live in `synthesis/`, never in canon.
This namespace points its live questions to `synthesis/profile-comparison`,
`synthesis/current-namespace-gap-map`, and `synthesis/x-research-lessons`.

## 8. Intake as a root OS layer: the three-layer split

Intake is a root OS layer at `intake/`, not an ordinary knowledge namespace. It is the
convergence point for inbound items from X, bookmarks, YouTube, web, repos, email, Slack,
ideas, and AI-guided deep research, explained in [[intake-fabric-namespace]]. Its
discipline is the **three-layer split**:

1. **Connector and runtime layer**: OAuth, polling, token refresh, live queue state.
   Stays in the operational app, for example a small FastAPI connector app. Live
   queue state is never tracked in git.
2. **Durable intake layer** (in git, at `intake/`): captured source records, processed
   receipts, routing decisions, routing doctrine, playbooks.
3. **Knowledge layer** (in `knowledge/`): only distilled doctrine, decisions, playbooks,
   and receipts produced from intake. The destination namespace owns the durable canon;
   intake never owns truth.

Intake captures source context, tracks processing and routing, and moves high-signal
items into durable homes. The three record schemas (intake record, routing decision,
processed receipt) are the operative contract. The split is what keeps live operational
churn out of the durable graph while still preserving the receipt trail that makes intake
auditable.

Where an intake item implies a structural change to the brain, a fourth trace artifact is
added: the PKM opportunity. That creates an explicit auditable chain:

```text
source record -> processed receipt -> PKM opportunity -> disposition -> files changed or task created
```

This is how the system traces not only routing, but structural learning.

## 8.25. Sessions are a root audit layer

AI work sessions also need a durable trail, but transcripts are neither canon nor live
queue state. The root `sessions/` layer holds session registration records, raw transcript
copies, and closeout reviews for conversations that touched the repo. The session layer is
parallel to intake in one important way: it is an upstream audit surface that feeds durable
structure, not the durable structure itself. A session may produce memory candidates, PKM
candidates, tasks, swarm proposals, support notes, or synthesis, but the transcript does
not bypass the promotion path. Session start is forced: register the chat, declare the log
path, record the initial context. Session end is forced: close out the session, extract
follow-ups and learnings, and move them into their proper homes. The retrieval rule is the
same as elsewhere in the architecture: the session record and closeout review load first,
the raw log opens only on demand for audit or handoff recovery.

## 8.5. Tools are a first-class operating registry

Execution dependencies should be explicit. The root `tools/` layer is the operating registry
for tools the OS depends on: APIs, UI apps, data sources, automation runtimes, MCP servers,
and export adapters. This registry is not a replacement for deeper tool documentation. It is
the discoverability, ownership, and routing layer over those dependencies.

When a tool needs serious API or ETL documentation, that deeper treatment belongs in a
tool-contract or data-system namespace under `knowledge/`. The root registry exists so
departments, agents, and workflows do not have to guess what systems exist or who depends on
them.

## 8.6. Secrets are a first-class reference registry

Credential posture should be explicit without turning git into a secret store. The root
`secrets/` layer is the operating registry for provider-neutral secret references: stable
`secret_ref.id` values, ownership, runtime scope, backend pointers, and rotation posture. It
stores references and policy metadata only. Raw values stay in the external secret backend and
bind at runtime.

This registry exists so tools, surfaces, deterministic workflows, and future namespace consumers
such as brand or design-system work do not invent parallel secret maps or inline provider-specific
details in many places. The shared `devops-platform` department owns this posture by default, and
domain departments usually consume it rather than re-defining it.

## 9. Correction to structure

Repeated correction becomes structure, not repeated chat. When an operator corrects an
agent the same way twice, the correction is absorbed into a rule, playbook, decision, or
canon revision so the agent stops needing the correction. This is the loop in
[[correction-loop-absorption]], and it is how the brain learns rather than just
accumulating. The correction loop closes against the right layer: a recurring routing
mistake becomes a decision or playbook; a recurring factual error becomes a canon
revision with a changelog entry; a recurring intake misroute becomes a routing rule. The
test is simple: if you would otherwise type the same correction a third time, it belongs
in structure.

## 10. Harness and memory portability

If you do not own the harness, you do not fully own memory. Git-backed canon is durable;
adapters are replaceable. Anti-lock-in is a design goal, not an afterthought. The truth
lives in plain Markdown and YAML in git, readable by any agent that can read files, so
the brain survives a change of model, client, or vendor. Claude Code and Codex are
current adapters, not owners. This is why canon is files and not a proprietary store, why
ids and links are plain text, and why the retrieval baseline is grep-and-read rather than
a hosted index. Portability is preserved by keeping the durable layer tool-agnostic and
pushing tool-specific state to the surfaces that own it under [[surface-boundary]].

## 11. Output linkage

Every namespace answers what outputs its canon drives. Output is first-class: a
namespace whose canon improves nothing is suspect. Output linkage appears in each
`INDEX.md` under "What this namespace drives" and in reviews. For `ai-architecture` the
driven outputs are the namespace builders and curators, the validator rules, the swarm
governance contract, the intake scaffold, and the V2 upgrade plans for every other
namespace. Naming the outputs keeps doctrine honest: it forces each piece of canon to
point at a real decision, project, or artifact it should make better.

## 12. The metric primitive

A metric is one shared typed node, not three private definitions. It is keyed by
`metric_id` and has three faces, defined in [[metric-primitive]]: definition (what it
means), lineage (source, transform, model, refresh, owned by the Data System namespace),
and diagnosis (what moves it, failure modes, next actions, owned by the Operating Library
namespace). Both faces reference the same `metric_id`. The metric primitive is the bridge
that keeps a Data System namespace and an Operating Library namespace talking about the
same number instead of two divergent ones. It carries `format`, `polarity`, `aggregation`,
`expression`, and `depends_on` so the number is unambiguous across namespaces.

## 13. Public export is a surface, not architecture

Public LLM surfaces such as `llms.txt` are export and discovery surfaces, not internal
architecture, per [[internal-index-vs-public-llm-index]] and
[[public-llm-index-export-posture]]. The internal `INDEX.md` is the rich retrieval router
for trusted agents. `llms.txt` is a thin public summary generated from `canon/`, never
from raw notes, and only for namespaces meant for external discovery. The generator reads
canon and produces the public surface; it never bypasses canon or publishes internal-only
material. Keeping export downstream of canon means the public face cannot drift from the
private truth, and the private truth is never shaped by what is safe to publish.

## 14. Operating gaps and planned additions are tracked in synthesis

Canon describes the system as it runs. Requirements for operating capability the system
does not currently run, including the four additions the 2026-06-03 management-system analysis
contributed (a standing operating scorecard and review cadence, flow control over agent
work, fleet-level autonomy governance, and accountability plus cost pacing), are tracked
in two synthesis nodes: `autonomy-readiness-requirements` states each requirement with
its current status, and `autonomy-architecture-gap-register` is the audited,
severity-ranked gap register beneath them. When a requirement is built, verified, and
operator-approved, the operating discipline it produces enters canon through the normal
promotion path.

## 15. What the recent analysis does not add

Most of the recent management-system corpus should not be imported into `ai-architecture`
canon because it is either already built here or not needed at the doctrine layer.

### 15.1. Already built here

These were corroborated, not newly discovered:

- the three-plane source-of-truth split and surface boundary
- correction to structure instead of repeated correction by chat
- single-owner tasks and bounded launch authority
- retrieval designed for a real file-reading consumer
- namespace-first topology and canon-first reasoning
- the AI shadow department thesis rather than local AI-toolbar gains

These are stronger after the external analysis, but they were already core doctrine.

### 15.2. Not needed as canon imports

These do not justify architecture-level adoption:

- the full EOS or Traction package, including its complete ritual and vocabulary layer
- the full Scaling Up framework beyond the constraint, scorecard, and pacing insights
- the full Metronomics horizon stack as architecture doctrine; its unique value mostly
  collapses into focus and pacing, tracked as requirements in
  `autonomy-readiness-requirements`
- generic agile ceremony as the governing model of the brain; agile remains a delivery
  method, not the architecture's control model
- Boyd as the main organizing architecture frame; Boyd remains a complement on
  orientation and adaptation, not the control model of record

The rule is simple: import the missing governor, not the source framework's whole
language.

## Next reads after the spine

This node is the compressed spine. Three canon reads sit directly under it and should be
loaded next depending on the question:

- [[system-overview]]: the single read-this-first map of the whole OS. It names every
  entity type, shows how they compose, and states the four orienting disciplines (the
  INDEX-and-canon-first load order, the `_system`-versus-doctrine split, the surface
  boundary, the planning ladder). Read it when the question is "what is the system and how
  do I navigate it."
- [[department-model]]: the compressed doctrine for AI shadow departments. Read it when the
  question is "how does this OS become a real AI-first department rather than a set of
  disconnected helpers."
- The entity-type canon in `canon/entities/`: one file per type ([[skills]], [[agents]],
  [[commands]], [[rules]], [[workflows]], [[deterministic-workflows]], [[workflow-loops]],
  [[knowledge-namespaces]], [[knowledge-nodes]], [[data-nodes]], [[memory-nodes]],
  [[output-nodes]], [[projects]], [[tools]], [[metrics]]). Each states what the type is
  for, when to use it, its required shape, how it relates to the others, and the rules that
  govern it. Read the relevant file when the question is "how do I build or choose type X."
- [[problem-to-architecture]]: the operator procedure for converting an unstructured
  problem or business workflow into an implementable, AI-architecture-shaped system. Read
  it when the question is "how do I turn this messy goal into the OS."

## How these pieces compose

The architecture is one system, not twelve. The control model decides where truth lives.
Namespace-first topology decides where knowledge sits. The canon layer decides what an
agent reads first. Retrieval-over-raw-memory decides who that agent is and what it can do.
Profiles decide how a domain shapes its folders without forking the ontology. Synthesis
and intake decide where derived thinking and inbound flow live. Correction-to-structure
decides how the brain learns. Portability decides what survives a tool change. Output
linkage decides what the brain is for. The metric primitive decides how numbers stay
coherent across namespaces. The department model decides how the ontology assembles into
business functions with AI-first intake and thin human oversight. Public export decides what
faces outward. An agent that holds
these together can reason about any specific architecture question and know which deeper
node to open next.

## Changelog

- 2026-05-30: initial V2 canon synthesis (sprint ai-architecture-namespace-v2-upgrade).
- 2026-05-31: added the "Next reads after the spine" section pointing at the new
  system-overview, the per-type entity canon in canon/entities/, and the
  problem-to-architecture canon (canon-depth expansion, sprint
  v2-rollout-and-ops-hardening).
- 2026-06-03: narrowed the recent management-systems analysis to four canon additions:
  operating scorecard plus cadence, flow control, fleet autonomy governance, and
  accountability plus cost pacing. Marked the rest as already built or not needed.
- 2026-06-10: moved the four future-capability additions (old section 14) out of canon into
  synthesis/autonomy-readiness-requirements with a pointer left in section 14, because canon
  describes the system as it runs. Operator-approved (the-operator) in the 2026-06-10
  working session that commissioned the harness-hardening program.
- 2026-06-10: added canon/doctrine-card.md, a compressed operating projection of this node
  that the root CLAUDE.md and AGENTS.md startup now reads first, with
  _system/retrieval-routing-map.md for namespace selection and mandatory drill-down to this
  node and _system/README.md for architecture-, contract-, and canon-touching work; the card
  is re-verified when this node changes and this node wins on conflict. Operator-approved
  (the-operator) in the 2026-06-10 working session that commissioned the harness-hardening
  program.
