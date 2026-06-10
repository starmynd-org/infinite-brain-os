#!/usr/bin/env bash
# session-start.sh
# SessionStart hook wrapper. Thin by design: the logic lives in _system/checks/
# (harness portability; Codex and validate.sh call the same scripts). Prints the
# session-ledger status plus the forced session discipline reminder; this stdout
# is injected into the session context. Always exits 0 (warn-only posture, see
# _system/enforcement-tiers.md).

set -u

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"

bash "$ROOT/_system/checks/session-ledger-status.sh" || true

echo
echo "Session discipline reminder: every non-trivial session (anything that creates, edits, moves, or deletes a file) must register a session record in sessions/active/ named YYYY-MM-DD-<topic>.md before substantive work, declare a transcript path in sessions/logs/, record the initial context loaded, keep running notes, and at the end write a closeout review in sessions/reviews/ and move the record to sessions/closed/. If the session operates inside a swarm sprint, dual-write sessions/ and swarms/Sprints/... on purpose and cross-link them. See _system/session-ledger-rules.md."

exit 0
