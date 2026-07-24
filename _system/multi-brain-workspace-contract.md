# Multi-Brain Workspace Contract

This file is the operative contract for a parent workspace that routes and syncs more than one brain.
A parent workspace is a thin folder a person opens in Claude Code whose `.claude/` layer routes between
several brain repos mounted under a `brains/` folder: a shared brain (company or department) plus one or
more individual brains. It governs how the workspace mounts brains, routes work between them, bootstraps
a machine, syncs over git, and lifts each brain's runtime layer up so it is usable at the parent. It
complements existing contracts and does not restate them:

- `_system/repo-registry-rules.md` classifies the repos (`repo_kind`, `brain_tier`); this file governs
  how a workspace mounts and routes between them.
- `_system/runtime-location-contract.md` governs one-way-for-truth sync across hosts; this file applies
  that posture to the several brains a single person mounts, not to hosts.
- `_system/promotion-path-rules.md` governs the lifecycle gate; the `/sync` proposal branch here is the
  branch-level implementation of that gate for a shared brain.

Doctrine lives in `knowledge/ai-architecture/pillars/reflexive-brain-topology.md` (the tiers and the
"the brain is just git, synced via GitHub" premise) and
`knowledge/ai-architecture/playbooks/stand-up-a-multi-brain-parent-workspace.md` (the how). This file
states the operative rules only.

## Layout

A parent workspace is a thin, optionally versioned folder holding:

```
<workspace>/
  .claude/        router (CLAUDE.md/AGENTS.md at root) + workspace commands (/start, /sync, ...)
  brains/
    <shared-brain>/     a company or department brain repo, cloned in
    individual-<name>/   one or more individual brain repos, cloned in
```

Each brain under `brains/` is an independent git repo. The parent does not track their contents.

## Rules

### MBW-1 One opened root, many mounted brains

The person opens the parent workspace, never a brain in isolation. Each brain under `brains/` stays an
independent repo with its own remote and lifecycle. The parent workspace never commits a mounted brain's
contents: `brains/*` is git-ignored except a placeholder readme, so the brains sync independently and no
embedded-repo tracking occurs.

### MBW-2 Default to the shared brain, individual for the unproven

The router sends real, shared, or canon-reading work to the shared brain by default. Experimental,
unpolished, or personal work that could break what others rely on starts in the person's individual
brain. This is the tier posture in [[reflexive-brain-topology]] applied at the workspace: shared is the
default working surface, the individual brain is the cheap-to-be-wrong surface, and proven individual
work is promoted upward, never edited into the shared brain directly.

### MBW-3 One bootstrap command

A single `/start` command sets up or wakes a machine end to end: it establishes the credentials the
brains need (a cloud sign-in for data, and reachability of the git remote), clones or refreshes every
brain under `brains/`, then runs `/sync`. It is idempotent and degrades gracefully: a missing credential
is reported as one plain instruction, never as raw tool output, and never silently skipped.

### MBW-4 Governed sync, backend-agnostic, GitHub by default

`/sync` is backend-agnostic: it runs plain git against whatever remote each brain has. GitHub is the
default and assumed backend; an alternate access layer (for example a Cloudflare-Access git host) is
configuration, not a different contract. `/sync` governs three streams:

- the individual brain pushes freely;
- shared-brain content (produced outputs and session records) pushes to the shared branch freely;
- shared-brain core changes (its entities, knowledge, `_system`, workflows, automations, tools, `bin`,
  docs, and root orientation) route to a `proposal/<slug>-<topic>` branch, are pushed there, and never
  land on the shared branch unreviewed.

The proposal branch is the branch-level form of the candidate-to-canon operator gate in
`_system/promotion-path-rules.md` and the one-way-for-truth plus promotion-only writeback posture in
`_system/runtime-location-contract.md` (R2, R4). A human reviews and merges; no agent merges a core
change to a shared brain on its own authority. Pull before push, per the same R2.

### MBW-5 Lift the runtime layer up, read-only

Claude Code loads only the opened root's `.claude/`, never a child repo's. So `/start` and `/sync` copy
each mounted brain's `.claude/{commands,skills,agents,rules}` up into the parent `.claude/` so they work
as first-class slash commands, agents, and skills at the parent. The copy is read-only downstream: it
carries provenance (which brain, which path), it never overwrites the workspace's own commands, and it
is regenerated on every sync so a deleted upstream entity disappears. Edit the upstream brain and
re-sync; never hand-edit a copied entity. This is the vendored-entity discipline in
[[reflexive-brain-topology]] applied to a workspace, the same read-only-downstream rule
`tools/brain-export/check-drift.sh` enforces for the public starter. A copied command still runs against
its source brain, so it changes into that brain's folder first. New copies load on a Claude Code restart.

### MBW-6 Hydrate the router with a brain-selection index

On sync the workspace also regenerates a brain-selection index: a generated catalog listing, per mounted
brain, its tools, workflows, agents, skills, and knowledge namespaces plus a one-line when-to-use, read
from each brain's own `INDEX.md` and entity folders. It gives the router concrete material to direct work
to the right brain instead of describing the brains in prose. It is generated, git-ignored, and never
edits a brain's internals.

### MBW-7 Generated layers never become truth

The copied runtime layer (MBW-5) and the selection index (MBW-6) are generated artifacts: read-only
downstream, git-ignored in the parent, and regenerable. They never become a second source of truth. The
upstream brain is authoritative, per the surface boundary.

### MBW-8 Secret and trust posture

No secret value lives in the parent workspace or the copied layer; secrets stay by reference per
`_system/secret-registry-rules.md`. The workspace `settings.json` expresses file guards with `Edit(path)`
rules (which cover every file-editing tool) and never relies on `Write(path)` rules, and it splits any
compound command permission into matchable parts. The opened root must be trusted once before its saved
permissions apply.

## What is checked

- Deterministic (validator-checkable): no raw secret value is committed (the secret-registry discipline
  in `_system/secret-registry-rules.md`); a mounted brain that graduated carries a `repo-registry/`
  entry (`_system/repo-registry-rules.md`).
- Curator-reviewed (not `validate.sh`-enforced today): MBW-2 routing default, MBW-4 core-versus-content
  classification and the proposal-branch gate, MBW-5 workspace-command preservation and read-only
  provenance. These are reviewed at the workspace build and at each release under the devops-platform
  hard-gate posture, not by `validate.sh`.

## Relationship

- Doctrine: `knowledge/ai-architecture/pillars/reflexive-brain-topology.md`,
  `knowledge/ai-architecture/playbooks/stand-up-a-multi-brain-parent-workspace.md`.
- Adjacent contracts: `_system/repo-registry-rules.md`, `_system/runtime-location-contract.md`,
  `_system/promotion-path-rules.md`, `_system/department-assembly-rules.md`,
  `_system/secret-registry-rules.md`.
- Owning department: `departments/devops-platform/` owns the bootstrap and sync posture, the same owner
  `_system/runtime-location-contract.md` names for the local-to-GitHub sync.

## Changelog

- 2026-07-24: authored to generalize the field-proven parent-workspace pattern from client team rollouts
  and a two-repo parent-workspace deployment into an operative contract for a `.claude/` router over
  `brains/` with `/start`, a governed `/sync`, the runtime copy-up, and the brain-selection index.
  Operative contract, operator-reviewable; not promoted canon.
