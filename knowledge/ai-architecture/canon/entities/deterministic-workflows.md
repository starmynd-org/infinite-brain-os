---
id: "knowledge-ai-architecture-canon-entity-deterministic-workflows"
aliases: ["knowledge-ai-architecture-canon-entity-deterministic-workflows", "ai-architecture-entity-deterministic-workflows", "entity-deterministic-workflows"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Canon for the deterministic Workflow entity: an n8n automation stored as JSON in automations/n8n/, each paired with a companion brain-record Markdown node, used where the work has an explicit trigger and testable success and failure behavior."
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
  - target: "[[deterministic-workflow-boundary]]"
    relation: "bounded_by"
    confidence: 0.9
  - target: "[[workflows]]"
    relation: "related_to"
    confidence: 0.85
created: "2026-05-31"
---

## What it is

A deterministic **Workflow** is an n8n automation: a JSON workflow stored in
`automations/n8n/`, each file paired with a companion Markdown node that is its brain
record. The JSON runs in n8n (the deterministic runtime); the `.md` node describes what the
automation does, its trigger and inputs, and how it binds secrets. This is the entity for
work that runs the same way every time and does not need reasoning.

## When to use it (and when not)

Use a deterministic workflow when the work has an explicit trigger, accepts structured
inputs, can be imported, activated, run, and re-exported without hand editing, and has
testable success and failure behavior. Do not use it when the work depends on open-ended
reasoning, synthesis, or review loops (that is an agentic [[workflows|workflow]] or an
[[agents|agent]]). For hybrid flows, keep the orchestration and review logic in an agentic
workflow and extract only the deterministic subflows here.

## Required shape

- **Folder**: `automations/n8n/<name>.json` plus a paired `automations/n8n/<name>.md`. The
  validator errors if either half of the pair is missing or if the JSON is invalid.
- **JSON**: a runtime-valid n8n workflow. Declare SSH authentication explicitly; webhook
  nodes need a post-activation endpoint probe recorded, since import plus activation alone
  does not prove parity.
- **Companion Markdown**: standard node frontmatter (`type: "Workflow"` family, the brain
  record) describing the trigger, inputs, outputs, and secret references. Secrets are
  referenced, never inlined. When the binding is durable, reference stable `secret_ref.id`
  values from the root `secrets/` registry.

## How it relates to the other entity types

A deterministic workflow is the extracted deterministic subflow of an agentic
[[workflows|workflow]], invoked where determinism is cheap. It references [[tools]] and
secret-reference nodes for its bindings and may write [[data-nodes]] or trigger
[[output-nodes]]. It is governed by the same planning ladder: it hangs off a parent task
and never becomes a [[projects|project]]. A [[workflow-loops|workflow loop]] may use a
deterministic workflow as an evaluator or an action step.

## Governing rules and doctrine

The decision boundary between Markdown and n8n is [[deterministic-workflow-boundary]];
deterministic work runs where determinism is cheap, agentic reasoning runs where judgment
is required, and routing across modes stays visible and human-gated. The JSON-and-Markdown
pairing and the runtime-format contract are enforced operatively by `validate.sh` and the
n8n compatibility rules in `_system/` and `docs/`. The reasoning that deterministic
automations are surfaces bound by safe secret rules is in [[core-doctrine]]. See
[[system-overview]] for how deterministic workflows sit in the entity set.
