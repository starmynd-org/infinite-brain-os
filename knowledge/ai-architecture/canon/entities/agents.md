---
id: "knowledge-ai-architecture-canon-entity-agents"
aliases: ["knowledge-ai-architecture-canon-entity-agents", "ai-architecture-entity-agents", "entity-agents"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Canon for the Agent entity: a bounded specialist worker that owns a recurring reasoning task, with clear triggers, ordered behavior, declared tools, and governance-safe limits."
confidence: 0.9
retrieval_class: "domain"
export_class: "internal"
verified_at: "2026-05-31"
verified_by: "operator-pending"
edges:
  - target: "[[system-overview]]"
    relation: "part_of"
    confidence: 0.9
  - target: "[[core-doctrine]]"
    relation: "derived_from"
    confidence: 0.88
  - target: "[[skills]]"
    relation: "related_to"
    confidence: 0.82
  - target: "[[workflows]]"
    relation: "related_to"
    confidence: 0.82
created: "2026-05-31"
---

## What it is

An **Agent** is a bounded specialist worker that owns one recurring reasoning task. It is a
Markdown subagent definition with a narrow job, explicit trigger conditions, the minimum
tools it needs, ordered behavior steps, and declared constraints and fail conditions.
Claude Code loads agents as subagents through `.claude/agents/`; Codex loads them through
`.codex/agents/`. An agent reasons; it is not a deterministic script and not a vague
personality wrapper.

## When to use it (and when not)

Use an agent when one bounded worker should own a recurring reasoning pattern, the task is
not deterministic enough for a plain workflow, and the behavior needs a stable reusable
contract. Do not use an agent when a short one-off task can be done manually, when the work
is really a reusable method (that is a [[skills|skill]]), when a deterministic sequence is
enough (that is a [[deterministic-workflows|deterministic workflow]]), or when the work
needs several coordinated lanes (that is a swarm-backed [[projects|project]]). An agent
that silently edits too much, or pretends to be single-pass when it really needs a swarm,
is mis-scoped.

## Required shape

- **Folder**: canonical at `entities/agents/<name>.md`, mirrored into `.claude/agents/`
  and `.codex/agents/` by symlink or `sync-adapters.sh`. Never hand-edit the adapter
  copies.
- **Frontmatter**: standard node fields plus `id: agent-<slug>`, `type: "Agent"`, `name`
  (the short runtime name), `description` (what the agent does), and `tools` (only the
  tools it truly needs). `retrieval_class` is usually `identity` for a named worker.
- **Body sections**: `## When to use this agent`, then `## Behavior` with numbered
  `### Step 1`, `### Step 2`, then `## Constraints` (non-goals and fail conditions). State
  the narrow job in one sentence first.

## How it relates to the other entity types

An agent applies [[skills]], obeys [[rules]], reads [[knowledge-nodes]] and [[tools]], runs
inside [[workflows]] when orchestration is needed, and writes [[output-nodes]] and
[[memory-nodes]]. A [[workflow-loops|workflow loop]] uses an agent as its bounded worker or
coordinator. Maintenance agents (curators, linters, freshness reviewers) are thin wrappers
over deterministic checks plus genuinely fuzzy review, with a bounded job and a
profile-scoped cadence.

## Governing rules and doctrine

The operative rules for agents (frontmatter keys, adapter mirroring, the curator pattern)
live in `_system/` and are enforced by `validate.sh`; the `_system`-versus-doctrine split
is in [[system-vs-doctrine-boundary]]. The reasoning that an agent may recommend but may
never bypass a human gate, and that runtime state stays in the operational substrate, is in
[[core-doctrine]] (the control model and the PM-agent posture). See [[system-overview]] for
how agents sit in the entity set.
