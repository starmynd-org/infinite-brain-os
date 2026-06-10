---
id: "knowledge-ai-architecture-canon-entity-skills"
aliases: ["knowledge-ai-architecture-canon-entity-skills", "ai-architecture-entity-skills", "entity-skills"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Canon for the Skill entity: a reusable procedural technique an agent applies in a session, with a stable trigger rule, concise steps, and explicit anti-patterns."
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
  - target: "[[agents]]"
    relation: "related_to"
    confidence: 0.82
  - target: "[[commands]]"
    relation: "related_to"
    confidence: 0.8
created: "2026-05-31"
---

## What it is

A **Skill** is a reusable technique an agent applies in a session: a repeatable method
taught to a human or an AI, not a one-time task. It is a Markdown file with a stable
trigger rule, the smallest reliable procedure, and explicit anti-patterns. Claude Code and
Codex load skills as in-session techniques through their adapter folders. A skill is
knowledge about how to do something, not a worker that does it.

## When to use it (and when not)

Use a skill when the same construction or analysis technique will recur, the knowledge is
procedural rather than a single task, and the behavior should be reusable across sessions
and across humans and AIs. Do not use a skill when the artifact is really a
[[workflows|workflow]] (a multi-step execution recipe with handoffs), an [[agents|agent]]
(a bounded worker that owns a recurring reasoning task), or a [[rules|rule]] (a
cross-cutting constraint). A skill that only repeats general good advice, or that dumps
doctrine with no trigger rule, is not a skill.

## Required shape

- **Folder**: canonical at `entities/skills/<name>.md`, mirrored into `.claude/skills/`
  and `.codex/skills/` by symlink or `sync-adapters.sh`. Never hand-edit the adapter
  copies.
- **Frontmatter**: `id: skill-<slug>`, `type: "Skill"`, `namespace`, `lifecycle_state`,
  `summary`, `confidence`, `retrieval_class`, `export_class`, a `description` that states
  when and why to apply the skill, `aliases` when id differs from filename, and `edges`.
- **Body sections**: `## Use when`, `## Do not use when`, `## Goal`, `## Required outputs`,
  `## Build steps`, `## Quality checks`, `## Anti-patterns`. Lead with the trigger rule in
  one sentence and state what the skill produces.

## How it relates to the other entity types

A skill is the reusable method an [[agents|agent]] or a [[workflows|workflow]] invokes; it
is not invoked directly by an operator (that is a [[commands|command]]) and it states no
policy (that is a [[rules|rule]]). A [[workflow-loops|workflow loop]] composes skills for
its design, planning, implementation, and improvement methods. The builder method for
skills is itself a skill (`build-skill`), and `shape-ai-work` is the skill that decides
whether new work should become a skill at all.

## Governing rules and doctrine

The operative rules for skills (id and alias form, adapter mirroring, voice and style) live
in `_system/` (`stable-id-and-alias-rules`, the voice-and-style rule) and the adapter
pattern is enforced by `sync-adapters.sh` and the `_system`-versus-doctrine split in
[[system-vs-doctrine-boundary]]. The reasoning for why durable method lives in git and the
adapters stay replaceable is in [[core-doctrine]] (harness and memory portability). Skills
that maintain the knowledge graph follow the curator pattern. See [[system-overview]] for
how skills sit in the entity set.
