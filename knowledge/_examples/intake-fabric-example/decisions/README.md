# decisions/

This folder holds architectural decisions about the intake-fabric structure. Each node
records a decision made, the options considered, and the rationale.

## What belongs here

- Decisions about the three-layer split and where each layer lives.
- Decisions about schema versioning for intake records.
- Decisions about routing scope: which namespaces are valid routing destinations, and
  how destination rules are structured.
- Decisions about what triggers a structural change to the intake fabric versus an
  operational configuration change.

## What does not belong here

- Routing rules for specific source families. Those live in `intake/routing/`.
- Playbook steps. Those live in `playbooks/` here (thin pointers) and in
  `intake/playbooks/` (the real procedures).
- Live routing decisions for specific items. Those live in
  `intake/processed/<source-family>/`.

## Node frontmatter convention

Decision nodes carry `type: "Knowledge"`, `retrieval_class: "domain"`, `lifecycle_state:
"canon"` for settled decisions, and edges pointing at any nodes they supersede or inform.
Add `supersedes: ["<id>"]` in frontmatter if the decision replaces a prior one.
