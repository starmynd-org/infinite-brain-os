#!/usr/bin/env bash
# session-ledger-status.sh
#
# Warn-only report on the session ledger: how many session records sit in
# sessions/active/, and which of them are older than 3 days by their YYYY-MM-DD
# filename prefix (Rule SESSION-6: tracked sessions end with an explicit closeout
# and move to sessions/closed/). Always exits 0; findings are for operator and
# curator review, per _system/enforcement-tiers.md.

set -u

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
ACTIVE_DIR="$ROOT/sessions/active"

if [ ! -d "$ACTIVE_DIR" ]; then
  echo "session-ledger: sessions/active/ does not exist."
  exit 0
fi

count=0
stale=0
cutoff="$(date -d '3 days ago' +%Y-%m-%d 2>/dev/null || date +%Y-%m-%d)"

stale_lines=""
for f in "$ACTIVE_DIR"/*.md; do
  [ -e "$f" ] || continue
  base="$(basename "$f")"
  [ "$base" = "README.md" ] && continue
  count=$((count + 1))
  prefix="${base:0:10}"
  case "$prefix" in
    [0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9])
      if [[ "$prefix" < "$cutoff" ]]; then
        stale=$((stale + 1))
        stale_lines="${stale_lines}  STALE (older than 3 days): sessions/active/$base"$'\n'
      fi
      ;;
    *)
      stale_lines="${stale_lines}  UNDATED: sessions/active/$base has no YYYY-MM-DD prefix"$'\n'
      ;;
  esac
done

echo "session-ledger: $count active session record(s); $stale older than 3 days (cutoff $cutoff)."
if [ -n "$stale_lines" ]; then
  printf '%s' "$stale_lines"
  echo "session-ledger: stale records need a closeout review and a move to sessions/closed/ (Rule SESSION-6)."
fi

exit 0
