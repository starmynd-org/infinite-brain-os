#!/usr/bin/env bash
# uncommitted-work-check.sh
#
# Stop-time reminder: one line summarizing the git working tree so a session
# does not end with significant uncommitted work going unnoticed. Informational
# only; this repo's swarm sessions intentionally never commit, so this is a
# visibility aid for the operator, not a gate. Always exits 0
# (_system/enforcement-tiers.md, warn-only posture).

set -u

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"

if ! command -v git >/dev/null 2>&1 || ! git -C "$ROOT" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "uncommitted-work: git unavailable or not a work tree; nothing to report."
  exit 0
fi

status="$(git -C "$ROOT" status --porcelain 2>/dev/null)"

if [ -z "$status" ]; then
  echo "uncommitted-work: working tree clean."
  exit 0
fi

modified="$(printf '%s\n' "$status" | grep -c '^[^?]')"
untracked="$(printf '%s\n' "$status" | grep -c '^??')"

echo "uncommitted-work: $modified modified/staged and $untracked untracked path(s) in the working tree; review before ending the session."

exit 0
