---
# Claude Code command keys
# (no special primitives beyond the file location)

# Infinite Brain keys
id: command-create-namespace
aliases: ["command-create-namespace", "create-namespace"]
type: command
namespace: canon-system-ontology
summary: "Slash command that creates a new namespace file under _system/namespaces/ in the personal repo, with lifecycle_state: scratch."
auto_inject: false
applicable_when: "Use when an operator wants to introduce a new namespace for an active research session, project area, or governance bucket that does not fit any existing namespace."
confidence: 0.9
verified_at: 2026-05-20
verified_by: ai-architect
staleness_signal: "Review if Section 7.6 of INFINITE-BRAIN-V3-SPEC.md changes (namespace file schema or directory structure)."
lifecycle_state: canon
owner_type: company
visibility: workspace
export_class: internal
retrieval_class: normal
tags: [command, namespace, scaffolding, governance]
edges:
  - target: rule-voice-and-style
    type: implements
    weight: 1.0
    note: "Generated namespace file follows the no-em-dash and frontmatter-before-body rules."
  - target: agent-brain-curator
    type: feeds
    weight: 0.8
    note: "Scratch-lifecycle namespaces created by this command are surfaced by the curator for promotion or merge."
related: []
source_url: null
local_path: entities/commands/create-namespace.md
---

# /create-namespace

Create a new namespace file in `_system/namespaces/` with `lifecycle_state: scratch`. Used in personal repos to introduce an ad-hoc namespace for a research session, project area, or governance bucket.

## When to use this

- Starting a new research session that does not fit `research-general` or any other existing namespace.
- Spinning up a project-area namespace that needs its own governance settings.
- Carving out a topic-specific namespace inside a personal repo for future promotion review.

## When NOT to use this

- The need fits an existing canonical namespace. Use the existing one.
- You are in a department or company-canon repo. Open a pull request that adds the namespace file directly; do not create scratch namespaces in canon repos.
- The need is for a topic tag, source channel, or author distinction. Use frontmatter fields (`tags`, `source_channel`, `source_author`) on the affected nodes instead.
- You want to build a real namespace from an existing corpus or source folder. Use `/build-knowledge-base`, which routes through the V2 profile, canon, synthesis, support, and validation machinery.

## How it works

The command prompts the operator for four inputs:

1. **Namespace name (slug)**: kebab-case, e.g., `research-llm-agents-2026`, `project-launch-q4`, `competitor-acme`.
2. **Purpose**: a one-line statement of what this namespace covers.
3. **Group**: one of `operations`, `research`, `product`, `competitive-intel`, `personal`, or a new group documented in the answer.
4. **Owner**: the operator's handle (defaults to the personal repo owner).

The command then:

1. Verifies the slug does not already exist in `_system/namespaces/` (collision check).
2. Writes `_system/namespaces/{slug}.md` with the required frontmatter and a stub body.
3. Appends a row to `_system/namespaces/INDEX.md` under the catalog table and under the relevant by-group section.
4. Reports the file paths created or modified and reminds the operator to run `bash _system/validate.sh` if validate.sh is installed in this personal repo.

## Body template

The generated namespace file uses this body template:

```markdown
---
id: namespace-{slug}
name: {slug}
purpose: "{purpose}"
owner: {owner}
lifecycle_state: scratch
created: {today}
group: {group}
retrieval_class: explicit
export_class: internal
default_visibility: private
tags: [namespace, scratch]
supersedes: null
notes: "Created via /create-namespace. Promote to candidate when the namespace stabilizes."
---

# {slug}

## Summary

{purpose}

## Defaults

| Field | Default |
|-------|---------|
| `lifecycle_state` on nodes | `scratch` or `research` |
| `retrieval_class` on nodes | `explicit` |
| `export_class` on nodes | `internal` |

## Use for

(operator fills in)

## Do not use for

(operator fills in)

## Promotion path

When this namespace stabilizes, promote it from scratch to candidate by opening a pull request against the appropriate department or company-canon repo. The brain-curator agent surfaces aged scratch namespaces for review.

## Notes

Created by /create-namespace on {today}.
```

## Edge cases

- **Collision with an existing namespace**: the command refuses to overwrite and prompts for a different slug.
- **Slug contains uppercase letters or spaces**: the command lowercases and slugifies before checking.
- **Group not in the default list**: the command accepts any non-empty string and prompts the operator to add a by-group section to INDEX.md if the group is brand new in this repo.
- **`_system/namespaces/` does not exist**: the command creates it along with a fresh INDEX.md, using the canon-template's INDEX.md format as the seed.
- **INDEX.md does not exist**: the command creates it with a fresh catalog and an entry for the new namespace.

## Evidence

Derived from Section 7.6 of `INFINITE-BRAIN-V3-SPEC.md` (revision 5, PKM-10). The personal-repo scratch lifecycle for ad-hoc namespaces is the entry point for namespace creation; canon promotion is a separate pull request flow.

## Edges

`feeds: agent-brain-curator` because scratch-lifecycle namespaces created here are exactly what the curator agent surfaces for promotion or merge review.

`implements: rule-voice-and-style` because the generated namespace file body respects the no-em-dash rule and the frontmatter-before-body rule.

## Notes

The command is intentionally minimal: it does not auto-generate the body content beyond a stub. Operators are expected to populate the use/do-not-use sections by hand so the namespace policy reflects their actual intent.
