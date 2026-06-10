# Hooks

This folder holds the Claude Code runtime hook wrappers for this repo. The hooks are
registered in `.claude/settings.json` and run automatically at defined session events.
Built by the 2026-06-10 enforcement-tiers-and-hooks sprint; the layer this README
previously documented did not exist before that sprint, and the event name it documented
(`post_file_write`) was wrong. The real Claude Code event names used here are
`SessionStart`, `PostToolUse` (with a `Write|Edit` matcher), and `Stop`.

## Design: thin wrappers, shared logic

The wrappers in this folder stay thin. The check logic lives in `_system/checks/` so the
same scripts serve three callers: these hooks, `_system/validate.sh` (Codex parity, since
Codex does not run Claude Code hooks), and direct invocation by an agent or operator.
This is the harness-portability split: runtime-specific glue here, portable checks in
`_system/checks/`. The earlier `node-lint.sh` described in this folder now lives at
`_system/checks/node-lint.sh`.

## Warn-only posture

Every hook in this layer is warn-only. Nothing blocks a write, a session, or a stop:

- `session-start.sh` and `stop-check.sh` always exit 0; their output is informational.
- `post-write-lint.sh` exits 2 when node-lint finds violations. For PostToolUse, exit 2
  feeds the findings back to the model as feedback without undoing the write. That
  feedback loop is the warn mechanism, not a block.

Promotion of any check to blocking is a later operator decision recorded in
`_system/enforcement-tiers.md`, which also declares the enforcement tier of every
numbered `_system` rule.

## The hooks

### session-start.sh (SessionStart)

Runs `_system/checks/session-ledger-status.sh` (active-session count, stale sessions
older than 3 days) and prints a one-paragraph reminder of the forced session discipline.
Its stdout is injected into the session context, so every session starts with the ledger
state and the registration rules in view. Always exits 0.

### post-write-lint.sh (PostToolUse, matcher Write|Edit)

Reads the hook event JSON from stdin, extracts `.tool_input.file_path` (python3
preferred, jq fallback), and if the path is a repo markdown file runs
`_system/checks/node-lint.sh` on it: frontmatter presence, the eight required node keys,
the em and en dash ban, and placeholder text, with the same path exemptions as
`validate.sh`. Clean or exempt files exit 0; violations exit 2 with the findings on
stderr so the model sees them and can fix the file.

### stop-check.sh (Stop)

Runs `_system/checks/uncommitted-work-check.sh` (working-tree summary) and
`_system/checks/adapter-sync-check.sh` (entities/ versus `.claude/` and `.codex/` drift,
plus the CLAUDE.md and AGENTS.md co-edit warning) and prints their output as end-of-session
reminders. Never blocks stop; always exits 0.

## Registration

`.claude/settings.json` registers the three wrappers. Commands use
`$CLAUDE_PROJECT_DIR`, which Claude Code sets to the repo root at runtime; the wrappers
themselves resolve the repo root from their own location, so they also run standalone
from any working directory.

## Adding a hook

1. Put the check logic in `_system/checks/` as a self-contained script and document it in
   that folder's README.
2. Add a thin wrapper here that delegates to it. Make both executable (`chmod +x`).
3. Register the wrapper in `.claude/settings.json` under the correct event
   (`SessionStart`, `PreToolUse`, `PostToolUse`, `Stop`, with a `matcher` where the event
   supports one).
4. Declare the check in `_system/enforcement-tiers.md` (tier, rule coverage, warn-only
   posture).
5. Test by simulating the event: for PostToolUse, pipe
   `{"tool_input":{"file_path":"<path>"}}` into the wrapper and verify both the clean and
   the dirty path.

## Relationship to rules

Hooks enforce the mechanical floor of the rules in `entities/rules/` (served to Claude
Code via `.claude/rules/`) and the numbered contracts in `_system/`. The rule file
documents intent and rationale; the check script is the mechanism;
`_system/enforcement-tiers.md` is the registry that says which rules are mechanically
covered and which remain prose judgment. Hooks are not entities and have no Codex
adapter; Codex gets the same checks through the warn-only block in `_system/validate.sh`.
