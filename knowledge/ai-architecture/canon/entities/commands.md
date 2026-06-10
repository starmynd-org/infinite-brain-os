---
id: "knowledge-ai-architecture-canon-entity-commands"
aliases: ["knowledge-ai-architecture-canon-entity-commands", "ai-architecture-entity-commands", "entity-commands"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Canon for the Command entity: a direct-invocation operator shortcut with a stable intent, defined invocation, inputs, and fail conditions, that never silently performs broad mutation."
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
    confidence: 0.8
  - target: "[[rules]]"
    relation: "related_to"
    confidence: 0.8
created: "2026-05-31"
---

## What it is

A **Command** is a direct-invocation shortcut with a stable intent: a slash command an
operator runs to trigger a known behavior. It is a Markdown file with dual frontmatter
(the Infinite Brain node fields plus a `description`). The `.claude/commands/` and
`.codex/commands/` adapters load it. A command is the invocation surface for a behavior; it
is not the reusable method behind it and not a policy.

## When to use it (and when not)

Use a command when an operator needs a stable, named shortcut to invoke a behavior whose
intent does not change between runs. Do not use a command when the behavior is a reusable
technique (that is a [[skills|skill]]), a multi-step execution recipe (that is a
[[workflows|workflow]]), or a cross-cutting constraint (that is a [[rules|rule]]). A
command that silently performs broad mutation behind a simple name is a defect: the
invocation must make its scope and side effects visible.

## Required shape

- **Folder**: canonical at `entities/commands/<name>.md`, mirrored into `.claude/commands/`
  and `.codex/commands/` by symlink or `sync-adapters.sh`. Never hand-edit the adapter
  copies.
- **Frontmatter**: standard node fields plus `id: command-<slug>`, `type: "Command"`, and a
  `description`. `aliases` when id differs from filename.
- **Body**: define the invocation, the inputs it accepts, what it does, and its fail
  conditions. Keep the shortcut separate from any policy it touches, and state when another
  entity type should be used instead.

## How it relates to the other entity types

A command is the front door an operator uses to run a [[skills|skill]], a
[[workflows|workflow]], or an [[agents|agent]]; it wraps invocation, it does not contain the
logic. It differs from a [[rules|rule]], which is always-on policy rather than an
on-demand trigger. The decision between a command and a rule is one skill
(`build-command-and-rule`): choose a command for an invocation shortcut, a rule for a
cross-cutting constraint.

## Governing rules and doctrine

The operative rules for commands (dual frontmatter, id and alias form, adapter mirroring)
live in `_system/` (`stable-id-and-alias-rules`) and are propagated by `sync-adapters.sh`;
the `_system`-versus-doctrine split is in [[system-vs-doctrine-boundary]]. The reasoning
that adapters are replaceable surfaces over durable git canon, so a command never becomes a
hidden second source of truth, is in [[core-doctrine]]. See [[system-overview]] for how
commands sit in the entity set.
