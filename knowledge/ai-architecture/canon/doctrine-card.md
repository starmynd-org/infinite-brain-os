---
id: "knowledge-ai-architecture-canon-doctrine-card"
aliases: ["knowledge-ai-architecture-canon-doctrine-card", "ai-architecture-doctrine-card", "doctrine-card"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Compressed operating projection of core-doctrine for session startup: what the brain is, the control spine, the hard rules an agent must never violate, the eleven entity types with locations, and drill-down pointers. Re-verified whenever core-doctrine changes; core-doctrine wins on any conflict."
confidence: 0.9
retrieval_class: "identity"
export_class: "internal"
projection_of: "knowledge-ai-architecture-canon-core-doctrine"
verified_at: "2026-06-10"
verified_by: "the-operator"
edges:
  - target: "[[core-doctrine]]"
    relation: "derived_from"
    confidence: 0.95
  - target: "[[system-overview]]"
    relation: "references"
    confidence: 0.85
created: "2026-06-10"
---

## What this card is

This card is a compressed operating projection of [[core-doctrine]], built so a session
can start with one short read instead of a 13k-word scan. It is not a second doctrine.
When core-doctrine changes, this card must be re-verified against it, and on any conflict
core-doctrine wins. Read this card first in every non-trivial session; drill down per the
pointers at the bottom when the task class demands it.

## What the brain is

The Infinite Brain is a git-backed knowledge operating system whose job is to make a
corpus of knowledge, decisions, and procedures reliably retrievable and safely executable
by AI agents, today and after the tools change. Its business aim is to make whole
functions operable as AI-first shadow departments with a thin human layer that keeps
goals, approvals, and hard exceptions.

## The control spine

**The planning ladder.** All work anchors to one canonical ladder: `initiative`, then
`project`, then `task`. Specialized execution layers (workflow definition, run, swarm
sprint, wave) hang off the parent task without changing the ontology. A sprint is never a
canonical project, sprint folders are never a second backlog, and no cockpit surface may
redefine the ladder. Swarm launch needs a structurally valid parent task with
`mode: swarm`, plus a file-backed, human-granted approval receipt.

**The three-plane truth split.** Git-backed canon holds intent, doctrine, rules,
workflows, and durable summaries: the source of truth for what is known and decided.
Operational state (live tasks, queues, in-flight approvals, runs, swarm fanout) stays in
the runtime substrate that owns it; it is mutable and never authoritative about meaning.
Analytical history (telemetry, throughput, trends) is numbers, not doctrine. Live queue
state never enters git.

**The surface boundary.** Every adapter (Obsidian, Claude Code, Codex, n8n, Paperclip,
sprint folders) is a surface. A surface declares what it reads, what state it may own,
and what write paths it uses. A surface may own session state, queue and review state,
and drafts with a writeback path. A surface may never become the only durable home of
approved knowledge, hide canonical semantics in a private runtime schema, or mutate canon
without a visible promotion event.

**Canon versus synthesis.** Each serious namespace carries `canon/`: the compressed,
operator-approved, provenance-bearing synthesis an agent loads first. Canon describes the
system as it runs, carries `derived_from` edges, `verified_at` and `verified_by`, and a
`## Changelog`. `synthesis/` holds derived thinking, open disputes, and requirements for
unbuilt capability; `support/` holds provenance only. The promotion path is strict: raw
source to `support/`, to `synthesis/`, to canon-candidate, to canon on operator approval.
Knowledge is namespace-first: the unit is `knowledge/<namespace>/`, every serious
namespace shares one base (`INDEX.md`, `canon/`, `playbooks/`, `support/`, `synthesis/`),
and one of eight profiles adds folders without forking the ontology. Retrieval is
designed for the real consumer: a file-reading agent using grep and read over the working
tree, loading the minimal sufficient set by query class, never the whole graph.

## Hard rules an agent must never violate

1. **Session discipline.** Any task that creates, edits, moves, or deletes a file is
   non-trivial. Register the session under `sessions/active/` before substantive work,
   declare a transcript path under `sessions/logs/`, keep running notes, write a closeout
   review under `sessions/reviews/`, and move the record to `sessions/closed/`. If a
   session operates inside a swarm sprint, dual-write: `sessions/` for the conversation
   trail, an internal build record (not shipped) for execution artifacts and receipts.
2. **No self-approved canon.** Canon is operator-approved, always. An agent drafts at
   `verified_by: operator-pending`; the operator signs off. Every substantive canon
   revision gets a one-line dated changelog entry consistent with `verified_at` and
   `verified_by`. You never edit promoted canon directly; you build here and propose.
3. **The frontmatter contract.** Every node-bearing markdown file opens with YAML
   frontmatter carrying at minimum `id`, `type`, `namespace`, and `lifecycle_state`, with
   the id repeated in `aliases`; serious nodes add `summary`, `confidence`,
   `retrieval_class`, `export_class`, `edges`, and `created`. Ids are kebab-case and
   stable. Wikilinks must resolve.
4. **No em dashes, no en dashes.** Anywhere, in any file. Use commas, colons, or
   restructure the sentence. No placeholder text (to-be-decided markers, unfinished-work
   stubs, insert-here brackets) above `lifecycle_state: scratch`.
5. **Intake routing.** Inbound material flows through `intake/` (source record, routing
   decision, processed receipt); the destination namespace owns the truth, intake owns
   only the trail. Disposable test artifacts default to `outputs/`, never to knowledge
   surfaces. Live connectors and queues stay in the app layer.
6. **The lifecycle states.** Every entity is `scratch` (new, possibly wrong), `research`
   (validated, worth refining), `candidate` (nominated, under review), or `canon`
   (promoted, operator-approved, used by others). Promotion moves forward through review,
   never by an agent's own declaration.

## Other settled disciplines

- **Two homes for system knowledge.** `_system/` is the operative contract layer: what
  must be true and how it is checked (registry, schemas, rules, `validate.sh`).
  `knowledge/ai-architecture/` is the reasoning layer: why it is true. Neither restates
  the other; each links across. If a change alters what the validator accepts, it belongs
  in `_system/`; if it changes how someone thinks, it belongs in doctrine.
- **Correction to structure.** When the operator corrects an agent the same way twice,
  the correction is absorbed into a rule, playbook, decision, or canon revision. If you
  would otherwise type the same correction a third time, it belongs in structure.
- **Harness portability.** Truth lives in plain Markdown and YAML in git, readable by any
  file-reading agent. Claude Code and Codex are current adapters, not owners; the brain
  must survive a change of model, client, or vendor.
- **Deterministic versus agentic.** Deterministic work (n8n JSON, shell, validators) runs
  where determinism is cheap and is paired with a brain record; agentic reasoning runs
  where judgment is required. Routing across modes is visible and human-gated; the
  PM-agent recommends the lowest-cost safe mode but never holds launch authority.
- **Output linkage.** Every namespace names what outputs its canon drives. Doctrine that
  improves no real decision, project, or artifact is suspect.
- **The metric primitive.** A metric is one shared typed node keyed by `metric_id` with
  definition, lineage, and diagnosis faces, so namespaces talk about the same number.
- **Public export is a surface.** `llms.txt` is a thin public summary generated from
  canon, never from raw notes; export stays downstream of canon.
- **Operating gaps live in synthesis.** Requirements for capability the system does not
  yet run are tracked in synthesis nodes (see `autonomy-readiness-requirements`), never
  asserted in canon.

## The eleven entity types

| Entity | Canonical location | Runtime adapter |
|--------|--------------------|-----------------|
| Command | `entities/commands/` | `.claude/commands/`, `.codex/commands/` |
| Agent | `entities/agents/` | `.claude/agents/`, `.codex/agents/` |
| Skill | `entities/skills/` | `.claude/skills/`, `.codex/skills/` |
| Rule | `entities/rules/` | `.claude/rules/` (Codex reads AGENTS.md) |
| Workflow | agentic in `workflows/`, deterministic in `automations/n8n/` | none |
| Tool | `tools/` (pointer nodes over bounded capabilities) | none |
| Knowledge | `knowledge/<namespace>/` | none |
| Data | `data/` (pointers, never live numbers) | none |
| Memory | `memory/` (reviewed learnings) | none |
| Output | `outputs/` (produced artifacts with lineage) | none |
| Project | `projects/{name}/PLAN.md` | none |

Executable entities (Command, Agent, Skill, Rule) live canonically in `entities/` and are
loaded through `.claude/` and `.codex/` shims; edit the canonical file, never the shim.
Departments are assemblies over the ontology (root `departments/`), not a twelfth type.
Root registries make dependencies explicit: `tools/` for capabilities, `secrets/` for
secret references (never raw values), `repo-registry/` for cross-repo ownership,
`intake/` for inbound flow, `sessions/` for the audit trail.

## Drill down: load X when Y

- Load [[core-doctrine]] (whole) when the task is architecture work: designing or
  changing the control model, namespaces, canon, retrieval, departments, surfaces, or
  anything that alters how the brain itself works.
- Load `_system/README.md` when the task touches the operative contract: what the
  validator enforces, schema and rule files, the namespace registry, or what a builder
  must produce. Both core-doctrine and `_system/README.md` are mandatory for
  architecture-touching, contract-touching, or canon-touching tasks.
- Load `_system/retrieval-routing-map.md` when the task touches a knowledge domain and
  you need to select namespaces: it maps task classes to namespace load sequences.
- Load the namespace `INDEX.md` (then its `canon/agent-load-order.md`) for domain work
  inside a chosen namespace; the namespace owns its internal load order.
- Load [[system-overview]] when the question is what the whole OS is and how to navigate
  it; load the relevant `canon/entities/` file when building or choosing entity type X.
- Load `_system/canon-layer-schema.md` and `_system/canon-changelog-rules.md` when
  authoring or revising canon; load `_system/swarm-sprint-rules.md` when scaffolding or
  closing a sprint; load `sessions/README.md` and
  `knowledge/ai-architecture/playbooks/open-and-close-ai-session.md` for session
  mechanics beyond the hard rule above.

## Changelog

- 2026-06-10: initial card created as the startup projection of core-doctrine
  (harness-hardening program, doctrine-card-and-routing-map sprint). Operator-approved
  (the-operator) in the 2026-06-10 working session that commissioned the program.
