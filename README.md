# Infinite Brain OS

A git-backed operating system for running a business with AI agents. Plain Markdown and
YAML, readable by any file-reading agent, owned by you.

The Infinite Brain is a knowledge OS: it makes what your business knows, decides, and does
reliably retrievable and safely executable by AI agents, today and after the tools change.
Knowledge lives in namespaces with an explicit promotion path to operator-approved canon.
Work lives in projects with typed entities (commands, agents, skills, rules, workflows,
tools). A contract layer (`_system/`) plus a validator keeps the whole graph honest. Your
AI coding agent (Claude Code, Codex, or any file-reading agent) is the runtime.

No database, no server, no vendor lock-in. If you can read this repo, so can your agents.

## Quickstart

```bash
git clone <this-repo> my-brain && cd my-brain
bash _system/validate.sh     # the contract holds: zero errors on a fresh clone
claude                       # or your agent of choice; CLAUDE.md orients it
```

Then say to your agent:

```
Read START-HERE.md and give me the tour.
```

Or open the folder as an Obsidian vault (config ships in `.obsidian/`) and read
`START-HERE.md` yourself. The full walkthrough is `docs/getting-started.md`.

## What ships in the box

- **The contract layer.** `_system/` holds the schemas, rules, registries, and
  `validate.sh`: what must be true in this repo and how it is checked.
- **The doctrine.** `knowledge/ai-architecture/` is the full reference architecture: the
  control spine, the namespace model, canon versus synthesis, retrieval doctrine, surface
  boundaries, and the agent-authority limits. It is the "why" behind every folder here.
- **A complete worked example.** A fictional candle studio (Emberline) threads through one
  example of every entity type, all cross-linked: a command, an agent, a skill, a rule, two
  workflows (agentic and deterministic), a tool, a tiny knowledge namespace, a data pointer,
  a memory, an output, a filled project, and an assembled department.
- **Builders.** Skills and workflows that scaffold new namespaces, departments, projects,
  agents, and knowledge bases, plus an onboarding interview (`docs/onboard-business.md`)
  that maps your business onto the architecture.
- **Eight profile references.** `knowledge/_examples/` shows the eight namespace profiles
  (doctrine, data-system, design-system, content-strategy, tool-contract, and more) as
  copyable scaffolds.

## Folder map

```
_system/           The operative contract: schemas, rules, registries, validate.sh
knowledge/         Namespace-first knowledge graph (the doctrine and your domains)
entities/          Canonical executable entities: commands, agents, skills, rules
.claude/ .codex/   Runtime adapter shims (regenerate with sync-adapters.sh)
workflows/         Agentic reasoning pipelines
automations/n8n/   Deterministic workflows (JSON plus a brain-record companion)
tools/             Pointer nodes over bounded capabilities
departments/       Assemblies over the entities: one folder per operating lane
projects/          One PLAN.md per project, with inline tasks
intake/            Inbound flow: source captures, routing, processed receipts
data/              Pointers to where numbers live (never the numbers)
memory/            Reviewed learnings
outputs/           Produced artifacts with lineage
sessions/          The audit trail of AI work sessions
swarms/            Multi-agent sprint packages
docs/              Setup, retrieval, and onboarding docs
```

## The example tour (fifteen minutes)

1. `knowledge/emberline-studio/canon/brand-essentials.md`: a canon node, the studio's
   source of truth. Note the verification fields and the changelog.
2. `entities/rules/studio-brand-voice.md`: a rule derived from that canon.
3. `entities/skills/write-product-description.md`: a skill that applies the rule.
4. `entities/agents/studio-inbox-triage.md`: an agent that uses both and escalates what it
   must not decide.
5. `workflows/weekly-studio-review.md`: the weekly loop reading `data/orders-ledger.md`
   (a pointer, never live numbers) and `memory/photograph-before-listing.md` (a lesson).
6. `outputs/2026-06-05-spring-collection-brief.md`: what the loop produced, with lineage.
7. `projects/_example/PLAN.md`: the work container that ties it together.
8. `departments/example-studio-ops/INDEX.md`: the assembly of all of the above.

Every file is under two minutes' reading. Follow the edges in the frontmatter; that is the
graph.

## The rules that keep it honest

- Every node-bearing file carries typed YAML frontmatter; `bash _system/validate.sh` must
  exit 0.
- Canon is operator-approved, always. Agents draft; you sign.
- The repo never stores live numbers, live queues, or secrets: pointers only.
- Sessions that touch the repo are registered, logged, and closed out in `sessions/`.

Shipped doctrine occasionally refers to Paperclip, the task runtime of the deployment this
starter derives from: treat it as a placeholder for whatever runtime you adopt. Nothing
here requires it.

## Make it yours

Run the onboarding interview (`docs/onboard-business.md`), or go manual: build your first
namespace with `entities/skills/build-namespace.md`, assemble your first department from
`departments/_template/`, fill in `knowledge/personal-operator/pillars/operator-profile.md`,
and retire the candle studio when you no longer need the training wheels.

## License

MIT. See `LICENSE`. Contributions welcome: see `CONTRIBUTING.md`.
