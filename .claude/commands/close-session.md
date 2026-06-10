---
id: "cmd-close-session"
aliases: ["cmd-close-session", "close-session"]
type: "Command"
namespace: "personal-operator"
lifecycle_state: "research"
summary: "Command that forces AI session closeout, follow-up extraction, and movement of the session record into the closed ledger."
confidence: 0.9
retrieval_class: "identity"
export_class: "internal"
description: "Close a tracked AI session: write the closeout review, extract memory and task and swarm candidates, and finalize the session record."
edges:
  - target: "[[workflow-session-closeout-review]]"
    relation: "delegates_to"
    confidence: 0.94
  - target: "[[skill-manage-ai-session]]"
    relation: "delegates_to"
    confidence: 0.9
created: "2026-05-31"
---

# /close-session

Force closeout for a tracked AI work session before ending it.

## Usage

```text
/close-session sessions/active/YYYY-MM-DD-topic.md
```

## What this command does

1. Reads the session record and linked transcript path.
2. Runs the session closeout review workflow.
3. Extracts memory, task, swarm, human-review, and system-improvement candidates.
4. Links the closeout review and final outputs.
5. Moves the session record into `sessions/closed/` with final status.

## Notes

This command closes the durable session trail. It should be the normal end gate for tracked
AI work sessions.
