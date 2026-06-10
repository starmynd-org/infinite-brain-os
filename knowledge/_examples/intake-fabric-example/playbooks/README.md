# playbooks/

This folder holds process-pointing playbooks for the intake-fabric namespace.

These playbooks are thin: they describe the process at a high level and point to the
real procedures in `intake/playbooks/` at repo root. The detailed, step-by-step
instructions for each source family live in the live intake scaffold, not here. This
separation keeps the knowledge-layer namespace thin and ensures the procedures stay
co-located with the operational scaffold they govern.

## What belongs here

- A playbook node for each major intake process that a new agent or operator would need
  to understand at a doctrine level before reading the detailed procedure.
- Each playbook here is a pointer: it states what the process is, why it is structured
  the way it is, and where the detailed steps live.

## What belongs in intake/playbooks/ instead

- The actual step-by-step instructions for processing each source family.
- Source-specific routing rules and classification criteria.
- Checklists and templates for creating receipts.

## Node frontmatter convention

Playbook pointer nodes here carry `type: "Knowledge"`, `retrieval_class: "domain"`, and
an edge with `relation: "references"` pointing to the live procedure file at `intake/`.
