---
id: doc-local-setup
title: "Local Setup"
type: doc
namespace: personal
summary: "Bootstrap guidance for using this personal Infinite Brain repo before sibling shared repos or live runtimes are added."
confidence: 0.95
retrieval_class: normal
export_class: internal
lifecycle_state: canon
tags: [setup, bootstrap, local, starter]
edges: []
---

# Local Setup

This repo is ready to use on its own as a personal Infinite Brain sandbox.

## What already works

- Obsidian-first entry flow through `START-HERE.md`
- Example commands, agents, skills, workflows, and project structure
- Local validator at `bash _system/validate.sh`
- Intake flow under `intake/`
- Bundled n8n proof pack under `n8n-live-proof/`

## What is not present yet

- a sibling company-canon repo
- a sibling department repo
- live Paperclip or Postgres task state
- live n8n credentials or deployed workflows

That is expected. This repo is still useful without them.

## Day-one usage

1. Open `START-HERE.md`.
2. Open the folder as an Obsidian vault if you want the graph and dashboard flow.
3. Read `projects/example-project/PLAN.md` to see the task pattern.
4. Replace example content over time instead of trying to redesign the repo first.
5. Run `bash _system/validate.sh` after adding or changing real nodes.

## When to add sibling repos

Add sibling company or department repos only when:

- you want to promote nodes upstream
- you need shared canonical planning
- you need cross-repo retrieval against real shared canon

Until then, treat references to sibling canon repos in some docs as future-state guidance.
