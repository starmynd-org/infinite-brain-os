---
id: "knowledge-ai-architecture-stand-up-a-multi-brain-parent-workspace"
aliases: ["knowledge-ai-architecture-stand-up-a-multi-brain-parent-workspace", "stand-up-a-multi-brain-parent-workspace", "multi-brain-parent-workspace-playbook"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Step-by-step procedure for standing up a parent workspace that routes between several brains mounted under a brains/ folder: a .claude/ router over a shared brain plus one or more individual brains, a /start bootstrap that authenticates and clones the brains, a governed /sync (GitHub by default; individual free, shared content free, shared core to a proposal branch), a read-only copy-up of each brain's runtime layer, and a generated brain-selection index."
confidence: 0.8
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[reflexive-brain-topology]]"
    relation: "derived_from"
    confidence: 0.9
  - target: "[[graduate-a-department-to-its-own-brain-repo]]"
    relation: "related_to"
    confidence: 0.82
created: "2026-07-24"
---

## Before starting

Use this when one person works across more than one brain: a shared brain (company or department) plus
their own individual brain, per the tiers in [[reflexive-brain-topology]]. If a person works in exactly
one brain, they open that repo directly and none of this applies. The operative rules this procedure
obeys are in `_system/multi-brain-workspace-contract.md` (the `MBW` series); this playbook is the how,
not the why. It is the general, internal form of the client-team release procedure, field-proven on
client team rollouts.

## 1. Decide the mount set

List the brains this person mounts: exactly one shared brain (the company brain, or a department brain
that has graduated to its own repo per [[graduate-a-department-to-its-own-brain-repo]]) and one
individual brain per person. Each is an independent git repo with its own remote. GitHub is the default
backend; an alternate access layer (for example a Cloudflare-Access git host) only changes the remote
URL, not the design, per MBW-4.

## 2. Scaffold the parent workspace

Create the thin parent folder the person opens in Claude Code. It holds a `.claude/` router
(`CLAUDE.md` and its `AGENTS.md` mirror at the root, plus workspace commands) and an empty `brains/`
that `/start` fills. Ship it with a `.gitignore` that ignores `brains/*` (the mounted repos stay
independent) and the generated layers, so `git status` in the parent stays clean. The router states the
MBW-2 default: real and shared work in the shared brain, unproven work in the individual brain, proven
work promoted up.

## 3. Author the workspace commands

Author the workspace's own commands, which the copy-up never overwrites:

- `/start`: install or check the cloud sign-in and any CLIs the brains need for data (install a CLI only
  if it is missing, authenticate only if its session is missing or stale), probe git-remote reachability
  and give the plain re-auth instruction when it fails, clone or refresh every brain under `brains/`, then
  run `/sync` (MBW-3). Read the shared brain's tool contracts for which CLIs it needs and how each one
  authenticates; a CLI vendored inside the shared brain installs from the cloned copy, not a separate
  download. Not every brain ships an auth tool or a connection doc, so when it does not, `/start` does
  the sign-in generically and inlines the connection guidance rather than pointing at a missing file.
- `/sync`: the governed sync (MBW-4). Push the individual brain freely. Push shared-brain content
  (`outputs/`, `sessions/`) to the shared branch. Route any shared-brain core change to a
  `proposal/<slug>-<topic>` branch, push that branch, and tell the person who reviews it. Pull before
  push. Degrade gracefully on an auth or TLS error with one plain line.
- `/save`, `/promote-to-department`, `/workspace-help`: commit both brains, package individual work for
  review, and explain the workspace in plain words.

## 4. Wire the runtime copy-up

Because Claude Code loads only the opened root's `.claude/`, `/start` and `/sync` run a refresh that
copies each mounted brain's `.claude/{commands,skills,agents,rules}` up into the parent `.claude/`
(MBW-5). Make it idempotent: clear the previously copied set from a manifest, re-copy, and write a
provenance file mapping each copied entity to its source brain and the folder to run it from. Never
overwrite the workspace's own commands; on a name collision the shared brain wins. Copied entities are
read-only downstream: edit the upstream brain and re-sync. Tell the person new copies load on a Claude
Code restart.

## 5. Generate the brain-selection index

On the same refresh, regenerate a brain-selection index (MBW-6): for each mounted brain, read its
`INDEX.md` and entity folders and list its tools, workflows, agents, skills, and knowledge namespaces
with a one-line when-to-use. This is what lets the router direct work to the right brain concretely. It
is generated and git-ignored, and it never edits a brain's internals.

## 6. Set the settings and trust posture

Give the workspace a `settings.json` that pins the model, allows the read and safe-command set the brains
need, and guards the shared brain's core paths with `Edit(path)` rules (which cover every file-editing
tool; `Write(path)` rules are dead and must not be used). Split any compound-command permission into
matchable parts. No secret value lives in the parent or the copied layer (MBW-8). Tell the person the
first open shows a trust dialog they must accept before the saved permissions apply.

## 7. Deliver and verify

Deliver the parent workspace to the person (a repo they clone, or a flat zip of the folder contents, not
a wrapper folder, so extraction yields one correctly named workspace). Verify end to end: the reachability
probe succeeds, both brains clone, sibling paths between brains resolve, and a copied shared-brain command
is recognized and runs against its brain. Sweep the delivered scaffold and any seeded individual repo for
secrets before any push, the same adversarial read a client-team release applies to its delivery zip.

## Field rules

- The parent layer stays thin and orchestrating. A brain's own commands assume that brain's root as the
  working directory, so a copied command changes into its source brain first; for a long focused session
  in one brain, opening that brain directly is still cleanest.
- Backend-agnostic means degrade gracefully. When the remote is unreachable, commit locally and report
  one plain re-auth instruction; never block on a credential prompt (`GIT_TERMINAL_PROMPT=0`).
- Individual repos carry fewer guardrails on purpose. Content and sessions upload freely; only shared-brain
  core changes gate through the proposal branch.
- Deliver flat. A zip that wraps the workspace in its own folder double-nests on extraction and the person
  opens an empty shell where `.claude/` never loads.
- The shared brain's identity is two independent things: its folder name and its remote (host plus owner).
  When adapting an existing rollout for a different shared brain, change both. A find-and-replace of the
  name alone leaves the old remote, and the clone silently points at the wrong brain.
- Match the router's command examples to the shared brain's actual commands and verify they exist. Different
  brains ship different tools; a stale example teaches the wrong command.
- When a CLI needs a setup credential (an OAuth client), `/start` may bundle it in the workspace at a
  git-ignored path (for example `.claude/setup/`) so it rides in the delivered handoff but never enters a
  committed repo. Do this only for a non-confidential credential (an installed or Desktop OAuth client,
  whose secret is non-confidential by design), never a service-account key or a confidential client secret,
  and deliver the handoff over a private channel. A per-person CLI signs in as that person, not a shared
  account.

## What this playbook is not

It is not the client-team release procedure, which ships a built department to a non-technical client
team as pre-built zips over a `work/<name>` branch spine. This is the
general internal form: the person authenticates and clones the brains in place with `/start`, mounts them
under `brains/`, and syncs with the governed `/sync`. Both are instances of the same shared-parent tier in
[[reflexive-brain-topology]], and both should eventually share one manifest-driven exporter rather than
staying separate scripts.

## Relationship

`derived_from` [[reflexive-brain-topology]] (the tiers and the git-synced premise this workspace
instantiates) and the field-tested client-team release procedure.
`related_to` [[graduate-a-department-to-its-own-brain-repo]] (the sibling procedure that produces the
shared department brain a workspace mounts). The meta-builder that executes this procedure is
[[skill-scaffold-multi-brain-workspace]]. The operative rules are in
`_system/multi-brain-workspace-contract.md`; the repo classification fields are in
`_system/repo-registry-rules.md`.
