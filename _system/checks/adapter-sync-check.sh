#!/usr/bin/env bash
# adapter-sync-check.sh
#
# Warn-only drift check for the runtime adapter pattern. Canonical executable
# entities live in entities/{agents,commands,skills,rules}; .claude/ and .codex/
# hold copies (not symlinks in this environment; see sync-adapters.sh). This
# script reports any adapter copy that is missing or differs from its canonical
# file, any adapter file with no canonical source, and a CLAUDE.md or AGENTS.md
# edit in the git working tree without its mirror (the two must be edited
# together).
#
# Per CLAUDE.md, rules have a .claude/ adapter only; Codex consumes rule content
# via AGENTS.md, so entities/rules is not compared against .codex/.
#
# Always exits 0 in the current warn-only posture (_system/enforcement-tiers.md).

set -u

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"

drift=0
note() {
  echo "adapter-drift: $1"
  drift=$((drift + 1))
}

compare_tree() {
  local type="$1" adapter_root="$2"
  local canon_dir="$ROOT/entities/$type"
  local adapter_dir="$ROOT/$adapter_root/$type"
  local f base

  [ -d "$canon_dir" ] || return 0

  for f in "$canon_dir"/*.md; do
    [ -e "$f" ] || continue
    base="$(basename "$f")"
    if [ ! -e "$adapter_dir/$base" ]; then
      note "missing counterpart: entities/$type/$base has no $adapter_root/$type/$base"
    elif ! cmp -s "$f" "$adapter_dir/$base"; then
      note "content drift: entities/$type/$base differs from $adapter_root/$type/$base (run bash sync-adapters.sh)"
    fi
  done

  if [ -d "$adapter_dir" ]; then
    for f in "$adapter_dir"/*.md; do
      [ -e "$f" ] || continue
      base="$(basename "$f")"
      if [ ! -e "$canon_dir/$base" ]; then
        note "orphan adapter: $adapter_root/$type/$base has no canonical entities/$type/$base"
      fi
    done
  fi
}

for type in agents commands skills rules; do
  compare_tree "$type" ".claude"
done
for type in agents commands skills; do
  compare_tree "$type" ".codex"
done

# CLAUDE.md and AGENTS.md mirror each other and must be edited together.
if command -v git >/dev/null 2>&1 && git -C "$ROOT" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  status="$(git -C "$ROOT" status --porcelain -- CLAUDE.md AGENTS.md 2>/dev/null)"
  claude_dirty=0
  agents_dirty=0
  printf '%s\n' "$status" | grep -q ' CLAUDE\.md$' && claude_dirty=1
  printf '%s\n' "$status" | grep -q ' AGENTS\.md$' && agents_dirty=1
  if [ "$claude_dirty" -ne "$agents_dirty" ]; then
    if [ "$claude_dirty" -eq 1 ]; then
      note "CLAUDE.md is modified in the working tree but AGENTS.md is not; the two files mirror each other and must be edited together"
    else
      note "AGENTS.md is modified in the working tree but CLAUDE.md is not; the two files mirror each other and must be edited together"
    fi
  fi
else
  echo "adapter-sync: git unavailable; skipped the CLAUDE.md and AGENTS.md co-edit check."
fi

if [ "$drift" -eq 0 ]; then
  echo "adapter-sync: entities/, .claude/, and .codex/ are in sync; CLAUDE.md and AGENTS.md co-edit state is consistent."
else
  echo "adapter-sync: $drift drift finding(s) (warn-only)."
fi

exit 0
