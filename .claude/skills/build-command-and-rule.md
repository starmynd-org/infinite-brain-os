---
id: "skill-build-command-and-rule"
aliases: ["skill-build-command-and-rule", "build-command-and-rule"]
type: "Skill"
namespace: "personal-operator"
lifecycle_state: "research"
summary: "Build direct-invocation commands and cross-cutting rules without confusing shortcuts, policy, and runtime behavior."
confidence: 0.9
retrieval_class: "domain"
export_class: "internal"
description: "Use this skill when deciding whether a behavior should become a command, a rule, or neither, and then drafting the right artifact."
edges: []
created: "2026-05-29"
---

# build-command-and-rule

Use this skill when a new operator shortcut or normative constraint is needed.

## Decision rule

- choose **command** for a direct invocation shortcut with a stable intent
- choose **rule** for a cross-cutting policy or behavioral constraint

## Do not use when

- the behavior is a reusable method, which should be a skill
- the behavior is a multi-step execution recipe, which should be a workflow

## Build steps

1. Classify as command or rule.
2. For commands, define invocation, inputs, and fail conditions.
3. For rules, define the governed scope and the normative statement.
4. Keep policy and procedure separate.

## Output contract

- commands go under `entities/commands/`, then mirror into `.claude/commands/` and `.codex/commands/`
- rules go under `entities/rules/`, then mirror into `.claude/rules/`; there is no Codex rule adapter, so Codex reads rule content via `AGENTS.md`
- create the adapter mirrors by symlink, or run `bash sync-adapters.sh` at the repo root; never hand-edit the adapter copies

## Quality checks

- command does not silently perform broad mutation
- rule reads as stable doctrine, not a temporary note
- the artifact states when another entity type should be used instead

## V2 awareness

- The canonical command or rule lives under `entities/`; the `.claude/` and `.codex/` copies are adapter mirrors propagated by `sync-adapters.sh`. Edit the canonical file only.
- A new V2 structural rule should land as an operative file in `_system/` and be enforced deterministically in `validate.sh` in the same wave it becomes doctrine. A cross-cutting behavioral constraint stays a `Rule` under `entities/rules/`. Keep the operative `_system` rule and the why distinct: `ai-architecture` holds the reasoning, `_system` holds the checkable rule.
- Cross-link to doctrine and operative schema rather than restating either: see [[namespace-linting]] and [[namespace-lint-rules]] for the deterministic-versus-fuzzy split, and [[stable-id-and-alias-rules]] for id and alias constraints.

