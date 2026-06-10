---
id: "skill-build-skill"
aliases: ["skill-build-skill", "build-skill"]
type: "Skill"
namespace: "personal-operator"
lifecycle_state: "research"
summary: "Build a reusable procedural skill with stable trigger rules, concise steps, and explicit anti-patterns."
confidence: 0.93
retrieval_class: "domain"
export_class: "internal"
description: "Use this skill when a reusable technique should be taught to future humans or future AIs as a repeatable method."
edges:
  - target: "[[skill-shape-ai-work]]"
    relation: "paired_with"
    confidence: 0.8
created: "2026-05-29"
---

# build-skill

Use this skill to create a new canonical skill under `entities/skills/`.

## Use when

- the same construction or analysis technique will recur
- the knowledge is procedural, not a one-time task
- the behavior should be reusable by humans and future AIs

## Do not use when

- the artifact is actually a workflow, agent, or rule
- the content is mostly archive notes without a stable trigger rule

## Build steps

1. Write the trigger rule in one sentence.
2. State what the skill produces.
3. Write the smallest reliable procedure.
4. Add quality checks.
5. Add anti-patterns.
6. Link to adjacent entities when useful.
7. Create the canonical file under `entities/skills/`, then mirror it into the adapters: symlink it into `.claude/skills/` and `.codex/skills/`, or run `bash sync-adapters.sh` at the repo root. Never hand-edit the adapter copies.

## V2 awareness

- The canonical skill lives under `entities/skills/`; the `.claude/` and `.codex/` copies are adapter mirrors propagated by `sync-adapters.sh`. Edit the canonical file only.
- A skill that maintains the knowledge graph should follow the curator pattern. See the V2 maintenance skills [[canonize-namespace]], [[refine-namespace-index]], [[lint-namespace]], and [[process-namespace-intake]] for the shape these take.
- Cross-link to the relevant doctrine and operative schema rather than restating either: `ai-architecture` holds the why (for example [[retrieval-over-raw-memory]], [[namespace-profiles]]) and `_system` holds the operative rules (for example [[namespace-profiles]] the registry, [[namespace-lint-rules]]).

## Output contract

Create `entities/skills/{name}.md` with:

- full frontmatter
- short description
- use / do-not-use conditions
- steps
- output contract
- quality checks
- anti-patterns

## Quality checks

- under-specification is avoided
- archive bloat is avoided
- the skill says when to use another entity type instead

## Anti-patterns

- long doctrine dump with no trigger rule
- skill that only repeats general good advice
- skill that mixes policy, PM, and runtime detail without separation

