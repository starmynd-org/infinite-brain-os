---
id: "workflow-design-loop"
aliases: ["workflow-design-loop"]
type: "Workflow"
namespace: "personal-operator"
lifecycle_state: "research"
summary: "Agentic workflow for turning a proposed recurring AI pattern into a loop contract, build plan, and implementation-ready artifact list."
confidence: 0.88
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[agent-loop-architect]]"
    relation: "uses"
    confidence: 0.93
  - target: "[[skill-design-loop]]"
    relation: "uses"
    confidence: 0.94
  - target: "[[skill-plan-loop]]"
    relation: "uses"
    confidence: 0.9
  - target: "[[autonomous-improvement-loops]]"
    relation: "informed_by"
    confidence: 0.9
created: "2026-05-30"
runtime: "agentic"
---

# Workflow: Design Loop

Use this workflow when an operator has identified a possible recurring AI loop and wants
an explicit design before implementation starts.

## When to run

- a team says “this should be autonomous” but the shape is still fuzzy
- a promising workflow may deserve recurrence plus feedback
- a business or personal OS needs a new improvement or standing loop

## Inputs

- the problem statement
- the current project or task context
- any existing workflow, agent, or runtime pattern the loop would extend
- relevant doctrine from [[autonomous-improvement-loops]] and
  [[standing-runtime-failure-posture]]

## Pipeline

### Step 1: Clarify the candidate loop

State what recurs, what changes between iterations, and what the operator hopes the loop
will improve or maintain.

### Step 2: Decide if it is really a loop

Use [[agent-loop-architect]] and [[skill-design-loop]] to decide whether the pattern is:

- a true loop
- a normal workflow
- an agent role
- a rule or playbook problem

If it is not a loop, stop and route to the better entity type.

### Step 3: Produce the loop contract

Define:

- objective
- controlled surface
- evaluator
- state substrate
- stop condition
- human gates
- absorption path

### Step 4: Build the implementation plan

Use [[skill-plan-loop]] to produce target artifacts, runtime choices, outputs, and build
order.

### Step 5: Save the design receipt

Write an output to `outputs/loop-design-{date}.md` that captures the contract, decision,
and planned artifacts.

## Output format

An Output node at `outputs/loop-design-{date}.md` with:

- candidate summary
- decision: loop or not
- loop class if yes
- loop contract
- target artifacts
- build order

## Notes

- Do not implement inline during this workflow unless the operator explicitly asks for
  build execution as part of the same pass.
- A rejected loop idea is still valuable if the workflow names the better entity type.
