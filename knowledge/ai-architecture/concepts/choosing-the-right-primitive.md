---
id: "choosing-the-right-primitive"
aliases: ["choosing-the-right-primitive", "primitive-selection", "workflow-vs-surface-vs-tool"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "The decision discipline for choosing among the OS primitives when building application logic: tool versus workflow versus surface versus agent versus skill. Prefer the lowest-power primitive that fits, compose rather than invent, and keep surfaces thin. Prevents structural churn of the core primitives."
confidence: 0.86
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[apps-decompose-into-primitives]]"
    relation: "supports"
    confidence: 0.92
  - target: "[[surface-classes]]"
    relation: "depends_on"
    confidence: 0.9
  - target: "[[entity-tools]]"
    relation: "depends_on"
    confidence: 0.88
  - target: "[[deterministic-workflow-boundary]]"
    relation: "depends_on"
    confidence: 0.88
  - target: "[[core-doctrine]]"
    relation: "derived_from"
    confidence: 0.85
created: "2026-06-03"
---

# Choosing the Right Primitive

## Why this exists

When agents build application logic they keep reaching to invent or reshape a primitive, which
churns the core structure. The fix is a stable selection discipline: there is almost always an
existing primitive that fits, and the right move is to compose the existing ones, not add a new
type. This node is the decision guide. Its operative distillation is
`_system/primitive-selection-rules.md`.

The five candidates and their essence, each a different posture:

- **Tool**: a bounded capability with a stable interface. One verb that does one thing reliably,
  called by others. The leaf. (`tools/`, per [[entity-tools]].)
- **Deterministic workflow**: a fixed multi-step flow with no judgment. The sequencer for
  mechanical work. (`automations/n8n/`, per [[deterministic-workflow-boundary]].)
- **Agentic workflow**: a multi-step procedure that needs judgment between steps. The reasoning
  pipeline. (`workflows/`.)
- **Agent**: a role that exercises ongoing judgment over a scope. The decider, invoked across
  contexts. (`entities/agents/`.)
- **Skill**: a reusable technique an agent applies in a session. The how-to. (`entities/skills/`.)
- **Surface**: a thin interface that projects the truth plane and lets a human or agent view and
  interact, triggering the others. The window and the trigger, never the logic, per
  [[surface-classes]]. (S1 to S5.)

## The dividing lines (the crux)

The distinctions are about posture toward the work, not domain.

- **Tool versus workflow.** A tool is one bounded capability with a stable input and output. A
  workflow sequences several steps. If it orchestrates other primitives, it is a workflow. If it
  is a single verb you would reuse, it is a tool. "Render this email", "slice this email-platform export"
  are tools; "build a campaign end to end" is a workflow.
- **Deterministic versus agentic workflow.** If every step is mechanical and the outcome is fixed
  given the input, it is deterministic (n8n, shell, a validator). If a step needs judgment, a
  read-and-decide, or model reasoning, it is agentic.
- **Workflow versus surface.** A workflow is the logic; a surface is the interface. A surface never
  contains the orchestration. It triggers a workflow and shows the result. If a human watches,
  clicks, or composes, it is a surface; if steps run, it is a workflow.
- **Tool versus surface.** A tool is called and returns; it has no UX. A surface is interacted with
  and stays thin. A capability with a stable interface is a tool even if a surface later calls it.
- **Runtime plane versus tool.** Runtime state itself is not typed as a primitive; it is part of
  the surface boundary. The bounded capability that serves, mutates, or exposes that runtime
  substrate to the surface is often a tool. A local review-state bridge or slice-export bridge is a
  tool; the review state itself is runtime-plane state.
- **Agentic workflow versus agent.** A workflow is a defined procedure with a start and an end. An
  agent is a standing role with judgment, invoked from many contexts and often from inside a
  workflow. If you are describing a sequence, it is a workflow; if you are describing a role that
  decides, it is an agent.
- **Skill versus agent.** A skill is a technique applied in-session; an agent is the actor that
  applies skills and calls tools. Skills are how-to; agents are who.

## The decision order: prefer the lowest power that fits

Walk down this list and stop at the first that fits. Lower-power primitives are cheaper, more
reusable, and easier to keep stable.

1. Is it durable data or meaning? Use a **namespace node** (`knowledge/<ns>/`).
2. Is it one bounded capability with a stable interface, reused by callers? Use a **tool**.
3. Is it a fixed multi-step flow with no judgment? Use a **deterministic workflow**.
4. Is it a multi-step procedure that needs judgment between steps? Use an **agentic workflow**.
5. Is it a reusable technique an agent applies in-session? Use a **skill**.
6. Is it a standing role that exercises judgment over a domain? Use an **agent**.
7. Is it how a human or agent views and interacts with the truth? Use a **surface** (the thinnest
   S-class that fits), and let it trigger the primitives above.

If nothing fits, the answer is still almost never a new primitive type. It is a composite: a custom
tool for the irreducible capability plus a thin surface on top. Inventing a twelfth entity type is
the last resort and is an operator decision, not an agent decision.

## How they compose: the stack

The primitives stack from truth at the bottom to interface at the top. Each layer calls down, never
up, and durable change always returns through a visible git promotion event.

```text
        Surface (thin UX, S1 to S5)            <- a human or agent views and triggers
            |  embeds an S4 runtime (Claude Code or Codex)
            v
   Agentic workflow  /  Agent                  <- orchestration and judgment
            |  invokes skills, calls tools
            v
   Deterministic workflow  /  Tool             <- fixed flows and bounded capabilities
            |  reads and writes through promotion
            v
        Namespace nodes (knowledge/<ns>/)      <- the truth plane
```

Worked reading: a CRM "compose and send a campaign" action lives in a thin S3 composer surface. The
operator clicks send. The embedded S4 runtime triggers the `email-campaign-build` agentic workflow,
which invokes the copywriter and reviewer agents (judgment), which call the email-linter and
figma-export tools (bounded capabilities), all reading the `email-campaign-production` and
`drift-brand` namespaces. The surface shows the result and stages the durable change as a git
promotion. No part of that logic lives in the surface; the surface only renders and triggers.

Second worked reading: a CRM review surface owns runtime-plane state such as reviewer identity,
comment threads, approval-in-flight status, and selected gallery context. That state is not a new
primitive and does not belong in git canon. The repo-native bridge that serves that substrate,
returns generated artifacts, exports slices, or prepares a Figma handoff is a Tool, because it is a
bounded capability with a stable interface. The surface stays interactive and thin; the bridge tool
stays bounded.

## Anti-patterns that change the primitives (do not do these)

- Putting orchestration or business logic in a surface. Surfaces stay thin; the logic goes to a
  workflow, agent, or tool that the surface triggers.
- Building a tool that orchestrates other primitives or exercises judgment. That is a workflow or an
  agent. A tool is one bounded verb.
- Wrapping a single capability as a workflow. If there is one step, it is a tool.
- Building a per-app surface backend or model server. A surface that needs a chat embeds an S4
  Claude Code or Codex runtime instead, per [[surface-classes]].
- Reifying runtime state as its own primitive type. Runtime state is already accounted for by the
  surface boundary; package access to it as a bounded tool if a stable bridge is needed.
- Inventing a new entity type to avoid a composite. Compose a custom tool plus a thin surface first.

## Output linkage

This concept drives the primitive-selection contract in `_system/primitive-selection-rules.md`, the
CRM-as-primitives proof program, and any future application-as-primitives build. It is the guard
that keeps the eleven entity types and the five surface classes stable as the OS absorbs more apps.
