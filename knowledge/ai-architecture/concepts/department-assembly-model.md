---
id: "knowledge-ai-architecture-department-assembly-model"
aliases: ["knowledge-ai-architecture-department-assembly-model", "department-assembly-model", "ai-department-model"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "A department is a first-class operating assembly over existing entity types, not a new low-level entity primitive. It groups intake, knowledge, workflows, agents, tools, metrics, and humans around one business function."
confidence: 0.91
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[ai-shadow-departments]]"
    relation: "implements"
    confidence: 0.92
  - target: "[[system-overview]]"
    relation: "supports"
    confidence: 0.86
  - target: "[[intake-fabric-namespace]]"
    relation: "depends_on"
    confidence: 0.9
created: "2026-05-31"
---

# Department Assembly Model

## Summary

A department is the operating assembly that turns the Infinite Brain from a graph of parts
into a functioning business unit. It is not a new low-level entity type like `skill`,
`agent`, or `workflow`. It is a structured grouping of those existing types around one
business function.

## Content

The unit that creates business ROI is not a single agent or workflow. It is a department-sized
assembly that can receive inputs, reason over its own knowledge, run recurring execution,
produce outputs, and escalate exceptions to a thin human layer.

That assembly should be explicit in the OS. The recommended physical home is a root
`departments/` layer, because the department is not itself a knowledge namespace. It is a
cross-entity operating surface that points at namespaces, agents, skills, workflows, tools,
metrics, projects, and human review gates.

Each department should have:

- a department index or start-here guide
- a head-of-department agent
- its own intake sources and routing doctrine
- one or more supporting knowledge namespaces
- the recurring workflows and deterministic automations it runs
- the skills and tools its agents use
- the metrics by which the department is judged
- a human review layer for high-stakes or exception work
- a daily update that rolls into a wider brief

## Why this is not a new entity type

The department is an assembly, not a primitive. Making it a primitive too early would blur the
existing ontology and encourage duplicative metadata everywhere. The durable truths still live
where they already belong:

- doctrine in `knowledge/`
- executable techniques in `entities/skills/`
- specialist workers in `entities/agents/`
- recurring execution in `workflows/`
- deterministic subflows in `automations/`
- live inflow at root `intake/`

The department layer exists to make the assembly legible and operable.

## Department heads and subdepartments

Each department should default to one head-of-department agent. That agent is the orchestration
and accountability surface for the function. It does not have to do every task itself. It may
delegate to specialist agents, workflows, or swarms, but it owns the department's first pass,
daily update, and escalations.

Subdepartments are allowed when one function is too broad. They should be expressed as nested
assemblies inside the department layer, not as a forked ontology. The parent department keeps
the shared goals, rollup, and review posture; subdepartments own narrower execution surfaces.

## Notes

This concept recommends a root `departments/` assembly layer with per-department indexes. It
does not require adding a mandatory `department:` field to every node yet. Link-first assembly
is enough for V1.
