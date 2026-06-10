---
id: "cmd-start-session"
aliases: ["cmd-start-session", "start-session"]
type: "Command"
namespace: "personal-operator"
lifecycle_state: "research"
summary: "Command that registers an AI work session in the root sessions layer before substantial work begins."
confidence: 0.9
retrieval_class: "identity"
export_class: "internal"
description: "Start a tracked AI session: create the session record, declare the transcript path, and record the initial context and linked work."
edges:
  - target: "[[skill-manage-ai-session]]"
    relation: "delegates_to"
    confidence: 0.94
created: "2026-05-31"
---

# /start-session

Register a meaningful AI work session before substantial work begins.

## Usage

```text
/start-session topic=<topic> surface=<surface> model=<model> goal="<goal>"
```

Optional arguments:

- `project=<project>`
- `task=<task>`
- `sprint=<sprint>`
- `namespace=<namespace>`

## What this command does

1. Creates a session record in `sessions/active/` named `YYYY-MM-DD-<topic>.md`.
2. Declares the transcript path under `sessions/logs/`.
3. Records the linked work item and the initial context loaded.
4. Marks the session `status: active`.

## Notes

This command starts the durable session trail. It does not replace the closeout review. Use
`/close-session` before ending the work.
