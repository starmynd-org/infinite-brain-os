---
id: "skill-build-workflow"
aliases: ["skill-build-workflow", "build-workflow"]
type: "Skill"
namespace: "personal-operator"
lifecycle_state: "research"
summary: "Build a repeatable workflow that preserves deterministic steps, handoffs, and output expectations without pretending to be a full runtime."
confidence: 0.91
retrieval_class: "domain"
export_class: "internal"
description: "Use this skill when a repeatable sequence of steps or handoffs should be documented under workflows/."
edges: []
created: "2026-05-29"
---

# build-workflow

Use this skill to create or revise a workflow under `workflows/`.

## Use when

- the same sequence will recur
- the steps and handoffs are stable enough to encode
- operational consistency matters more than open-ended exploration

## Do not use when

- one specialist agent can do the whole job
- the work is too ambiguous and needs project or swarm packaging

## Build steps

1. Name the trigger.
2. List inputs and preconditions.
3. Write ordered steps.
4. Mark human approvals or checkpoints explicitly.
5. State outputs and completion criteria.

## Quality checks

- every step has a reason
- approvals are visible
- the workflow does not masquerade as policy

## V2 awareness

- Agentic workflows live canonically under `workflows/` and have no adapter mirror, so there is nothing to sync. Skills and agents do mirror into `.claude/` and `.codex/` via `sync-adapters.sh`; never hand-edit those copies.
- A new maintenance workflow chains curator agents into a scoped review and should follow the curator pattern. See the V2 review pipelines [[namespace-intake-review]], [[monthly-canon-review]], [[namespace-lint-review]], and [[contradiction-and-gap-review]] for the shape these take.
- Cross-link to doctrine and operative schema rather than restating either: `ai-architecture` holds the why (for example [[retrieval-over-raw-memory]], [[process-namespace-intake]]) and `_system` holds the operative rules (for example [[retrieval-load-order-policy]], [[namespace-intake-rules]]).

