---
id: "cmd-onboard-business"
aliases: ["cmd-onboard-business", "onboard-business"]
type: "Command"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Entry-point command for the business onboarding engine: interview the person, recommend architecture, and scope accepted recommendations into launchable projects and sprints."
confidence: 0.8
retrieval_class: "identity"
export_class: "public"
description: "Use when a person wants the brain to learn their business and tell them what to build: runs the full interview, recommendation, and scoping loop. Also usable mid-life to diff an evolved business against the existing architecture."
edges:
  - target: "[[skill-interview-business]]"
    relation: "delegates_to"
    confidence: 0.95
  - target: "[[skill-recommend-architecture]]"
    relation: "delegates_to"
    confidence: 0.95
  - target: "[[workflow-onboard-business-architecture]]"
    relation: "uses"
    confidence: 0.95
created: "2026-06-10"
---

# /onboard-business

Sit down with the brain and let it learn your business, then have it tell you what to
build. One command runs the whole front door:

```text
/onboard-business
```

Optionally with context:

```text
/onboard-business We run a small candle studio, mostly wholesale plus a web shop. I want
help figuring out where to start.
```

This command should:

1. check for an existing business map under `intake/processed/` and an existing
   architecture inventory, and choose the mode:
   - **first run**: no map exists; run the full interview
   - **re-run**: a map exists; confirm what still holds, interview only the delta, and
     diff recommendations against the architecture that already exists
2. run the interview per [[skill-interview-business]]: plain language, one question at a
   time, phase playbacks, business map written to
   `intake/processed/<date>-business-map.md`
3. produce the bounded recommendation set per [[skill-recommend-architecture]]: at most
   one department, three namespaces, three workflows, with a parked Later list and a
   non-empty do-not-build-yet list, every item quoting the person's own words; when the
   interview surfaced a real signal, the set may close with an optional tooling note
   (Obsidian, n8n, Paperclip) pointing to `docs/local-tooling-setup.md`, outside the
   ceiling and never pushed
4. present the set and let the person accept a subset; nothing is scoped without an
   explicit acceptance
5. hand the accepted subset to [[workflow-onboard-business-architecture]], which creates
   one project per accepted item and generates a launchable swarm sprint folder for each,
   then tells the person exactly how to launch each sprint in a new terminal
6. leave the run record in `outputs/`

The command is thin on purpose: the interview method lives in the skill, the judgment
lives in the skill, the scoping lives in the workflow. This file only wires them.
