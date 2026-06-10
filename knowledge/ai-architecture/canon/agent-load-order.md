# Agent Load Order: ai-architecture

This file is the load-order controller for the `ai-architecture` namespace. It tells a
retrieving agent what to read first and in what order, by query class. It is navigational:
it carries no knowledge-node frontmatter and is exempt from node-frontmatter checks in
`validate.sh`.

The retrieval consumer this is written for is a Claude Code or Codex file-reading agent
that retrieves by grep and read against the working tree. Load only what the query needs.
The right small set of nodes beats loading the whole namespace.

## The rule

Session startup is governed by [[doctrine-card]], the compressed projection of
core-doctrine that every non-trivial session reads first per the root CLAUDE.md and
AGENTS.md. The card routes; this file sequences the deeper canon read once the question
is an architecture question.

For any architecture question, load in this order:

1. [[core-doctrine]] first, always. It is the compressed first-principles synthesis. Read
   it whole before expanding. It will tell you which deeper node the question needs.
2. The relevant pillar, concept, or decision for the specific question, chosen from the
   query-class table below.
3. The playbook or synthesis node only when the question is about a procedure or a live
   dispute.
4. `support/` only when the question is about provenance, migration, or how a file moved.

Stop loading once the question is answered. Do not pull the whole graph.

## Ordered default load

If you do not yet know the query class, load this default set and let it route you:

1. [[doctrine-card]] if it has not already been read at session startup
2. [[core-doctrine]] (canon keystone)
3. The namespace `INDEX.md` (the retrieval router and query-class map)
4. [[infinite-brain-control-model]] (the foundational pillar)

From there the `INDEX.md` query classes and the table below point you to the rest.

## Orientation reads

When the question is "what is the whole system" or "how do I turn a problem into the OS,"
load the orientation canon before the deeper graph:

- **System overview**: load [[system-overview]] after [[core-doctrine]]. It is the single
  map of every entity type and the four orienting disciplines (INDEX-and-canon-first load
  order, the `_system`-versus-doctrine split, the surface boundary, the planning ladder).
- **Department model**: load [[department-model]] after [[core-doctrine]] when the question
  is about AI shadow departments, department heads, thin human layers, department rollups,
  or the split between intake-operations and infinite-brain-ops.
- **Problem to architecture**: load [[problem-to-architecture]] (and [[system-overview]])
  when converting an unstructured problem or business workflow into an implementable
  AI-architecture-shaped system. It is the operator procedure.

## Query class to files

| Query class | Load after core-doctrine |
|-------------|--------------------------|
| System overview: what is the whole OS and how is it navigated | [[system-overview]] |
| Department architecture: how do I design an AI-first shadow department from a business function | [[department-model]], [[department-assembly-model]], [[ai-shadow-departments]], [[translate-business-function-into-ai-shadow-department]] |
| Department charter design: what should a department optimize for and how should it measure success | [[department-model]], [[system-overview]], `_system/department-charter-rules.md` |
| Department stewardship: how should intake-operations and infinite-brain-ops hand work to each other | [[department-model]], [[system-overview]], `workflows/intake-to-brain-ops-handoff.md`, `_system/department-assembly-rules.md` |
| Shared platform department design: should GitHub and CI/CD be per-department or centralized | [[department-model]], [[system-overview]], [[translate-business-function-into-ai-shadow-department]], `_system/department-assembly-rules.md` |
| Problem to architecture: how do I turn an unstructured problem or business workflow into the OS | [[problem-to-architecture]], [[system-overview]] |
| Entity-type design: how do I build or choose entity type X | [[system-overview]], then the relevant file in `canon/entities/` ([[skills]], [[agents]], [[commands]], [[rules]], [[workflows]], [[deterministic-workflows]], [[workflow-loops]], [[knowledge-namespaces]], [[knowledge-nodes]], [[data-nodes]], [[memory-nodes]], [[output-nodes]], [[projects]], [[tools]], [[metrics]]) |
| Control model: where does truth live, what owns runtime state, what is a surface | [[infinite-brain-control-model]], [[surface-boundary]], [[planning-to-execution-ladder]], [[deterministic-workflow-boundary]] |
| Operating control additions: what the recent management-system analysis contributed and what to build around autonomy first | `autonomy-readiness-requirements`, `autonomy-architecture-gap-register`, `autonomy-operating-model`, `department-head-runtime`, `operator-priority-and-surfacing-model` |
| Scorecard, cadence, and accountability: what operating loop the OS still needs above sessions and swarms | `autonomy-readiness-requirements`, `autonomy-architecture-gap-register`, `department-head-runtime`, `human-interaction-membrane`, `operator-priority-and-surfacing-model` |
| Retrieval and canon design: how is the graph read, what is canon, what is synthesis | [[retrieval-over-raw-memory]], [[canon-layer]], [[what-canon-means]], [[internal-index-vs-public-llm-index]] |
| Runtime versus canon boundary: what stays in git, what stays in the app | [[surface-boundary]], [[intake-fabric-namespace]], [[deterministic-workflow-boundary]] |
| Session runtime and transcript capture: how chats are registered, logged, and closed out | [[session-ledger-root-layer]], [[open-and-close-ai-session]], [[session-transcript-posture]], [[surface-boundary]] |
| Swarm governance: how is a swarm launched and closed out | [[swarm-launch-governance]], [[planning-to-execution-ladder]] |
| PM-agent routing: how is work routed across modes, what may the PM-agent do | [[pm-agent-posture]], [[swarm-launch-governance]] |
| Profile and namespace design: how is a namespace shaped, which profile fits | [[profile-aware-knowledge-graph-design]], [[namespace-profiles]], [[namespace-profile-set-v1]], [[required-namespace-surfaces]], [[knowledge-graph-namespace-first-topology]] |
| Intake design: how does inbound flow into the brain | [[intake-fabric-namespace]], [[correction-loop-absorption]] |
| Tool-registry design: how do tools become explicit execution dependencies and where do they live | [[system-overview]], [[department-model]], `_system/tool-registry-rules.md` |
| Metric design: how do numbers stay coherent across namespaces | [[metric-primitive]] |
| Public export: what faces outward and how | [[internal-index-vs-public-llm-index]], [[public-llm-index-export-posture]] |
| Correction and learning: how does repeated correction become structure | [[correction-loop-absorption]] |
| Namespace upgrade or audit: how is a namespace moved to V2 or its health checked | [[upgrade-a-namespace-to-v2]], [[review-namespace-health]], `namespace-audit-wave-order` |

## Notes

- When a question spans classes, load [[core-doctrine]] plus the two or three nodes from
  each relevant row, not every node listed.
- Live disputes route to `synthesis/` (see the `INDEX.md` "Open disputes" section), not
  to canon.
- Provenance and migration questions route to `support/`, not to the doctrine nodes.
- If the query is about a tool API contract, a data pipeline, a design system, a content
  angle, or a recurring operating procedure, this namespace is not the home. It holds the
  architecture doctrine for how those namespaces are built. Route to the relevant profile
  namespace or its `_examples` scaffold.
