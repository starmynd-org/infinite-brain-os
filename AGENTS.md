# Infinite Brain OS, Working Repo (Codex)

This repo is the operating system for running a business with AI agents. You have full
write autonomy here. Codex does the heavy lifting; this file orients it.

If the task touches architecture, routing, knowledge structure, sessions, swarms, or
planning, orient from this file and the doctrine first.

---

## Forced startup for every non-trivial chat

For every non-trivial session that reads or writes repo state, do this before substantive
work:

1. Read `knowledge/ai-architecture/canon/doctrine-card.md`. It is the compressed operating
   projection of core-doctrine: the hard rules, the control spine, the entity types, and
   the drill-down pointers.
2. If the task touches a knowledge domain, read `_system/retrieval-routing-map.md` and load
   the namespaces it routes to, entering each through its `INDEX.md`.
3. For architecture-touching, contract-touching, or canon-touching work,
   `knowledge/ai-architecture/canon/core-doctrine.md` and `_system/README.md` are mandatory
   reads.
4. Start the session ledger unless the task is truly trivial and leaves no durable change.

A trivial task is a one-line factual lookup or a no-file explanation. Hard rule: if the
task creates, edits, moves, or deletes any file, it is non-trivial.

## Forced session discipline

Unless the task is truly trivial, every chat session uses the `sessions/` layer: register
under `sessions/active/`, declare a transcript path under `sessions/logs/`, keep running
notes, write a closeout review under `sessions/reviews/`, then move the record to
`sessions/closed/`. The contract is `_system/session-ledger-rules.md`; the technique is
`entities/skills/manage-ai-session.md`.

If a chat operates inside a swarm sprint, dual-write: `sessions/` for the conversation
trail, `swarms/Sprints/...` for execution artifacts and receipts.

Disposable test artifacts default to `outputs/`, never to knowledge surfaces.

---

## The eleven entities

Everything you build is one of eleven typed entities:

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

Departments (`departments/`) are assemblies over the ontology, not a twelfth type.
Executable entities live canonically in `entities/` and are loaded through `.claude/` and
`.codex/` shims: edit the canonical file, then run `bash sync-adapters.sh`. Never edit a
shim.

## Namespace architecture

Knowledge is namespace-first: the unit is `knowledge/<namespace>/`. Every serious namespace
shares one base (`INDEX.md`, `canon/`, `playbooks/`, `support/`, `synthesis/`) and declares
one of eight profiles that adds folders without forking the ontology
(`_system/namespace-profiles.md`).

`canon/` is the compressed, operator-approved doctrine an agent loads first. Canon is never
self-approved by an agent. `synthesis/` is derived thinking; `support/` is provenance only.
The promotion path is strict: raw source to `support/`, to `synthesis/`, to canon-candidate,
to canon on operator approval.

The starter ships three registered surfaces and one reference set:

- `knowledge/ai-architecture/`: the full reference doctrine (read-first).
- `knowledge/personal-operator/`: the operator's own reduced skeleton (fill it in).
- `knowledge/emberline-studio/`: the worked example namespace (study, then replace).
- `knowledge/_examples/`: eight unregistered profile reference scaffolds.

Run `bash _system/validate.sh` to check the vault. When adding a namespace, register it in
`_system/namespaces/` and follow `entities/skills/build-namespace.md`.

## The lifecycle

Every entity is `scratch` (new, possibly wrong), `research` (validated, worth refining),
`candidate` (nominated, under review), or `canon` (promoted, operator-approved). Promotion
moves forward through review, never by an agent's own declaration. In a multi-repo
deployment (a company canon repo plus personal working repos), `canon` lives upstream; this
standalone starter holds all four states locally with the same discipline.

## Frontmatter contract

Every node-bearing markdown file opens with YAML frontmatter carrying at minimum `id`,
`type`, `namespace`, and `lifecycle_state`, with the id repeated in `aliases`; serious nodes
add `summary`, `confidence`, `retrieval_class`, `export_class`, `edges`, and `created`. Ids
are kebab-case and stable. Wikilinks must resolve. See the worked examples throughout this
repo before inventing conventions.

## Hard style rule

No em dashes, no en dashes, anywhere, in any file. Use commas, colons, or restructure the
sentence. The validator enforces this. No placeholder text above `lifecycle_state: scratch`.

## Retrieval

Agents read git directly via Read, Grep, and Glob. The working tree is the retrieval
surface; no external index is required. Default order: the doctrine card, then the routing
map, then namespace INDEX files, then the specific files the task needs: the minimal
sufficient set, never the whole graph.

## A note on Paperclip

Shipped doctrine refers to Paperclip, the task-and-approval runtime used by the deployment
this starter derives from. Treat the name as a placeholder for whatever runtime substrate
you adopt (an issue tracker, a workflow engine, or nothing at all). The git contract stands
on its own; nothing in this repo requires Paperclip to run.

## What this repo is not

- Not a system of record for numbers: metrics live in your BI stack; `data/` holds pointers.
- Not a place for raw runtime logs: reviewed lessons become Memory nodes.
- Not a secret store: `secrets/` holds references, never values.

---

See `CLAUDE.md` for the Claude Code equivalent of this file. Both files mirror each other and
must be edited together.
