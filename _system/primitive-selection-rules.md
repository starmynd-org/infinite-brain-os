# Primitive Selection Rules

This file is the operative contract for choosing among the OS primitives when building application
logic. Its reasoning lives in `knowledge/ai-architecture/concepts/choosing-the-right-primitive.md`
and the north star in `knowledge/ai-architecture/pillars/apps-decompose-into-primitives.md`. Apply
this contract before creating any tool, workflow, agent, skill, or surface so the core primitives
stay stable.

## Purpose

Use this rule file to answer:

- which primitive a given piece of application work should become
- how the primitives call each other
- what is never allowed, so the eleven entity types and five surface classes do not churn

## The selection ladder

Walk the ladder and stop at the first match. Prefer the lowest-power primitive that fits.

1. Durable data or meaning -> namespace node in `knowledge/<ns>/`.
2. One bounded capability with a stable interface, reused by callers -> Tool in `tools/`.
3. Fixed multi-step flow, no judgment -> deterministic workflow in `automations/n8n/`.
4. Multi-step procedure needing judgment between steps -> agentic workflow in `workflows/`.
5. Reusable technique applied in-session -> Skill in `entities/skills/`.
6. Standing role exercising judgment over a domain -> Agent in `entities/agents/`.
7. How a human or agent views and interacts with the truth -> Surface (the thinnest S-class), which
   triggers the primitives above.

If nothing on the ladder fits, the answer is a composite: a custom tool for the irreducible
capability plus a thin surface on top. A new entity type is an operator decision, never an agent
decision.

## The dividing tests

- Tool versus workflow: one bounded verb is a tool; sequencing other primitives is a workflow.
- Deterministic versus agentic workflow: fixed outcome given input is deterministic; a step needing
  judgment is agentic.
- Workflow versus surface: logic is a workflow; an interface a human watches, clicks, or composes is
  a surface. A surface triggers a workflow, it never contains one.
- Tool versus surface: a tool is called and returns with no UX; a surface is interacted with and
  stays thin.
- Runtime plane versus tool: runtime state is part of the surface boundary, not a primitive. The
  bounded capability that serves or mutates repo-local runtime state is usually a tool.
- Workflow versus agent: a defined start-to-end procedure is a workflow; a standing role that
  decides, often invoked inside a workflow, is an agent.

## The composition contract

Primitives call down the stack, never up. Durable change returns only through a visible git
promotion event.

```text
Surface (thin, S1 to S5; embeds an S4 Claude Code or Codex runtime)
  triggers -> agentic workflow / agent
                invokes -> skill ; calls -> tool / deterministic workflow
                                              reads and writes (via promotion) -> namespace nodes
```

- A surface reads namespaces and triggers workflows, agents, or tools. It owns only view and runtime
  state. It is never the source of truth.
- A surface may depend on a repo-native bridge tool to expose runtime state or deterministic
  execution. That does not make the runtime plane a tool; it means the bridge is the bounded
  capability.
- A workflow orchestrates: it calls tools and deterministic workflows and invokes agents.
- An agent exercises judgment, applies skills, and calls tools. It may run inside a workflow.
- A tool is a leaf capability. It does one bounded thing and is called by surfaces, workflows, or
  agents. It does not orchestrate or judge.
- An embedded S4 runtime (Claude Code or Codex) is the execution backend for any surface that needs
  a chat, a decision, or a write path. No per-app model backend is built.

## Hard rules

- Surfaces stay thin. No orchestration or business logic in a surface; it triggers a primitive.
- Tools stay bounded. A tool that orchestrates or judges is mis-typed; make it a workflow or agent.
- No single-step workflows. One step is a tool.
- No per-surface model backend. Embed an S4 runtime instead.
- No runtime-plane primitive inflation. Keep runtime state in the surface boundary; if a stable
  bridge is needed, package it as a bounded tool.
- No new entity type to dodge a composite. Compose a custom tool plus a thin surface first; a new
  type needs operator approval.
- Custom tools follow the in-repo pattern: implementation in `tools/<name>/`, pointed at by a
  `tools/<name>.md` node, per `knowledge/ai-architecture/canon/entities/tools.md`.

## Deterministic versus curator split for validation

The validator may check that a tool node points at an implementation or external integration, that a
workflow has its companion record, and that a surface declaration carries its nine items. Whether a
given piece of work was typed as the right primitive is a curator and operator judgment, not a
deterministic check.
