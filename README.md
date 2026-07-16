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
- **The OODA orientation set.** How the whole OS reads as John Boyd's real OODA web:
  the bridge, the feedback-plane spec, and a router index in
  `knowledge/ai-architecture/synthesis/`, the wager-ledger design that closes the
  Act-to-Orient arrow, and an interactive visual explainer
  (`docs/ooda-infinite-brain-map.html`).
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
- **Provenance.** `PROVENANCE.yml` at the repo root records the exact source commit, export
  date, and pipeline version this release derives from, machine-readable.

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

## What's new: the 2026-07 release

The starter still self-describes as architecture v3.1; this release extends the content,
not the retrieval or ontology spec. Headlines:

- **The OODA orientation lens and the feedback-plane design.** Canon now frames the OS with
  Orient as the dominant center (core-doctrine sections 14 and 15.2, department-model
  section 11), backed by the shipped synthesis set: the Boyd bridge, the Act-to-Orient
  feedback-plane spec, the wager-ledger decision and operative contract
  (`_system/wager-ledger-rules.md`), and the interactive visual map in `docs/`. The wager
  ledger is a ratified design, not a running system; it ships as doctrine you can build.
- **The reflexive-brain-topology enterprise standard.** How a company organizes repos once
  it runs the brain internally: shared parent, individual brains (one per person),
  department brains, one company brain
  (`knowledge/ai-architecture/pillars/reflexive-brain-topology.md`), plus the
  trust-boundary graduation decision and playbook for when a department earns its own repo.
- **`repo_kind` and `brain_tier` registry fields.** `_system/repo-registry-rules.md` and
  the registry template now classify every repo as `brain`, `app`, or `mixed`, and every
  brain as `individual`, `department`, or `company`.
- **The asset-reference layer.** `_system/asset-reference-schema.md` and
  `_system/asset-registry-rules.md`: binary assets stay out of git, references and
  metadata stay in, the same discipline as secrets.
- **Department operations.** The department-web canon (capture, convert, build, operate,
  feed back), the ambient capture rule, the onboarding and operating guides, the
  operations-readiness gate, and the daily-update workflow.
- **Intake playbooks.** Processing procedures for the email and Slack source lanes
  (`intake/playbooks/`), alongside the existing X, YouTube, web, repo, and research lanes.
  Capture connectors are not bundled: you wire your own capture into `intake/sources/`,
  and a connector suite is the planned next release.
- **Machine-readable provenance.** `PROVENANCE.yml` replaces prose-only lineage: source
  commit, source dirty-path count, export date, pipeline version, spec version.
- **The companion harness repo.** The shared-parent tier of the topology is now a real,
  runnable repo: [infinite-brain-harness](https://github.com/starmynd-org/infinite-brain-harness)
  is a thin versioned root that holds this brain and its siblings, with the registry and
  orientation layer for running multiple brains side by side.

## Make it yours

Run the onboarding interview (`docs/onboard-business.md`), or go manual: build your first
namespace with `entities/skills/build-namespace.md`, assemble your first department from
`departments/_template/`, fill in `knowledge/personal-operator/pillars/operator-profile.md`,
and retire the candle studio when you no longer need the training wheels.

Growing past one repo? Put your brains under the companion
[infinite-brain-harness](https://github.com/starmynd-org/infinite-brain-harness) root: it
carries the shared-parent orientation and client workspace from the reflexive-brain-topology
standard, so a second brain is a registry entry, not a redesign.

## License

MIT. See `LICENSE`. Contributions welcome: see `CONTRIBUTING.md`.
