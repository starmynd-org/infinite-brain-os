---
id: "skill-build-agent"
aliases: ["skill-build-agent", "build-agent"]
type: "Skill"
namespace: "personal-operator"
lifecycle_state: "research"
summary: "Build a bounded specialist agent that has clear trigger conditions, behavior steps, and governance-safe limits."
confidence: 0.92
retrieval_class: "domain"
export_class: "internal"
description: "Use this skill when a recurring reasoning task deserves its own specialist agent in entities/agents/."
edges:
  - target: "[[skill-shape-ai-work]]"
    relation: "paired_with"
    confidence: 0.8
created: "2026-05-29"
---

# build-agent

Use this skill to create a new specialist agent under `entities/agents/`.

## Use when

- one bounded worker should own a recurring reasoning pattern
- the task is not deterministic enough for a plain workflow
- the behavior needs a stable reusable contract

## Do not use when

- a short one-off task can be handled manually
- the work is really a reusable method, which should be a skill
- the work needs several coordinated lanes, which should be a swarm or sprint

## Build steps

1. State the agent's narrow job in one sentence.
2. List the trigger conditions.
3. List the tools the agent truly needs.
4. Write the behavior as ordered steps.
5. Add constraints, non-goals, and fail conditions.
6. Add links to governing skills or rules where relevant.
7. Create the canonical file under `entities/agents/`, then mirror it into the adapters: symlink it into `.claude/agents/` and `.codex/agents/`, or run `bash sync-adapters.sh` at the repo root. Never hand-edit the adapter copies.

## V2 awareness

- The canonical agent lives under `entities/agents/`; the `.claude/` and `.codex/` copies are adapter mirrors propagated by `sync-adapters.sh`. Edit the canonical file only.
- A new maintenance agent should follow the curator pattern: thin wrapper over deterministic checks plus genuinely fuzzy review, with a bounded job and a profile-scoped cadence. See the V2 curator fleet [[namespace-curator]], [[canon-editor]], [[corpus-synthesizer]], [[freshness-reviewer]], [[namespace-linter]], and [[intake-router]] for the shape these take.
- Cross-link to doctrine and operative schema rather than restating either: `ai-architecture` holds the why (for example [[correction-loop-absorption]], [[namespace-profiles]]) and `_system` holds the operative rules (for example [[correction-loop-rules]], [[namespace-lint-rules]]).

## Output contract

Create `entities/agents/{name}.md` with:

- full frontmatter
- `name`
- `description`
- `tools` if applicable
- “when to use”
- behavior steps
- constraints

## Quality checks

- one sentence exists that explains when another entity type is better
- the agent has a bounded job, not a mini department
- hidden assumptions about sibling repos or secrets are spelled out
- `bash _system/validate.sh` passes after creation

## Anti-patterns

- agent as vague personality wrapper
- agent that silently edits too much
- agent that requires a swarm but pretends to be single-pass

