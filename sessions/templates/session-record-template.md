# Session Record Template

```yaml
session_id: "session-YYYY-MM-DD-topic"
runtime_session_id: ""
date: "YYYY-MM-DD"
topic: "short-topic"
status: "active"
surface: "codex"
provider: "openai"
model: "model-name"
operator: "the-operator"
repo_scope:
  - "infinite-brain-os"
goal: "What this session is trying to accomplish."
linked:
  project: ""
  task: ""
  sprint: ""
  namespace: ""
transcript_paths:
  - "sessions/logs/YYYY-MM-DD-topic.log.md"
metering:
  usage_capture_status: "pending"
  usage_source: ""
  captured_at: ""
  input_tokens:
  output_tokens:
  cached_input_tokens:
  tool_calls:
  tool_cost_usd:
  estimated_cost_usd:
  usage_notes: ""
loaded_context:
  canon: []
  skills: []
  agents: []
  workflows: []
  nodes: []
```

## Goal

State the intended outcome in one paragraph.

## Assumptions and open questions

- Assumption:
- Open question:

## Running notes

- Timestamped summaries, wrong turns, or notable findings.

## Outputs and changed files

- None yet.

## Usage receipt

- Pending while active. At closeout, record the metering source, capture time, and best
  available token and cost totals.

## Swarm touchpoints

- If this session is operating inside a sprint, list the sprint files or receipts updated.
- Add the sprint path explicitly so the session and sprint surfaces can cross-link.

## Closeout pointer

- Pending while active.
