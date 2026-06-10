#!/usr/bin/env bash
# post-write-lint.sh
# PostToolUse hook wrapper (matcher: Write|Edit). Thin by design: the lint logic
# lives in _system/checks/node-lint.sh. Reads the hook event JSON from stdin,
# extracts .tool_input.file_path, and if it is a markdown file in this repo runs
# node-lint on it.
#
# Warn mechanism: when node-lint exits 2, this wrapper prints the findings to
# stderr and exits 2. For PostToolUse, exit 2 feeds the findings back to the
# model as feedback without undoing the write. Everything else exits 0.

set -u

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"

INPUT="$(cat 2>/dev/null || true)"
[ -n "$INPUT" ] || exit 0

FILE_PATH=""
if command -v python3 >/dev/null 2>&1; then
  FILE_PATH="$(printf '%s' "$INPUT" | python3 -c '
import json, sys
try:
    data = json.load(sys.stdin)
except Exception:
    sys.exit(0)
path = (data.get("tool_input") or {}).get("file_path") or ""
print(path)
' 2>/dev/null || true)"
elif command -v jq >/dev/null 2>&1; then
  FILE_PATH="$(printf '%s' "$INPUT" | jq -r '.tool_input.file_path // empty' 2>/dev/null || true)"
fi

[ -n "$FILE_PATH" ] || exit 0

case "$FILE_PATH" in
  *.md) ;;
  *) exit 0 ;;
esac

LINT_OUTPUT="$(bash "$ROOT/_system/checks/node-lint.sh" "$FILE_PATH" 2>&1)"
LINT_EXIT=$?

if [ "$LINT_EXIT" -eq 2 ]; then
  printf '%s\n' "$LINT_OUTPUT" >&2
  echo "node-lint findings above are warn-only feedback; the write was not undone. Fix the file or justify the exception. See _system/enforcement-tiers.md." >&2
  exit 2
fi

exit 0
