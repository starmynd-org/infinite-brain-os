---
id: "workflow-build-department"
aliases: ["workflow-build-department", "build-department"]
type: "Workflow"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "End-to-end workflow for building or upgrading a department assembly, including its head agent, tool/workflow links, and daily update posture."
confidence: 0.9
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[skill-build-department]]"
    relation: "uses"
    confidence: 0.95
  - target: "[[department-model]]"
    relation: "depends_on"
    confidence: 0.9
  - target: "[[department-assembly-rules]]"
    relation: "depends_on"
    confidence: 0.92
created: "2026-05-31"
runtime: "agentic"
---

# Workflow: Build Department

Use this workflow when a department should become a real operating surface instead of a vague
idea.

This workflow is the assembly mechanics (the steps below) inside the broader, Paperclip-native
`build-out-a-department` playbook. For the full process (mining existing repos, recurring tasks,
intake-to-process-types, and projecting the department into the Paperclip runtime), read that
playbook first: `knowledge/ai-architecture/playbooks/build-out-a-department.md`.

## Pipeline

1. Parse the operator request into:
   - department slug
   - owned function
   - department type: domain, stewardship, or platform
   - external scope posture, if any
   - relevant `party_slugs`, `client_slug`, and `brand_slug`
   - expected linked namespaces, workflows, tools, and review gates
2. Create or refine `departments/<slug>/INDEX.md`.
3. Create or refine `departments/<slug>/CHARTER.md`.
4. Create the head-of-department agent if missing.
5. Link or create the core workflows the department needs.
6. Link or create the tool registry entries the department depends on.
7. Decide and document the KPI data posture: owned Data System, shared Data System, or
   explicit provisional metrics with `live`, `manual`, or `not-wired` status.
8. Decide whether the department should consume a shared platform department rather than own
   its own full GitHub/CI/CD stack.
9. If the department is externally scoped, link the relevant `parties/` records and make sure the
   commercial scope matches the linked namespaces, workflows, and projects.
10. Leave a build report in `outputs/build-department-<slug>-<date>.md`.

The success test is that the department can be read as one coherent operating unit and not
as a loose list of components.
