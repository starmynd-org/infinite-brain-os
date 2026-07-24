# ai-architecture

This namespace holds the doctrine for how the Infinite Brain is built: its control model,
its knowledge-graph topology, its canon and synthesis layers, its retrieval model, the
eight namespace profiles, the intake fabric, the session ledger layer, the AI shadow
department model, the root tools registry, the root secrets registry, the root client workspace,
and the rules that keep
the graph trustworthy as it scales. It also holds the small imported operating layer the
recent management-system review justified: scorecard plus cadence, flow control, fleet
autonomy governance, and accountability plus cost pacing. It is the architecture-of-the-architecture. An agent answering any question
about how the brain itself works, how to build or upgrade a namespace, how to log and close
out AI sessions, or how to design an AI-first department loads here first. This is a
retrieval router, not a folder list. Read [[doctrine-card]] at session startup; read
[[core-doctrine]] whole before expanding into any specific node for architecture work.

## Profile

Doctrine. This namespace carries durable concepts, principles, and decisions about the
architecture itself, so it uses the Doctrine profile (base plus `pillars/`, `concepts/`,
`decisions/`, optional `archive/`). It is the reference implementation of the full V2
base: `INDEX.md`, `canon/`, `playbooks/`, `support/`, `synthesis/`. Canon posture is
full; freshness posture is review-on-edit; it carries no `archive/`.

## Load first

Canon entry points, in order:

1. [[doctrine-card]]: the compressed startup projection of core-doctrine. Every
   non-trivial session reads this first; the root CLAUDE.md and AGENTS.md startup
   mandates it. It carries the hard rules and the drill-down pointers.
2. [[core-doctrine]]: the compressed first-principles synthesis. Read this whole before
   any architecture-touching, contract-touching, or canon-touching work. It routes you to
   the deeper node, and it wins over the card on any conflict.
3. [[system-overview]]: the single read-this-first map of the whole OS, the entity types,
   and how the system is oriented and navigated.
4. [[problem-to-architecture]]: the operator procedure for turning an unstructured problem
   or business workflow into an implementable AI-architecture-shaped system.
5. [[department-model]]: the compressed doctrine for AI shadow departments and the thin
   human layer.
6. [[agent-load-order]]: the load-order controller. Tells you what to read next by query
   class.
7. [[canon/README]]: what canon means in this namespace and how it is updated.

Top files after canon:

- [[infinite-brain-control-model]]: the foundational pillar. Where truth lives and what
  owns runtime state.
- [[ai-shadow-departments]]: why company-level ROI comes from department-sized AI-first
  redesign, not isolated tool gains.
- `autonomy-architecture-gap-register`: the highest-signal map of what is still missing
  around fleet safety, identity, accountability, and lifecycle.
- [[retrieval-over-raw-memory]]: why retrieval, not memory, is the operating layer, and
  who the consumer is.
- [[profile-aware-knowledge-graph-design]]: one ontology, eight profiles, shared base.
- [[knowledge-graph-namespace-first-topology]]: namespace-first physical layout.

## Query classes

- **Session startup orientation** (what must an agent know before any work in this
  repo): load [[doctrine-card]], then `_system/retrieval-routing-map.md` when the task
  touches a knowledge domain, then drill down per the card's pointers.
- **System overview** (what is the whole OS, the entity types, how it is navigated): load
  [[system-overview]].
- **Problem to architecture** (how to turn an unstructured problem or business workflow
  into the OS): load [[problem-to-architecture]] and [[system-overview]].
- **Department architecture** (how to turn a business function into an AI-first department,
  where departments live, what a department must contain, and how intake-operations hands
  structural opportunities to infinite-brain-ops): load [[department-model]],
  [[department-assembly-model]], [[ai-shadow-departments]],
  [[translate-business-function-into-ai-shadow-department]], [[department-onboarding-guide]] (read
  first when standing up a new department: the sequence and the alignment checklist), and
  [[department-operating-guide]] (how a department runs day to day with the wager ledger and its slice
  of the board).
- **Department charter design** (how a department defines its north star, owned outcomes,
  goals, and KPIs): load [[department-model]], [[system-overview]], and
  `_system/department-charter-rules.md`.
- **Shared platform department design** (when a capability like GitHub, CI/CD, deployment,
  secrets, or observability should live in one cross-cutting department instead of being
  duplicated in every domain department): load [[department-model]], [[system-overview]],
  [[translate-business-function-into-ai-shadow-department]], and
  `_system/department-assembly-rules.md`.
- **Entity-type design** (how to build or choose entity type X): load [[system-overview]],
  then the relevant file in `canon/entities/`: [[skills]], [[agents]], [[commands]],
  [[rules]], [[workflows]], [[deterministic-workflows]], [[workflow-loops]],
  [[knowledge-namespaces]], [[knowledge-nodes]], [[data-nodes]], [[memory-nodes]],
  [[output-nodes]], [[projects]], [[tools]], [[metrics]].
- **Outputs and placement** (what an Output is, what belongs in `outputs/`, and how outputs
  promote into memory, synthesis, canon, or planning truth): load [[outputs]],
  [[entity-output-nodes]], `outputs/README.md`, and `_system/outputs-placement-rules.md`.
- **Control model** (where does truth live, what owns runtime state, what is a surface):
  load [[infinite-brain-control-model]], [[surface-boundary]], [[surface-classes]],
  [[planning-to-execution-ladder]], [[deterministic-workflow-boundary]].
- **App composition and primitive selection** (how a real application becomes OS primitives with a
  thin surface, self-hosted by the agent runtime, and when to use a tool versus a workflow versus a
  surface versus an agent or skill): load [[apps-decompose-into-primitives]],
  [[choosing-the-right-primitive]], [[surface-classes]], [[entity-tools]], and
  `_system/primitive-selection-rules.md`.
- **Loop architecture** (when a recurring feedback system deserves explicit design, how it
  stays safe, and why it is not a new entity): load [[autonomous-improvement-loops]],
  [[deterministic-workflow-boundary]], [[standing-runtime-failure-posture]],
  [[planning-to-execution-ladder]].
- **Feedback, prediction, and the wager ledger** (how the brain books its work as a scientific
  process, the three-table ledger, the git-versus-Postgres boundary, the bookkeeping-layer-for-AI-
  harnesses thesis, and the scientist agent): load [[wager-ledger-and-scientific-loop]],
  [[feedback-plane-act-to-orient-loop]], and the operative contract `_system/wager-ledger-rules.md`.
- **Operating control additions** (what the recent management-system analysis contributed
  and what to build around autonomy first): load [[core-doctrine]],
  `autonomy-readiness-requirements`, `autonomy-architecture-gap-register`,
  `operator-priority-and-surfacing-model`, `autonomy-operating-model`, and
  `department-head-runtime`.
- **Scorecard, cadence, and accountability** (what operating loop the OS still needs above
  sessions and swarms): load [[core-doctrine]], `autonomy-readiness-requirements`,
  `operator-priority-and-surfacing-model`, `human-interaction-membrane`, and
  `department-head-runtime`.
- **Retrieval and canon design** (how is the graph read, what is canon, what is
  synthesis): load [[retrieval-over-raw-memory]], [[canon-layer]], [[what-canon-means]],
  [[internal-index-vs-public-llm-index]].
- **Runtime versus canon boundary** (what stays in git, what stays in the app): load
  [[surface-boundary]], [[intake-fabric-namespace]], [[deterministic-workflow-boundary]].
- **Operator review surfaces** (how executive review briefs, HTML review pages, and async human
  acceptance should work): load `executive-review-brief-surface`, `department-head-runtime`,
  `human-interaction-membrane`, `operator-priority-and-surfacing-model`, and
  [[surface-boundary]].
- **Session runtime and transcript capture** (how AI chats are registered, logged, and
  promoted): load [[session-ledger-root-layer]], [[open-and-close-ai-session]],
  [[implement-session-usage-capture]], [[session-transcript-posture]], [[surface-boundary]].
- **Tool-registry design** (what belongs in `tools/`, what belongs in a tool-contract or
  data-system namespace, and how departments reference execution dependencies): load
  [[system-overview]], [[department-model]], [[profile-aware-knowledge-graph-design]], and
  `_system/tool-registry-rules.md`.
- **Secrets architecture** (how secret references live in git, who owns them, how tools and
  surfaces bind them, and how future namespaces should depend on credentialed systems safely):
  load [[secret-reference-model]], [[surface-boundary]], [[deterministic-workflow-boundary]],
  `_system/secret-registry-rules.md`, and `secrets/README.md`.
- **Repo-registry design** (what belongs in the client workspace, how repos map to departments,
  and how cross-repo digestion or migration should stay explicit): load [[system-overview]],
  [[department-model]], `_system/repo-registry-rules.md`, and `repo-registry/README.md`.
- **Repo topology and brain hierarchy** (when does a department or the individual layer
  deserve its own repo, how do the individual, department, and company brain tiers compose,
  and how does a brain repo differ from a non-brain app repo): load
  [[reflexive-brain-topology]], [[department-graduates-to-repo-on-trust-boundary]],
  [[graduate-a-department-to-its-own-brain-repo]], and `_system/repo-registry-rules.md`.
- **Multi-brain parent workspace** (how one person works across several brains at once: a
  `.claude/` router over a `brains/` folder mounting a shared brain plus an individual brain,
  a `/start` bootstrap, a governed `/sync` with proposal-branch routing, the runtime copy-up,
  and the brain-selection index): load [[stand-up-a-multi-brain-parent-workspace]],
  [[reflexive-brain-topology]], and `_system/multi-brain-workspace-contract.md`.
- **System versus doctrine layering** (where the operative contract lives versus where the
  reasoning lives, when to read `_system/` versus this namespace): load
  [[system-vs-doctrine-boundary]], then `_system/README.md`.
- **Swarm governance** (how a swarm is launched and closed out): load
  [[swarm-launch-governance]], [[planning-to-execution-ladder]].
- **PM-agent routing** (how work is routed across modes, what the PM-agent may do): load
  [[pm-agent-posture]], [[swarm-launch-governance]].
- **Profile and namespace design** (how a namespace is shaped, which profile fits, how
  to upgrade or audit one): load [[profile-aware-knowledge-graph-design]],
  [[namespace-profiles]], [[namespace-profile-set-v1]], [[required-namespace-surfaces]],
  [[knowledge-graph-namespace-first-topology]], [[upgrade-a-namespace-to-v2]],
  [[review-namespace-health]].

## Stable vs stateful

Stable doctrine (durable, changes only on real architectural revision): the control
model, the planning ladder, the surface boundary, the namespace-first topology, the canon
contract, the profile set, retrieval over raw memory, the AI shadow department thesis, the
department assembly model, correction to structure, harness portability, output linkage, the
metric primitive, and public-export posture. These carry `review-on-edit` freshness:
revisit only when an edit touches them or a decision supersedes them. Requirements for
capability the system does not yet run belong in `synthesis/`, never in canon.

Stateful or evolving (needs periodic review): the PM-agent readiness posture (tracks
trial maturity and may change as the agent matures), the Provisional profile schemas
(must be validated against the first real namespace of each type), a namespace gap map
in `synthesis/` (create one as your namespaces upgrade). This namespace has no
live-but-canonical facts, so it carries no `canon/current-truth.md`.

## Open disputes

Contested or unvalidated questions are tracked in `synthesis/`, never in canon:

- Whether any Provisional profile collapses into another (Design System and Component
  Library; or Tool Contract, Data System, and Operating Library).
- Which namespaces still lack the V2 base and in what order they upgrade.
- Whether a future MCP or RAG retriever is planned and how the retrieval policy should
  name it (contract assumption A-01): tracked in `x-research-lessons` alongside the
  retrieval-over-raw-memory lessons.
- Whether the public-starter export, the client-department release, and an internal
  department or individual graduation should collapse into one manifest-driven exporter
  with per-consumer profiles, rather than staying three separately maintained scripts:
  named as the target state in [[reflexive-brain-topology]], not yet built.
- The exact implementation sequence for fleet-level autonomy governance, kill switch,
  identity, accountability, and lifecycle hardening: tracked in
  `autonomy-architecture-gap-register`, with the requirement-level statement and status in
  `autonomy-readiness-requirements`.

## What this namespace drives

This canon should improve:

- the namespace builders and curators (`build-namespace`, `build-knowledge-node`,
  `canonize-a-namespace`, `process-namespace-intake`)
- the deterministic validator rules in `_system/validate.sh` and the profile lint rules
- the swarm launch governance contract and the PM-agent routing model
- the root intake scaffold and its migration plans
- the root session scaffold, session start and closeout discipline, and session-to-memory
  promotion path
- the intake-operations to infinite-brain-ops handoff and PKM-opportunity trail
- the department assembly layer and future head-of-department agents
- the operating scorecard, weekly review cadence, and consolidated issue discipline over the
  whole operation
- fleet-level safety controls: cost caps, concurrency caps, kill switch, identity, and
  receipts
- accountability and cost pacing for recurring agent-owned functions
- the standalone shared platform department pattern, including `devops-platform`
- the reusable department-builder skill, command, and workflow path
- the department-charter requirement and KPI-driven department reporting posture
- the root `tools/` registry and department tool mapping
- the root `secrets/` registry and runtime credential-binding posture
- the root `repo-registry/` and department repo mapping
- the `repo_kind` and `brain_tier` classification and the department-to-repo graduation trigger
- the V2 upgrade plans and audit packets for every other namespace
- the public `llms.txt` export generator, downstream of canon

If a piece of doctrine here drives none of these, question whether it belongs.

## Archive and provenance

This namespace carries no `archive/` (no migrated full-source corpus lives here). Use
`support/` for provenance and migration only. The starter ships it empty; provenance
accumulates as you migrate your own corpus.

Derived thinking does not live in `support/`. It lives in `synthesis/`. Do not put
synthesis in `support/`; do not put migration receipts in `synthesis/`.

## Common misreadings

- Treating canon as a copy of `pillars/`. Canon synthesizes and compresses across the
  graph; it does not paraphrase nodes. If canon and a pillar say the same thing at the
  same length, canon is wrong.
- Looking here for tool, data, design, content, or operating knowledge. This namespace
  holds the architecture for how those namespaces are built, not their content. Route to
  the relevant profile namespace or its `_examples` scaffold.
- Treating departments as a brand-new low-level entity type. Departments are operating
  assemblies over the ontology, not replacements for skills, agents, workflows, or
  namespaces.
- Treating repos as if they are departments, tools, or namespaces. A repo is a container and
  execution boundary; its job, ownership, and migration posture should be explicit in the root
  client workspace.
- Putting open questions in canon. Disputes live in `synthesis/`. Canon states settled
  doctrine.
- Reading the surface boundary as anti-tooling. It is pro-tooling with a contract: many
  adapters are welcome, none may become a second source of truth.
- Assuming intake owns truth. Intake captures and routes; the destination namespace owns
  the durable canon. Intake never owns truth.
- Assuming intake and PKM stewardship are the same department. Intake operations owns
  capture, receipts, and routing suggestions; infinite-brain-ops owns the structural
  decision about what the brain should become.

## Map

```text
knowledge/ai-architecture/
  INDEX.md                       # this retrieval router
  canon/
    README.md                    # what canon means here (navigational)
    core-doctrine.md             # the keystone synthesis (knowledge node)
    doctrine-card.md             # compressed startup projection of core-doctrine (knowledge node)
    agent-load-order.md          # load order by query class (navigational)
    system-overview.md           # the single map of the whole OS (knowledge node)
    problem-to-architecture.md   # turn an unstructured problem into the OS (knowledge node)
    department-model.md          # the AI shadow department doctrine (knowledge node)
    entities/                    # one canon file per entity type (knowledge nodes)
      skills.md
      agents.md
      commands.md
      rules.md
      workflows.md
      deterministic-workflows.md
      workflow-loops.md
      knowledge-namespaces.md
      knowledge-nodes.md
      data-nodes.md
      memory-nodes.md
      output-nodes.md
      projects.md
      tools.md
      metrics.md
  pillars/
    ai-shadow-departments-over-ai-toolbar-gains.md
    infinite-brain-control-model.md
    infinite-brain-namespace-architecture-v2.md
    retrieval-over-raw-memory.md
    profile-aware-knowledge-graph-design.md
    apps-decompose-into-primitives.md
    reflexive-brain-topology.md
  concepts/
    choosing-the-right-primitive.md
    planning-to-execution-ladder.md
    department-assembly-model.md
    surface-boundary.md
    surface-classes.md
    deterministic-workflow-boundary.md
    autonomous-improvement-loops.md
    canon-layer.md
    what-canon-means.md
    namespace-profiles.md
    internal-index-vs-public-llm-index.md
    correction-loop-absorption.md
    namespace-linting.md
    intake-fabric-namespace.md
    metric-primitive.md
    system-vs-doctrine-boundary.md
  decisions/
    knowledge-graph-namespace-first-topology.md
    pm-agent-posture.md
    paperclip-boundary.md
    standing-runtime-posture.md
    standing-runtime-failure-posture.md
    namespace-profile-set-v1.md
    required-namespace-surfaces.md
    public-llm-index-export-posture.md
    wager-ledger-and-scientific-loop.md
  playbooks/
    translate-business-function-into-ai-shadow-department.md
    build-out-a-department.md
    department-operations-readiness.md
    department-operating-guide.md
    department-onboarding-guide.md
    swarm-launch-governance.md
    swarm-sprint-pattern-selection.md
    pm-agent-routing-heuristics.md
    secret-reference-model.md
    canonize-a-namespace.md
    upgrade-a-namespace-to-v2.md
    review-namespace-health.md
    process-namespace-intake.md
    stand-up-a-multi-brain-parent-workspace.md
  synthesis/                     # ships with the OODA orientation set; grow yours here
    boyd-to-agent-architecture-ooda-map.md
    ooda-architecture-index.md
    feedback-plane-act-to-orient-loop.md
  support/                       # ships empty; provenance only
```

The operative registry entry for this namespace lives at
`_system/namespaces/ai-architecture.md`. That file owns the "what" and "how to check";
this namespace owns the "why."
