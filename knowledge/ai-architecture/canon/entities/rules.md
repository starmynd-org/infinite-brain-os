---
id: "knowledge-ai-architecture-canon-entity-rules"
aliases: ["knowledge-ai-architecture-canon-entity-rules", "ai-architecture-entity-rules", "entity-rules"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Canon for the Rule entity: a cross-cutting norm or behavioral constraint read at session start, distinct from a deterministic _system check, that reads as stable doctrine rather than a temporary note."
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
  - target: "[[system-vs-doctrine-boundary]]"
    relation: "aligned_with"
    confidence: 0.85
  - target: "[[commands]]"
    relation: "related_to"
    confidence: 0.8
created: "2026-05-31"
---

## What it is

A **Rule** is a cross-cutting norm or behavioral constraint that applies across the work.
It is a Markdown file with dual frontmatter (node fields plus the rule body) that Claude
Code reads at session start through `.claude/rules/`. Codex consumes rule content via
`AGENTS.md` rather than a dedicated adapter folder, and `.claude/hooks/` may enforce a rule
mechanically. A rule states normative policy that should hold regardless of which task is
running, such as the voice-and-style rule.

## When to use it (and when not)

Use a rule when a constraint should govern many entities and sessions and reads as stable
team-level doctrine. Do not use a rule when the behavior is a reusable method (that is a
[[skills|skill]]), an invocation shortcut (that is a [[commands|command]]), or an execution
recipe (that is a [[workflows|workflow]]). Critically, do not use a Rule entity when the
constraint is mechanically checkable: a new structural rule that the validator can enforce
belongs in `_system/` as an operative file and lands in `validate.sh` in the same wave it
becomes doctrine. A Rule entity carries the behavioral constraints that are not purely
deterministic.

## Required shape

- **Folder**: canonical at `entities/rules/<name>.md`, mirrored into `.claude/rules/` by
  symlink or `sync-adapters.sh`. There is no Codex rule adapter; Codex reads rule content
  through `AGENTS.md`. Never hand-edit the adapter copies.
- **Frontmatter**: standard node fields plus `id: rule-<slug>`, `type: "Rule"`, and the
  rule statement. `aliases` when id differs from filename.
- **Body**: state the governed scope and the normative statement. Keep policy separate from
  procedure, and read as stable doctrine, not a temporary note.

## How it relates to the other entity types

A rule governs the behavior of [[agents]], [[skills]], [[workflows]], and the operator
across sessions, while a [[commands|command]] triggers a behavior on demand. A rule is
distinct from a `_system/` validator check: the rule is the constraint a session reads, the
`_system/` rule plus `validate.sh` is the mechanical enforcement of what is deterministically
checkable. Both can describe the same norm, with the Rule entity holding the behavioral
side and `_system/` holding the checkable side.

## Governing rules and doctrine

The split between a behavioral Rule entity and a deterministic `_system/` check is the
core doctrine here, set out in [[system-vs-doctrine-boundary]]: if changing the text changes
what `validate.sh` accepts, it is operative and belongs in `_system/`; if it changes how an
agent behaves but not what passes the validator, it is a Rule. The deterministic-versus-fuzzy
boundary is reinforced by the namespace-linting reasoning. The portability argument for
keeping rules as plain git files is in [[core-doctrine]]. See [[system-overview]] for how
rules sit in the entity set.
