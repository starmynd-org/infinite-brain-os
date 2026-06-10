---
id: doc-onboard-business
title: "Onboard Your Business"
type: doc
namespace: personal
summary: "Operator-facing guide to /onboard-business: what the interview is like, what the recommendation set contains, how acceptance works, and how to launch the generated sprints."
confidence: 0.9
retrieval_class: normal
export_class: public
lifecycle_state: research
tags: [onboarding, starter, interview, architecture]
edges: []
---

# Onboarding Your Business: /onboard-business

The brain's front door. You sit down, it interviews you, it tells you what architecture
your business needs, and it hands you launchable build plans. You do not need to know
anything about this system before running it; learning the system is part of what it does.

## How to run it

Open the repo in your coding agent and type:

```text
/onboard-business
```

Optionally add a sentence of context:

```text
/onboard-business We run a small candle studio, mostly wholesale plus a web shop.
```

## What to expect

**1. An interview, 20 to 40 minutes.** Plain-language questions about your business, one
at a time: what you sell, who buys, the work that recurs, who does what, where your data
lives, what breaks, and what the next ninety days are for. Each section ends with a short
playback you confirm or correct. No system jargon; if a question sounds technical,
something is wrong.

**2. A business map.** The confirmed record of the interview, written to
`intake/processed/<date>-business-map.md`, quoting your own words. It is the evidence
every later recommendation cites.

**3. A bounded recommendation set.** At most one department, three knowledge bases, and
three workflows, ranked, each with the interview facts that triggered it (your words,
quoted back), what it is worth, and how big it is. Plus two honest lists: what is parked
for later, and what the brain recommends NOT building yet and why. Each system term comes
with a one-line plain-English gloss the first time it appears. If, and only if, the
interview showed a real need, the set may end with a short optional-tooling note
(Obsidian for browsing your knowledge visually, n8n for fully stabilized automations,
Paperclip as a later cockpit for departments), with setup steps in
`docs/local-tooling-setup.md`. None of these tools is required; the system runs fully
without them.

**4. Your acceptance.** You accept items one by one. Nothing is scoped or built from an
item you decline; declined items move to the Later list with your reason.

**5. Generated build plans.** For each accepted item you get a project file (the durable
plan with tasks) and a sprint folder (the launchable build package with its own charter,
plan, gates, and launch sheet). Nothing is built yet; these are scoped plans waiting for
you to launch them.

## How to launch a generated sprint

Each generated sprint folder under `swarms/Sprints/` contains a `02-launch-sheet.md`.
Open it, follow the terminal block (open a new terminal at the repo root, start your
agent), and paste the quoted prompt as the first message. Launching is the approval: the
sprint's approval receipt records that the launch decision is yours, and nothing in a
generated sprint sends, spends, or publishes anything on its own.

Run sprints in the order the hand-over recommends; some read knowledge that others build
(the run record names these dependencies).

## Running it again later

`/onboard-business` is not only for day one. Re-run it after the business changes: it
loads your existing map, confirms what still holds, interviews only the delta, and
recommends only what your existing architecture does not already cover, crediting what
already serves you.

## Under the hood

The command is `entities/commands/onboard-business.md`. The interview method is
`entities/skills/interview-business.md`, the mapping judgment is
`entities/skills/recommend-architecture.md`, and the pipeline that scopes projects and
generates sprints is `workflows/onboard-business-architecture.md`. The starter's example entities (the fictional candle studio) show
the same loop's outputs in miniature; see the getting-started
walkthrough.
