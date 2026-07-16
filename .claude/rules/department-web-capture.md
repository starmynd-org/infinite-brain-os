---
id: "rule-department-web-capture"
aliases: ["rule-department-web-capture", "department-web-capture"]
type: "Rule"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Any agent in any session watches the conversation for department-web capture candidates (SOPs, automations, agent architecture, structured knowledge, metrics) and documents them as typed stubs in the owning department's capture inbox, without blocking the conversation and without silently building them."
confidence: 0.84
retrieval_class: "domain"
export_class: "internal"
description: "Apply in every session, not only department-head sessions. While conversing, watch for department-web capture candidates: a described manual process (candidate SOP), a repeated friction or rules-based task (candidate automation), a repeated judgment or orchestration task (candidate skill, agent, agent workflow, or loop), a durable fact or decision (candidate structured knowledge), or a metric someone wants to watch (candidate KPI). Record each as a typed stub in departments/<slug>/capture/ (or root intake/ when the owner is unclear) and continue. Never block the conversation, never silently build, and never route a capture into canon or an external action."
edges:
  - target: "[[department-web]]"
    relation: "implements"
    confidence: 0.92
  - target: "[[choosing-the-right-primitive]]"
    relation: "depends_on"
    confidence: 0.86
  - target: "[[rule-result-and-escalation-contract]]"
    relation: "depends_on"
    confidence: 0.85
created: "2026-06-15"
---

# Rule: Department Web Capture

The department web (`[[department-web]]`) only grows if raw signal is captured at the moment it
appears, and most signal appears in conversation, not in intake. This rule makes capture
ambient: any agent in any session, not only department heads, watches the conversation and
documents capture candidates as the operator talks through issues. Capture is a side-effect of
every chat, never a separate task the operator has to remember to start.

## What counts as a capture candidate

When the operator or another agent surfaces, even in passing:

- a recurring or manual process being described: candidate **SOP**
- a repeated friction or "I always have to..." moment: candidate **SOP** or **automation**
- a deterministic, rules-based, stable task: candidate **n8n automation**
- a judgment task done repeatedly: candidate **skill** or **agent**
- a multi-step orchestration: candidate **agent workflow** or **loop**
- a durable fact, decision, or model: candidate **structured knowledge** (a namespace node)
- a number someone wants to watch: candidate **metric / KPI**

These are exactly the slots of the department web. Recognizing one is recognizing a capture
event.

## What to do with a candidate

- **Capture, do not build.** Capture is not execution. Recording a candidate is the whole job
  of this rule.
- **Write a typed stub** into the owning department's capture inbox, `departments/<slug>/capture/`.
  If the owning department is unclear, write to the root `intake/` fabric instead. The stub
  records: what was said, the inferred candidate type, the owning department (or `unrouted`),
  and the source.
- **Do not block.** Capture is a side-effect. Continue the conversation; never stall it to file
  a candidate.
- **Promotion is a separate, gated step.** Converting a candidate into a built asset follows
  `[[choosing-the-right-primitive]]`, and any build that is `external` or `canon-touching`
  escalates through `[[rule-result-and-escalation-contract]]` and `[[rule-surfacing-policy]]`.

## Discipline

- **Conservative and additive.** When unsure whether something is a candidate, capture it. A
  noisy capture inbox is cheaper than lost signal.
- **Record the signal, not a finished artifact.** The convert and build steps are separate and
  may be deferred.
- **Never route a capture straight into canon or an external action.** Those always escalate.
- **Runtime versus contract.** Live capture queues belong to the operational substrate; git
  holds the durable candidate records and their receipts, per the Paperclip boundary.
