#!/usr/bin/env bash
# adapter-sync-check.sh
# Warn-only drift check for the runtime adapter pattern: the canonical entities under entities/ and
# the generated adapters under .claude/ and .codex/.
#
# Per CLAUDE.md, rules have a .claude/ adapter only; Codex consumes rule content via AGENTS.md, so
# entities/rules is not compared against .codex/.
# Always exits 0 in the current warn-only posture (_system/enforcement-tiers.md).
#
# THE TWO ADAPTERS ARE NOT CHECKED THE SAME WAY, because they are not the same shape.
#
#   .claude/<type>/<name>.md   a byte-for-byte copy of the canonical file. Compared with cmp.
#   .codex/skills/<name>/SKILL.md  a GENERATED file: Codex-only frontmatter over the entity body.
#                              Byte equality against the canonical file is meaningless here, so the
#                              expected content is regenerated and compared against what is on disk.
#
# The expected content is produced by sourcing sync-adapters.sh and calling the same function the
# generator calls. This check deliberately does not reimplement the generation rules. A check that
# carries its own copy of the format drifts from the generator it is checking, and then agrees with
# itself while both are wrong, which is the failure this file exists to catch in the first place.
set -u

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"

drift=0
note() { echo "adapter-drift: $1"; drift=$((drift + 1)); }

# Sourced for CLAUDE_MAP, CODEX_SKILL_SOURCES, CODEX_SKILL_ROOT, codex_skill_sources,
# codex_skill_content and content_matches_file. ADAPTER_SYNC_LIB_ONLY stops it running and stops it
# turning on `set -e`, which would end this check at the first non-zero comparison.
GENERATOR="$ROOT/sync-adapters.sh"
if [ ! -f "$GENERATOR" ]; then
  echo "adapter-sync: sync-adapters.sh not found at repo root; cannot check adapter drift."
  exit 0
fi
# shellcheck source=/dev/null
ADAPTER_SYNC_LIB_ONLY=1 . "$GENERATOR"

# --- the Claude adapter: flat byte-for-byte copies -------------------------------------------------

compare_tree() {
  local type="$1" adapter_root="$2"
  local canon_dir="$ROOT/entities/$type"
  local adapter_dir="$ROOT/$adapter_root/$type"
  local f base

  [ -d "$canon_dir" ] || return 0

  for f in "$canon_dir"/*.md; do
    [ -e "$f" ] || continue
    base="${f##*/}"
    if [ ! -e "$adapter_dir/$base" ]; then
      note "missing counterpart: entities/$type/$base has no $adapter_root/$type/$base"
    elif ! cmp -s "$f" "$adapter_dir/$base"; then
      note "content drift: entities/$type/$base differs from $adapter_root/$type/$base (run bash sync-adapters.sh)"
    fi
  done

  if [ -d "$adapter_dir" ]; then
    for f in "$adapter_dir"/*.md; do
      [ -e "$f" ] || continue
      base="${f##*/}"
      if [ ! -e "$canon_dir/$base" ]; then
        note "orphan adapter: $adapter_root/$type/$base has no canonical entities/$type/$base"
      fi
    done
  fi
}

for type in "${CLAUDE_MAP[@]}"; do
  compare_tree "$type" ".claude"
done

# --- the Codex adapter: generated .codex/skills/<name>/SKILL.md ------------------------------------

seen=""
while IFS="$(printf '\t')" read -r type stem f; do
  [ -n "${stem:-}" ] || continue

  case "$seen" in
    *"|$stem|"*)
      note "name collision: more than one canonical entity maps to $CODEX_SKILL_ROOT/$stem/SKILL.md; Codex would list one and silently drop the other. Rename one canonical file."
      continue
      ;;
  esac
  seen="$seen|$stem|"

  target="$ROOT/$CODEX_SKILL_ROOT/$stem/SKILL.md"

  if content="$(codex_skill_content "$f" "$type" "$stem")"; then
    if [ ! -e "$target" ]; then
      note "missing counterpart: entities/$type/$stem.md has no $CODEX_SKILL_ROOT/$stem/SKILL.md (run bash sync-adapters.sh)"
    elif ! content_matches_file "$content" "$target"; then
      note "content drift: entities/$type/$stem.md differs from $CODEX_SKILL_ROOT/$stem/SKILL.md (run bash sync-adapters.sh)"
    fi
  else
    # No description. Codex lists no skill without one and reports nothing about it, so this is a
    # drift finding even though nothing on disk looks wrong: the entity is simply absent from Codex.
    note "not exportable to Codex: entities/$type/$stem.md has no description, so Codex would list no skill for it and would say nothing. Add a description to the canonical entity."
    if [ -e "$target" ]; then
      note "stale adapter: $CODEX_SKILL_ROOT/$stem/SKILL.md exists but its canonical entity has no description"
    fi
  fi
done <<EOF
$(codex_skill_sources "$ROOT")
EOF

# A generated skill directory whose canonical entity is gone.
if [ -d "$ROOT/$CODEX_SKILL_ROOT" ]; then
  for d in "$ROOT/$CODEX_SKILL_ROOT"/*/; do
    [ -d "$d" ] || continue
    stem="${d%/}"; stem="${stem##*/}"
    case "$seen" in
      *"|$stem|"*) continue ;;
    esac
    note "orphan adapter: $CODEX_SKILL_ROOT/$stem/ has no canonical entity in {$(printf '%s,' "${CODEX_SKILL_SOURCES[@]}" | sed 's/,$//')}"
  done
fi

# Files the previous generator wrote that codex-cli 0.146.0 does not read. Reported once as a
# group rather than once per file: there are dozens, they are all the same finding, and drowning
# the real drift lines under fifty repetitions of a known condition would defeat the check.
inert=0
for f in "$ROOT"/.codex/agents/*.md "$ROOT"/.codex/commands/*.md "$ROOT"/.codex/skills/*.md; do
  [ -e "$f" ] || continue
  inert=$((inert + 1))
done
if [ "$inert" -gt 0 ]; then
  note "inert Codex adapter: $inert flat file(s) under .codex/{agents,commands,skills}/ are not read by codex-cli 0.146.0 (only .codex/skills/<name>/SKILL.md is). They are left in place because they ship in the starter; 'bash sync-adapters.sh --prune-inert' removes them."
fi

# --- CLAUDE.md and AGENTS.md mirror each other and must be edited together --------------------------

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
