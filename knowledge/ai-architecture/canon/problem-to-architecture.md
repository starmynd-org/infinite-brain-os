---
id: "knowledge-ai-architecture-canon-problem-to-architecture"
aliases: ["knowledge-ai-architecture-canon-problem-to-architecture", "ai-architecture-problem-to-architecture", "problem-to-architecture"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "The operator procedure for converting an unstructured problem or business workflow into an implementable, AI-architecture-shaped system: classify the problem, choose entity types, shape namespaces and canon, decide deterministic versus agentic, set the surface boundary, define outputs and metrics, and route to intake or a swarm."
confidence: 0.92
retrieval_class: "identity"
export_class: "internal"
verified_at: "2026-05-31"
verified_by: "operator-pending"
edges:
  - target: "[[system-overview]]"
    relation: "derived_from"
    confidence: 0.92
  - target: "[[core-doctrine]]"
    relation: "derived_from"
    confidence: 0.9
  - target: "[[knowledge-namespaces]]"
    relation: "references"
    confidence: 0.85
  - target: "[[knowledge-nodes]]"
    relation: "references"
    confidence: 0.85
  - target: "[[workflows]]"
    relation: "references"
    confidence: 0.85
  - target: "[[deterministic-workflows]]"
    relation: "references"
    confidence: 0.85
  - target: "[[agents]]"
    relation: "references"
    confidence: 0.85
  - target: "[[projects]]"
    relation: "references"
    confidence: 0.85
  - target: "[[output-nodes]]"
    relation: "references"
    confidence: 0.85
  - target: "[[metrics]]"
    relation: "references"
    confidence: 0.85
  - target: "[[surface-boundary]]"
    relation: "bounded_by"
    confidence: 0.88
  - target: "[[planning-to-execution-ladder]]"
    relation: "aligned_with"
    confidence: 0.85
created: "2026-05-31"
---

## Read this first

This is the canon for turning a messy human problem or a business workflow into a system
shaped like the Infinite Brain OS. It is a usable operator procedure, not a theory. Run it
when someone hands you a fuzzy goal ("we keep losing track of competitor pricing", "I want
the brain to draft my weekly board update") and you need to decide what becomes knowledge,
what becomes a workflow, what becomes an agent, where it lives, and what stops it from
becoming a second source of truth. Read [[system-overview]] first for the entity map; read
[[core-doctrine]] for the reasoning. The goal is the smallest valid entity set that
represents the work correctly, with no over-packaging and no hidden autonomy.

## Step 1: Classify the problem

Before choosing any entity, name what kind of thing the problem produces. Most problems
are a mix; classify by the dominant output.

- **Durable knowledge**: the problem produces understanding that should be retrieved and
  reasoned from later (a model, a decision, a procedure). Routes to a
  [[knowledge-namespaces|namespace]] and [[knowledge-nodes]].
- **Repeated action**: the problem is a recurring task that should run the same way each
  time. Routes to a [[workflows|workflow]] (agentic) or a [[deterministic-workflows|
  deterministic workflow]] (n8n).
- **Data**: the problem is about a number, a table, or a dashboard. Routes to a
  [[data-nodes|data node]] (pointer) and, if the number must agree across namespaces, a
  [[metrics|metric]].
- **Decision**: the problem is a judgment that recurs and needs bounded reasoning. Routes
  to an [[agents|agent]] or a [[knowledge-nodes|decision node]] depending on whether it
  runs or is recorded.

First and most common category error to avoid: an unprocessed inbound item is not durable
knowledge yet. A captured article, transcript, or forwarded email goes to the root
`intake/` fabric, gets a routing decision, and only then distills into a namespace. Do not
write an unprocessed item straight into a namespace as settled understanding.

## Step 2: Choose the entity types

Map the classified work to the smallest valid entity set. The defaults:

- durable understanding becomes a [[knowledge-nodes|knowledge node]], decision, playbook,
  or [[memory-nodes|memory node]]
- repeated deterministic action becomes a [[deterministic-workflows|deterministic
  workflow]]
- repeated reasoning procedure becomes an agentic [[workflows|workflow]]
- recurring bounded judgment becomes an [[agents|agent]]
- a reusable method becomes a [[skills|skill]]
- a direct invocation shortcut becomes a [[commands|command]]
- a cross-cutting norm becomes a [[rules|rule]]
- scoped work becomes a [[projects|project]] with tasks
- a recurring feedback system becomes a [[workflow-loops|workflow loop]] composed of the
  above
- a data reference becomes a [[data-nodes|data node]]; a cross-namespace number becomes a
  [[metrics|metric]]
- a produced artifact becomes an [[output-nodes|output node]]
- an external integration becomes a [[tools|tool]] pointer

Do not split simple work across many entity types, and do not reach for an agent or a
swarm because the work sounds ambitious. The test is whether each entity earns its own
durable home.

## Step 3: Shape namespaces and canon

If the work produces durable knowledge, decide its namespace. A new namespace is warranted
when several related nodes share one identity and a governance boundary larger than a
single node. Pick one of the eight profiles by the namespace job (Doctrine, Tool Contract,
Data System, Design System, Component Library, Content Strategy, Operating Library, or
Intake Fabric), and confirm against [[knowledge-namespaces]]. A serious namespace carries
the shared base (`INDEX.md`, `canon/`, `playbooks/`, `support/`, `synthesis/`) plus the
profile-additive folders. Plan its canon last: canon is the compressed, operator-approved
synthesis an agent loads first, built once enough nodes exist to compress, never as a
paraphrase of the nodes. Until then the understanding lives as nodes and `synthesis/`.

## Step 4: Decide deterministic versus agentic

For any repeated action, split it along the deterministic boundary:

- use a [[deterministic-workflows|deterministic workflow]] (n8n JSON) when the work has an
  explicit trigger, accepts structured inputs, and can run, re-import, and re-export
  without hand editing and with testable success and failure behavior
- use an agentic [[workflows|workflow]] or [[agents|agent]] when the work needs open-ended
  reasoning, synthesis, or review loops

For hybrid flows, keep the orchestration and review logic in the agentic workflow and
extract the deterministic subflows to `automations/n8n/*.json`, each paired with a brain
record. Routing across modes stays visible and human-gated.

## Step 5: Set the surface boundary

Decide where state lives before building. Apply [[surface-boundary]]: any adapter (a
cockpit, a dashboard, an inbox app) may own session, preferences, queue, and draft state,
but durable approved knowledge stays in git canon, and no surface may mutate canon without
a visible promotion event. Live queue state never enters git. If the work touches an
external app, name what it reads, what state it owns, its write path, and whether promotion
is required. This is the step that keeps a useful interface from drifting into a second
source of truth.

## Step 6: Define outputs and metrics

Name what the system produces and how it is measured. Every namespace answers what outputs
its canon drives, recorded in the `INDEX.md` "What this namespace drives" section. A
produced artifact becomes an [[output-nodes|output node]] with lineage back to the workflow
or agent that made it. If success depends on a number that two or more namespaces must
agree on, define it once as a [[metrics|metric]] keyed by `metric_id` rather than letting
each surface redefine it. A system whose canon improves nothing measurable is suspect.

## Step 7: Route to intake or a swarm

Decide the execution path. If the trigger is inbound items, wire the front end to the root
`intake/` fabric so captures get a routing decision and a processed receipt before they
become nodes. If the work needs several coordinated lanes, durable contracts, or
multi-role governance, it is swarm-shaped: move the execution anchor onto a shared
canonical task, package the swarm sprint, and require a file-backed human approval receipt
before launch (a recommendation may never bypass the gate). Otherwise keep it as a local
[[projects|project]] with tasks routed to manual, workflow, or agent modes. The parent task
stays the planning anchor in every case, per [[planning-to-execution-ladder]].

## Step 8: Register the session and force closeout

If the work will happen through an AI chat surface, register the session in the root
`sessions/` layer before substantial work begins. Declare the transcript path, the goal,
the linked task or project or sprint, and the initial context loaded. At the end, force a
closeout review that extracts memory candidates, PKM candidates, follow-up tasks, swarm
follow-ups, human-review needs, and system-improvement candidates. Raw session logs are
valuable provenance, but they are not durable truth and do not bypass the normal promotion
path.

## Output of the procedure

Running this canon produces a build plan: the problem classification, the smallest entity
set, the namespace and profile (if any), the deterministic-versus-agentic split, the
surface and state-ownership decision, the outputs and metrics, the execution route, the
session-registration and closeout requirement when chat is involved, and what stays
human-only. Hand that plan to the builder skills (`build-namespace`,
`build-knowledge-node`, `build-workflow`, `build-agent`, and the rest) to implement.

## Governing rules and doctrine

This procedure operationalizes [[core-doctrine]] and [[system-overview]]. It composes the
control model (where truth lives), the planning ladder, the deterministic boundary, the
surface boundary, and the intake three-layer split into one decision flow. The reusable
skill form of the first two steps is `skill-shape-ai-work` under `entities/skills/`; this
canon extends it through namespace shaping, the surface boundary, outputs and metrics, and
swarm routing. The operative rules that constrain each entity choice live in `_system/`;
the reasoning lives in this namespace.

## Changelog

- 2026-05-31: initial problem-to-architecture canon (canon-depth expansion, sprint
  v2-rollout-and-ops-hardening).
