---
id: doc-local-tooling-setup
title: "Local Tooling Setup"
type: doc
namespace: personal
summary: "Optional local tooling for the Infinite Brain: Obsidian as the reading surface, n8n as the deterministic workflow runtime, Paperclip as the runtime cockpit. What each is for, when you actually need it, and how to set each up locally."
confidence: 0.85
retrieval_class: normal
export_class: public
lifecycle_state: research
tags: [setup, tooling, obsidian, n8n, paperclip, optional]
edges: []
---

# Local Tooling Setup (all optional)

The brain works with nothing but this repo and a file-reading coding agent. Everything in
this guide is an optional surface layered on top: install a tool when the work shows a
real need for it, not before. If `/onboard-business` suggested one of these, the
suggestion names the need it saw; if the need is not there yet, skip the tool with zero
loss.

## Obsidian: the reading surface

**What it is for.** Browsing and visualizing the knowledge graph: wikilinks become a
clickable graph, frontmatter becomes filters, and the vault view makes the namespace
structure tangible. Obsidian never owns truth; it reads the same Markdown files your
agent does.

**You want it when** you find yourself wanting to see the graph, browse knowledge
visually, or read and edit notes comfortably outside the terminal.

**You do not need it when** your agent does all the reading and you mostly consume its
answers. Many operators run brains for weeks before opening a vault.

**Setup (5 minutes).**

1. Download Obsidian from `https://obsidian.md` (free for personal use) and install it.
2. Open Obsidian, choose "Open folder as vault," and select this repo's root folder.
3. If the repo ships a `.obsidian/` folder, the vault opens preconfigured (graph view
   colored by `lifecycle_state`, useful defaults). If not, the defaults are fine.
4. Optional: install the community Git plugin inside Obsidian if you want the vault to
   pull and commit on a timer.

## n8n: the deterministic workflow runtime

**What it is for.** Running deterministic workflows: fixed steps, schedules, and
integrations that should execute exactly the same way every time without an AI in the
loop. In this OS, n8n workflow JSON lives in `automations/n8n/`, each export paired with
a companion Markdown node that is the brain's record of what the automation does.

**You want it when** a workflow has fully stabilized: the steps never need judgment, it
should run on a clock or a webhook, and a human or agent re-running it by hand has become
the bottleneck.

**You do not need it when** your recurring loops are young. A workflow run by your agent
from its Markdown definition is the right first stage; promote it to n8n only after the
steps stop changing. Most onboarding-generated workflows should live their first months
as agent-run Markdown.

**Setup (10 to 15 minutes, pick one).**

Docker (recommended for a persistent local service):

```bash
docker volume create n8n_data
docker run -d --name n8n -p 5678:5678 \
  -v n8n_data:/home/node/.n8n \
  docker.n8n.io/n8nio/n8n
```

Node.js (quick trial, requires a current LTS Node):

```bash
npx n8n
```

Then open `http://localhost:5678`, create the local owner account, and you are running.
Full documentation: `https://docs.n8n.io`. House rules: export every workflow as JSON
into `automations/n8n/`, write the companion `.md` node next to it, and keep credentials
in n8n's own store, never in this repo.

## Paperclip: the runtime cockpit

**What it is for.** The runtime control plane for AI departments: org chart, agents,
issues, heartbeats, budgets, approvals, and audit. The division of labor is strict: the
brain (this repo) stays the planner of record and the home of canon; Paperclip is the
body that runs live task state. Live queue state never lives in git.

**You want it when** you have at least one real department with recurring AI-run work
and the live state (what is in flight, what awaits your approval) has outgrown reading
receipts in the repo.

**You do not need it when** you are pre-department or running one or two workflows. A
fresh brain does not need a cockpit; most adopters should not think about Paperclip in
month one.

**Setup.** Paperclip is a self-hosted service. In local mode its API serves at
`http://localhost:3100/api` and setup runs through the Paperclip CLI. Because
distribution and versions move, follow the Paperclip project's own documentation rather
than this page. If you
do not have access to a Paperclip build, skip this entirely; nothing else in the OS
depends on it.

## The order that usually makes sense

1. No tools: repo plus coding agent (day one, fully functional).
2. Obsidian, once you want to see what you are building.
3. n8n, once a workflow has stabilized enough to deserve determinism.
4. Paperclip, once a department's live state needs a cockpit.
