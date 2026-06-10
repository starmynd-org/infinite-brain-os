---
id: "knowledge-ai-architecture-translate-business-function-into-ai-shadow-department"
aliases: ["knowledge-ai-architecture-translate-business-function-into-ai-shadow-department", "translate-business-function-into-ai-shadow-department"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Procedure for translating a business function into an AI-first shadow department with intake, a head-of-department agent, knowledge, workflows, tools, human review, and daily rollups."
confidence: 0.9
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[department-assembly-model]]"
    relation: "implements"
    confidence: 0.92
  - target: "[[problem-to-architecture]]"
    relation: "depends_on"
    confidence: 0.88
  - target: "[[intake-fabric-namespace]]"
    relation: "depends_on"
    confidence: 0.88
created: "2026-05-31"
---

# Translate Business Function Into AI Shadow Department

## Summary

Use this playbook when the goal is not "add an AI tool" but "rebuild a business function so
AI does the first pass and humans sit on top." It converts a human-first function into a
department-shaped operating assembly.

## Procedure

1. Define the business function.
   Name the function, the business outcome it owns, and the boundaries of its scope. Do not
   start from tools. Start from the function.

2. Map the full intake surface.
   List every inbound thing that creates work for the function: email, Slack, tickets, forms,
   documents, meetings, competitor moves, customer issues, research, ideas. If the inbound flow
   stays in human heads or human inboxes, the department is not truly AI-first.

3. Name the department head agent.
   Assign one head-of-department agent that owns first pass, routing, escalations, and the
   daily department update. This agent may delegate heavily, but it owns the department's
   operating coherence.

4. Define the knowledge layer.
   Determine which namespaces the department needs: doctrine, operating library, tool
   contracts, data systems, content strategy, or others. Give the department the knowledge it
   must reason from before it acts.

   For KPIs and external quantitative signals, default to a thin Data System posture first:
   define the metric semantics, the source contracts, the review targets, and the pull
   contract. Do not require a custom warehouse build before the department can exist. If
   Example Co is the managed implementation, name that explicitly. If not, declare that the
   client must map its own sources into the same contract or accept the metric as `not-wired`.

5. Define the executable layer.
   Identify:
   - reusable skills
   - specialist agents
   - agentic workflows
   - deterministic workflows
   - tools and integrations

   The function is not "AI-first" until the first pass can actually execute.

   Before assigning shared software-delivery capabilities to the department, ask whether they
   are truly department-specific. GitHub standards, CI/CD, deployment posture, secret
   management, and observability usually belong in a shared platform department, not in every
   domain department independently.

6. Define the human layer.
   Decide what stays human-only, what requires review, and what can be fully AI-routed. The
   human layer should be thin and explicit, not an undefined fallback.

7. Define the output and review cadence.
   Specify:
   - the department's daily update
   - the metrics and outputs it owns
   - the rollup path into the wider daily brief
   - the review loops that update knowledge and procedures over time

   Every department KPI should resolve to one of three states: live, manual, or not wired.
   Hide neither the semantic definition nor the implementation gap.

8. Define the cutover path.
   State how the organization moves from human-first to AI-first. Most real rollouts are staged:
   start with intake and routing, then first-pass execution, then exception handling, then
   staffing and oversight redesign.

## Success test

The department is real when:

- intake hits AI first
- the head-of-department agent can route most work without human triage
- the department can produce a daily update without manual status chasing
- human effort shifts toward review, approval, and deep exception handling
- company-level ROI is visible through volume, quality, cost, or reinvested capacity

## Notes

This playbook is the practical bridge from the shadow-department thesis to concrete OS design.
Pair it with [[problem-to-architecture]] when designing a new department from scratch.
