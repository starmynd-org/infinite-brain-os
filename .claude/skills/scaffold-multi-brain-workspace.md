---
id: "skill-scaffold-multi-brain-workspace"
aliases: ["skill-scaffold-multi-brain-workspace", "scaffold-multi-brain-workspace"]
type: "Skill"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Stand up a parent workspace that routes between several brains: a .claude/ router over a brains/ folder mounting a shared brain plus an individual brain, with a /start bootstrap, a governed /sync (GitHub by default; individual free, shared content free, shared core to a proposal branch), a read-only copy-up of each brain's runtime layer, and a generated brain-selection index."
confidence: 0.8
retrieval_class: "domain"
export_class: "internal"
description: "Use this skill to build a person a parent workspace over more than one brain: mount a shared brain plus their individual brain under brains/, author the router and the /start and /sync commands, wire the runtime copy-up and the brain-selection index, and verify. Follows the multi-brain-workspace contract and playbook."
edges:
  - target: "[[stand-up-a-multi-brain-parent-workspace]]"
    relation: "implements"
    confidence: 0.9
  - target: "[[reflexive-brain-topology]]"
    relation: "derived_from"
    confidence: 0.85
  - target: "[[skill-recommend-architecture]]"
    relation: "references"
    confidence: 0.75
created: "2026-07-24"
---

# scaffold-multi-brain-workspace

Use this skill to build a parent workspace for one person who works across more than one brain. It is
the meta-builder for the pattern in [[stand-up-a-multi-brain-parent-workspace]], governed operatively by
`_system/multi-brain-workspace-contract.md` (the `MBW` series).

## Use when

- a person works across a shared brain (company or a graduated department brain) plus their own
  individual brain, per the tiers in [[reflexive-brain-topology]]
- a team is being onboarded and each person needs the same two-brain workspace

## Do not use when

- the person works in exactly one brain: they open that repo directly, and none of this applies
- the goal is to release a built department to a non-technical client team as pre-built zips: use the
  client-team release procedure instead

## Input

The mount set: exactly one shared brain and one individual brain per person, each an independent git
repo with its own remote. GitHub is the default backend; an alternate access layer (for example a
Cloudflare-Access git host) only changes the remote URL, not the design.

## The scaffold

Produce a thin parent folder the person opens in Claude Code:

```
<workspace>/
  .claude/
    commands/  start.md sync.md save.md promote-to-department.md workspace-help.md
    settings.json          model pin + Edit-only guards on the shared brain's core paths
    refresh-commands.sh     the copy-up + brain-selection index generator
  CLAUDE.md  AGENTS.md  START-HERE.md    the router: which brain to use, the governance line
  .gitignore              ignores brains/* and the generated layers
  brains/                 empty; /start clones the brains in
    README.md
```

If the deployment already has a proven reference implementation of this scaffold, copy from it and adapt
the names and remotes; otherwise build it from the steps below.

## Build steps

1. Decide the mount set (one shared brain, one individual brain) and the remotes.
2. Scaffold the thin parent per the layout above; the `.gitignore` keeps `brains/*` and the generated
   layers untracked so the mounted brains stay independent (MBW-1).
3. Author the router (`CLAUDE.md` plus its `AGENTS.md` mirror): default real and shared work to the
   shared brain, unproven work to the individual brain, proven work promoted up (MBW-2).
4. Author `/start`: check or install the cloud sign-in and any CLIs the brains need (install a CLI only
   if missing, authenticate only if the session is missing or stale; a CLI vendored in the shared brain
   installs from the cloned copy), probe git-remote reachability and give the plain re-auth instruction
   on failure, clone or refresh each brain, then run `/sync` (MBW-3). If a CLI needs a non-confidential
   setup credential (an installed or Desktop OAuth client), bundle it at a git-ignored `.claude/setup/`
   path so it ships in the handoff but never enters a committed repo (MBW-8), and adapt both the shared
   brain's folder name and its remote for the target department.
5. Author `/sync`: push the individual brain freely; push shared-brain content to the shared branch;
   route any shared-brain core change to a `proposal/<slug>-<topic>` branch and name the reviewer; pull
   before push; degrade gracefully (MBW-4).
6. Wire `refresh-commands.sh`, run by `/start` and `/sync`: copy each mounted brain's
   `.claude/{commands,skills,agents,rules}` up into the parent `.claude/`, idempotently and with
   provenance, never overwriting the workspace's own commands, shared brain wins collisions (MBW-5); and
   regenerate the brain-selection index from each brain's `INDEX.md` and entity folders (MBW-6).
7. Give the workspace a `settings.json` that pins the model, allows the safe command set, and guards the
   shared brain's core paths with `Edit(path)` rules only; never `Write(path)` rules, and split compound
   commands into matchable parts (MBW-8).
8. Deliver flat (a repo the person clones, or a zip of the folder contents, never a wrapper folder) and
   verify: the reachability probe passes, both brains clone, sibling paths resolve, and a copied
   shared-brain command is recognized and runs against its brain. Leak-sweep before any push.

## Quality checks

- `brains/*` and the generated layers are git-ignored in the parent; the two brains stay independent
- `/sync` routes shared-brain core changes to a proposal branch and never pushes them to the shared branch
- copied entities carry provenance, are read-only downstream, and never overwrite the workspace commands
- the brain-selection index is generated, not hand-written, and never edits a brain's internals
- `settings.json` uses `Edit(path)` guards only and no dead `Write(path)` rules
- no secret value in the parent or the copied layer; the delivered scaffold passes a leak scan

## Anti-patterns

- mounting the brains at the workspace root instead of under `brains/`, so `git status` fights the
  embedded repos
- copying a brain's canon into the parent instead of referencing it by sibling path
- hand-editing a copied entity instead of editing the upstream brain and re-syncing
- pushing shared-brain core changes straight to the shared branch, skipping the review gate
- zipping the workspace inside its own wrapper folder, so extraction double-nests and `.claude/` never
  loads
