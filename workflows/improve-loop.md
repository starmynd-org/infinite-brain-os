---
id: "workflow-improve-loop"
aliases: ["workflow-improve-loop"]
type: "Workflow"
namespace: "personal-operator"
lifecycle_state: "research"
summary: "Periodic review workflow for tightening an existing loop's evaluator, state visibility, guardrails, and absorption of repeated findings."
confidence: 0.87
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[skill-improve-loop]]"
    relation: "uses"
    confidence: 0.94
  - target: "[[agent-loop-architect]]"
    relation: "uses"
    confidence: 0.82
  - target: "[[standing-runtime-failure-posture]]"
    relation: "governed_by"
    confidence: 0.88
  - target: "[[correction-loop-review]]"
    relation: "related_to"
    confidence: 0.72
created: "2026-05-30"
runtime: "agentic"
---

# Workflow: Improve Loop

Use this workflow to review a loop that already exists and tighten its design without
changing the ontology or rebuilding everything from scratch.

## When to run

- the loop produces weak gains or weak decisions
- repeated alerts or repeated corrections suggest noisy churn
- the operator is uneasy about hidden state, unclear gates, or evaluator drift

## Inputs

- the current loop workflow and any supporting agent or skills
- recent outputs or receipts from the loop
- operator feedback on noise, friction, or missed value
- doctrine from [[autonomous-improvement-loops]] and
  [[standing-runtime-failure-posture]]

## Pipeline

### Step 1: Reconstruct the current contract

State the loop's current objective, evaluator, state substrate, stop condition, and human
gates from the existing artifacts.

### Step 2: Compare contract to observed behavior

List where the loop:

- repeats without learning
- flags stale state repeatedly
- advances on weak evidence
- hides state
- leaks beyond its intended surface

### Step 3: Run the loop improvement audit

Use [[skill-improve-loop]] to produce concrete recommendations.

### Step 4: Route structural findings

If findings are recurring corrections, route them to [[correction-loop-review]] or
directly to [[skill-apply-correction-loop]] as appropriate.

### Step 5: Save the improvement receipt

Write an output to `outputs/loop-improvement-{date}.md` with findings, recommendations,
and any structural changes that were approved.

## Output format

An Output node at `outputs/loop-improvement-{date}.md` with:

- current contract
- observed issues
- recommendations
- approved changes
- follow-up review date or trigger

## Notes

- Treat repeated advisory noise as a design defect, not as harmless background behavior.
- If the audit discovers that the loop is the wrong pattern entirely, recommend
  simplification back to a normal workflow or a bounded agent.
