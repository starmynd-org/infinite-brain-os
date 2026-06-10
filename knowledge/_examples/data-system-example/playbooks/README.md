# playbooks/

This folder holds repeatable procedures for maintaining this namespace. Playbooks are
step-by-step process knowledge: when to run them, what inputs they need, and what output
they produce.

## What goes here

- **Add a new source**: the steps to add a source contract node, wire it to a pipeline
  node, and confirm the transform and model nodes are updated.
- **Update a source contract**: the steps to revise a source contract when the upstream
  API changes, including which downstream nodes to check.
- **Add a new metric**: the steps to define a new metric node, confirm its `depends_on`
  chain is complete, and notify any Operating Library namespaces that may diagnose it.
- **Retire a metric**: the steps to deprecate a metric node, add a `supersedes` pointer,
  and update any downstream references.
- **Hydrate a starter metric through a managed path**: the steps to connect the semantic
  layer to your data-platform CLI or another shared substrate.
- **Map a client-owned source into the starter contract**: the steps for a non-Example Co
  client to satisfy the same metric and source-contract shape.

## What does not go here

Do not put data transformation logic or metric definitions here. This folder holds
procedural guidance for namespace maintenance, not the data layer knowledge itself.

## Format

Each playbook is a knowledge node with full frontmatter. The body follows a consistent
pattern: trigger (when to run this), inputs required, numbered steps, and a completion
check.
