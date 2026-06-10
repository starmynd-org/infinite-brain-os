---
id: "knowledge-ai-architecture-build-out-a-department"
aliases: ["knowledge-ai-architecture-build-out-a-department", "build-out-a-department", "department-build-playbook", "department-build-process"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "The repeatable, Paperclip-native process for building out a department: each build is a swarm-executed project that mines existing repos for candidate components, defines recurring tasks and intake-to-process-types, names the projects the department will own, then assembles the git definition and projects it into the Paperclip runtime. Reuses the integration contracts proven by the 2026-06-03 autonomy pilot so each build never re-proves the runtime."
confidence: 0.85
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[translate-business-function-into-ai-shadow-department]]"
    relation: "extends"
    confidence: 0.92
  - target: "[[build-department]]"
    relation: "uses"
    confidence: 0.9
  - target: "[[department-model]]"
    relation: "derived_from"
    confidence: 0.9
created: "2026-06-03"
---

# Build Out a Department

## When to use

Use this when turning a business function into a live AI-first department, after the autonomy
architecture has been proven on Paperclip. It is the end-to-end process. It wraps
`translate-business-function-into-ai-shadow-department` (the framing) and the `build-department`
workflow (the assembly mechanics), and adds the repo-mining sweep, the intake-to-process-type
maturation, and the projection into the Paperclip runtime.

## Three artifacts, do not conflate them

A department is three things, produced in one build:

1. The **build project**: `projects/<dept>-buildout/PLAN.md`, a temporary swarm-executed project that
   produces the department. This is why each department build is a project on the planning ladder
   (initiative then project then task). It runs as a sprint and reuses the locked Paperclip
   integration contracts, so it never re-proves the runtime.
2. The **department definition** (durable, the brain): `departments/<dept>/INDEX.md` plus `CHARTER.md`,
   plus its namespaces and entities.
3. The **department runtime** (the body, Paperclip): an org-chart branch in the company, its agents,
   routines, budget, and issues.

The build project produces artifacts 2 and 3. Once live, the department then owns ongoing projects,
listed in its INDEX.

## Reuse: what the pilot already proved

The 2026-06-03 autonomy pilot (an internal build record (not shipped)) proved the
Paperclip runtime and locked five integration contracts: the git-to-Paperclip projection, the
Paperclip-to-git receipt writeback, the governance-to-approval-gates mapping, the cost-cap-to-budget
mapping, and the agent contract. Every department build reuses these. The build is therefore mostly
mine, define, project, and wire, not runtime engineering.

## Build versus activation: the two-stage split

A department build has a hard ceiling: the durable artifacts an agent can author without the operator's
real values and without a live runtime. Past that ceiling sit steps that need one of three things: the
operator's real values (which an agent must never invent), the operator in a human-confirm or review
loop, or the live Paperclip runtime. Do not stall the build waiting on these, and do not stub them.

Split the work into two stages, each a project on the planning ladder:

- **Build** (`projects/<dept>-buildout/PLAN.md`): produce every durable artifact to the
  durable-artifact ceiling: the definition, the namespaces and entities, the workflows and tools, the
  Data-node pointers, the locked contracts. Validator delta-zero. This is the agent-completable stage.
- **Activate** (`projects/<dept>-activation/PLAN.md`): the tail that crosses the human or runtime
  boundary: fill the operator-specific values, run the live human-in-the-loop steps, project into
  Paperclip via the locked contracts, and run the L1 pilot. This stage is gated on the operator and the
  runtime.

Proven in the deployment this starter derives from: building to the ceiling then activating separately keeps
the build moving and keeps the agent from inventing operator values. Name both projects up front so the
deferred tail has a home from day one rather than being discovered at the end.

## The phases

### Phase 0: Frame the function

Run `translate-business-function-into-ai-shadow-department`. Output: a draft `CHARTER.md` (mission,
north star, owned outcomes, KPIs, constraints, human-review gates) and an `INDEX.md` skeleton. Start
from the function, not the tools.

Before leaving Phase 0, decide the department's data posture:

- does it consume a shared Example Co-backed Data System
- does it need its own Data System namespace
- or does it declare provisional KPIs with explicit `not-wired` status

Do not let KPIs exist without one of those three answers.

### Phase 1: Mine existing repos and logic for candidate components

The discovery sweep, and the one phase that is a genuine multi-agent fan-out (one agent per repo or
per entity-lens, structured output, then dedup and classify). For the department's domain, sweep the
relevant repos and pull candidates, each tagged keep, adapt, defer, or leave-external:

| Entity type | Mine for |
|---|---|
| Skills | reusable techniques already in use in the domain |
| Agents | existing agent prompts, roles, personas |
| Workflows | agentic pipelines, and deterministic ones (n8n flows, scripts) |
| Knowledge and namespaces | domain knowledge to digest into namespaces, and which profile each fits |
| Custom tools, tools, tool-call namespaces | in-house repo-native capabilities, external integrations and MCP servers, and the deep API contracts (the tool-contract namespaces, like `paperclip-tool-contract` and `github-tool-contract`) |
| Surfaces | existing UIs, dashboards, cockpits, mapped to the S1 to S5 surface classes |
| Projects and tasks | existing backlogs, TODOs, open work |
| Secrets | credential needs, mapped to secret-reference entries with an owner |

Output: a classified candidate registry per entity type. The keep, adapt, defer decisions are an
operator gate.

### Phase 2: Recurring tasks (the clock inputs)

Define the standing work: the mandatory daily update and rollup, plus monitors, freshness reviews,
and reports. Each becomes a Paperclip routine (cron) paired with a brain workflow record. Output: the
recurring-task list to instantiate as routines.

### Phase 3: Intake types and the AI architecture to handle them (the event inputs)

Enumerate what flows into the department (tickets, requests, signals, data drops, messages,
research). For each intake type, design the handling: triage, route to which entity, and the
human-review posture. Mature each recurring intake type into a process-type, a versioned workflow
plus a trigger rule, that starts in shadow mode and graduates to auto-handle, referencing a
cross-department namespace where the handling is shared. This is how the department gets more
autonomous over time. Output: an intake catalog and the process-types to build.

For quantitative event inputs such as exports, dashboards, reports, and mapping sheets, also
decide whether the signal lands as:

- a Data System source contract
- a Data node pointer to a sheet, dashboard, or report
- or a temporary manual input awaiting connector work

The intake design and the data design should agree.

### Phase 4: Projects to add (now versus future)

From the mined backlog and the gaps, define the projects the department will own and drive,
sequenced now versus later. Output: the department's owned-project list in its INDEX.

### Assemble and wire

Build the INDEX, CHARTER, and head agent (the `build-department` workflow does the assembly
mechanics). Digest the kept knowledge into namespaces. Project the definition into Paperclip using
the locked contracts: an org-chart branch, the head and worker agents (scoped keys, budgets), the
routines, and the budget. Wire the chief-of-staff membrane for human-bound items. Set the governance
(approval gates and budget). Keep planning truth in git; Paperclip owns runtime state.

### Pilot and climb

Run the department at L1 to L2, then climb the maturity ladder per the proven pattern, each climb
gated by a clean run.

## Human gates

- the CHARTER is accepted
- the keep, adapt, defer decisions on the candidate registry
- namespace-digestion-to-canon approval (canon is operator-approved, never self-approved)
- go-live at L1
- each ladder climb

## Per-department acceptance gate

Built does not equal working. Before a department is called done, run an explicit acceptance gate (not
just `validate.sh`, which checks graph structure, not function). Four checks, with a written gap list as
the deliverable:

1. **Architecture conformance**: review against `department-model`, `_system/department-runtime-contract.md`,
   `surface-boundary`, and `decisions/paperclip-boundary.md`. Confirm the required surfaces, the explicit
   runtime mapping, pure-pointer data nodes, and no live state, raw data, or secrets in git.
2. **End-to-end function**: a real intake item flows through (for a domain department, a real ticket; for
   chief-of-staff, a real human-bound item routed and a real confirmed work product), not just specs that
   pass the linter.
3. **Runs on Paperclip at L1**: project the definition via the locked Contract A bridge and confirm it
   renders (company or org-chart branch, head agent, project, issues). The reference validation did
   this with `company import` plus a live board screenshot.
4. **Written built-but-not-working gap list**: anything that exists as an artifact but has never run.

Run this gate per department as an in-line quality check (push it close to the build, not a late batch
sweep), and run a cross-department integration test once several departments share a contract. The
chief-of-staff is the shared membrane every department routes through, so prove it working at L1 before
others wire into it.

## Success test

The department is real when intake hits AI first, the head agent routes most work without human
triage, it produces a daily update without status chasing, human effort shifts to review and
exceptions, and company-level value is visible. The build is done when the definition is in git, the
runtime is live in Paperclip, and the department owns its forward projects.

## Builder gotchas (learned from the chief-of-staff build, do not rediscover)

- **Validator orphans**: the orphan check counts a node as having outbound edges only for the unquoted
  `target: [[` frontmatter form, and the inbound `referenced` set is built from wikilinks in `knowledge/`
  files only. A knowledge node referenced only by an entity, workflow, or quoted edge can still be flagged
  orphan. Reference new knowledge nodes from a `knowledge/` file (the namespace INDEX) to clear it.
- **Link-resolver scope**: the resolver indexes `knowledge/`, `_system/`, `entities/`, `workflows/`,
  `intake/` only. `data/` and `departments/` are outside it, so never use a double-bracket wikilink to a
  data or department node from a knowledge node (broken-link warning); use backtick prose or a full
  repo-relative path.
- **Department file references**: from `departments/`, never use bare relative paths to shared doctrine
  (`decisions/paperclip-boundary.md`); use the full path `knowledge/ai-architecture/decisions/...` or a
  wikilink by id.
- **BigQuery DDL**: this BigQuery rejects column-level `DEFAULT CURRENT_TIMESTAMP()`; set such values in
  the loader instead.
- **Namespace graduation**: a domain namespace that starts reduced-base graduates by setting
  `reduced_base: true` to false (or removing it) in its registry entry, not by editing `validate.sh`.
- **Charter type**: a `CHARTER.md` carries `type: "Charter"` and `id: "department-<slug>-charter"`.
- **Paperclip CLI on this machine**: run via the WSL node and the WSL npx cache
  (`npx --offline paperclipai@<version> ...`); `company delete` needs `--yes --confirm <PREFIX>`.

## Edges

- `extends` `[[translate-business-function-into-ai-shadow-department]]`: that playbook is Phase 0.
- `uses` `[[build-department]]`: the assembly mechanics for the INDEX, CHARTER, and head agent.
- `derived_from` `[[department-model]]`: the AI shadow department doctrine.
- `depends_on` ``department-head-runtime``: the head and governance design.
- `depends_on` ``knowledge-paperclip-tool-contract-canon-core-contract``: the runtime the
  department projects into.

## Notes

Pair Phase 1 with a mining workflow that fans out across the relevant repos. The mining is the only
phase that needs orchestration; the rest is design and assembly. The intake-to-process-type and
priority-and-surfacing detail live in `knowledge/ai-architecture/synthesis/operator-priority-and-surfacing-model.md`
and the human side in `synthesis/human-interaction-membrane.md`.
