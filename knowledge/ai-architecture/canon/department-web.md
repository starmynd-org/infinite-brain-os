---
id: "knowledge-ai-architecture-canon-department-web"
aliases: ["knowledge-ai-architecture-canon-department-web", "department-web", "ai-shadow-department-web"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "A department is a living web that captures raw knowledge and converts it into either structured knowledge or built capability (SOPs, deterministic automations, and agent architecture), then operates that capability and feeds what it learns back into capture. The assembly is the snapshot; the web is the motion. Because the web shape is named, any agent in any session watches conversation for capture candidates and documents them."
confidence: 0.85
retrieval_class: "identity"
export_class: "internal"
verified_at: "2026-06-15"
verified_by: "operator-pending"
edges:
  - target: "[[department-model]]"
    relation: "extends"
    confidence: 0.92
  - target: "[[department-assembly-model]]"
    relation: "extends"
    confidence: 0.9
  - target: "[[choosing-the-right-primitive]]"
    relation: "depends_on"
    confidence: 0.88
  - target: "[[rule-department-web-capture]]"
    relation: "produces"
    confidence: 0.9
  - target: "[[intake-fabric-namespace]]"
    relation: "depends_on"
    confidence: 0.85
created: "2026-06-15"
---

## Read this first

`department-model.md` says a department is an operating assembly over the ontology. This doc
says how that assembly comes to exist and stays alive. A department is a web: it captures raw
knowledge, converts it into either structured knowledge or built capability, runs that
capability, and feeds what it learns back into capture. The assembly is the snapshot of what
the web has built so far. The web is the motion that keeps building it. A department that
cannot capture and convert is a static folder, not an operating unit.

## 1. The department is a capture-to-build web

The earlier docs answer "what is a department made of." This one answers "how does a
department grow and maintain itself." The answer is a single repeating loop, owned by the
department head but fed by everyone:

1. **Capture.** Raw signal enters: a described process, a pain point, a decision, a fact, a
   desired outcome. It arrives through intake, but also, and mostly, through conversation.
2. **Convert.** Each captured item is routed to one of two destinations (section 2).
3. **Build.** The department materializes whatever the conversion identified: it writes the
   knowledge, authors the SOP, builds the automation or the agent architecture.
4. **Operate.** The built capability runs first-pass, produces outputs, emits metrics, and
   escalates exceptions to the thin human layer.
5. **Feed back.** What operation reveals (a gap, a failure, a better procedure) becomes new
   captured signal. The web closes and repeats.

This is the operative form of the autonomous-improvement and correction-absorption loops,
scoped to one business function.

## 2. Conversion has exactly two destinations

Every captured item converts into either **structured knowledge** or a **built action**. The
choice follows `[[choosing-the-right-primitive]]`.

- **Structured knowledge** when the signal is a durable truth, model, or decision: it lands in
  a `knowledge/<namespace>/` node (doctrine, decision, concept) or a metric definition. This is
  what the department reasons *from*.
- **A built action** when the signal is something the function should *do*. Actions take four
  shapes:
  - **SOP**: a templated, repeatable procedure, runnable by a human or an agent.
  - **Deterministic automation**: an n8n workflow, when the task is rules-based and stable.
  - **Agent architecture**: a skill, an agent, an agent workflow, or a loop, when the task needs
    judgment or orchestration.

The two destinations preserve the standing separation: durable reasoning stays in
`knowledge/`; the operating capability is assembled by the department. Doctrine is never
stored in `departments/`.

## 3. The build target is the whole function

The web does not stop at capturing and filing. Its purpose is to build everything the function
needs to run AI-first: the SOP library, the automations, the agents and their loops, the
metrics, and the operating docs that bind them. A department is "real" to the degree its web
has built enough capability to take input, act, and escalate without a human as the first
bottleneck.

## 4. Ambient capture: every conversation is an intake surface

The leverage of naming the web is this: capture stops being a special mode and becomes an
ambient posture. Because every agent knows the web's slots (SOP, automation, agent
architecture, knowledge, metric), any agent in any session watches the conversation for
capture candidates and documents them as the operator talks through issues. A described manual
process is a candidate SOP. A repeated friction is a candidate automation. A durable fact is a
candidate knowledge node. The agent records the candidate into the owning department's capture
inbox and continues; it does not silently build it. The behavioral contract is
`[[rule-department-web-capture]]`.

## 5. Where the web's parts physically live

| Web stage | Repo home |
|---|---|
| Capture inbox | `departments/<slug>/capture/` (or root `intake/` when the department is unclear) |
| Structured knowledge | `knowledge/<namespace>/` |
| SOP library | `departments/<slug>/sops/` |
| Deterministic automations | `automations/n8n/` (paired `.md` node per flow) |
| Agent architecture | `entities/skills/`, `entities/agents/`, `workflows/` (agent workflows and loops) |
| Maintained-builds registry | the department `INDEX.md` (what the department keeps current) |
| Operating docs the department owns | `departments/<slug>/` (`INDEX.md`, `CHARTER.md`, `OPERATIONS.md`) |

The department `INDEX.md` is the legible map of what the web has built and maintains. The
assets themselves live in their canonical entity homes, linked from the index, never forked
into the department layer.

## 6. What stays human

Capture is cheap and safe, so it runs ambiently. Conversion and build are not unconditionally
safe. Building or promoting anything `external` or `canon-touching` still escalates through
`[[rule-result-and-escalation-contract]]` and `[[rule-surfacing-policy]]`. The web does the
first pass; humans gate promotion. A capture is never routed straight into canon or an external
action.

## Changelog

- 2026-06-15: initial canon for the department-as-web model: the capture, convert, build,
  operate, feed-back loop; the two conversion destinations; and ambient capture across sessions.
