---
id: "cmd-build-department"
aliases: ["cmd-build-department", "build-department"]
type: "Command"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Plain-English command that builds or upgrades a department assembly under departments/."
confidence: 0.9
retrieval_class: "identity"
export_class: "internal"
description: "Use when an operator wants to create or refine a department, its head agent, intake posture, linked tools and workflows, and its role in the AI shadow department model."
edges:
  - target: "[[skill-build-department]]"
    relation: "delegates_to"
    confidence: 0.96
  - target: "[[workflow-build-department]]"
    relation: "uses"
    confidence: 0.92
  - target: "[[skill-build-agent]]"
    relation: "delegates_to"
    confidence: 0.82
created: "2026-05-31"
---

# /build-department

Build or upgrade a department in plain English.

Example:

```text
/build-department Build a shared devops-platform department that owns GitHub, CI/CD, secrets posture, deployment standards, and observability, then link domain departments to it rather than letting each own its own stack.
```

This command should:

1. read the operator's English request
2. determine the department's function and type
3. create or refine `departments/<slug>/INDEX.md`
4. create missing head-agent or workflow entities when justified
5. add or link the needed tools, namespaces, handoffs, and data-system posture
6. leave a short build report in `outputs/`
