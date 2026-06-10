#!/usr/bin/env bash
# node-lint.sh <file.md>
#
# Per-file lint for node-bearing markdown: frontmatter presence, the eight required
# node keys, the em and en dash ban, and placeholder text. Mirrors the path
# exemptions in _system/validate.sh (plumbing patterns, walk prunes, generated
# trees) so a file the validator would skip is skipped here too.
#
# Exit codes: 0 clean or exempt or not lintable; 2 one or more findings, printed
# one per line. Called at write time by .claude/hooks/post-write-lint.sh; the
# PostToolUse exit-2 path feeds findings back to the model as warn-only feedback.
# Promotion to a blocking check is a later operator decision recorded in
# _system/enforcement-tiers.md.

set -u

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"

if [ $# -ne 1 ]; then
  echo "usage: node-lint.sh <file.md>" >&2
  exit 0
fi

TARGET="$1"
case "$TARGET" in
  /*) ABS="$TARGET" ;;
  *) ABS="$(pwd)/$TARGET" ;;
esac

if [ ! -f "$ABS" ]; then
  echo "node-lint: not a file, skipping: $TARGET"
  exit 0
fi

# Normalize and confirm the file is inside this repo.
ABS="$(cd "$(dirname "$ABS")" && pwd)/$(basename "$ABS")"
case "$ABS" in
  "$ROOT"/*) ;;
  *)
    echo "node-lint: outside repo, skipping: $TARGET"
    exit 0
    ;;
esac

REL="${ABS#$ROOT/}"

case "$REL" in
  *.md) ;;
  *)
    echo "node-lint: not markdown, skipping: $REL"
    exit 0
    ;;
esac

# --- Exemption logic mirrored from _system/validate.sh ----------------------

# Generated and pruned trees (REPO_MD_WALK_PRUNES + GENERATED_MD_WALK_PRUNES):
# these files are never node-checked by the validator at all.
is_pruned() {
  case "$REL" in
    .git/*|.obsidian/*|.codex/*|.claude/*|_system/*|sessions/*|swarms/*|docs/*|intake/*) return 0 ;;
    data/source-archives/*) return 0 ;;
    */waves/surfaces/dist/*) return 0 ;;
    knowledge/*/archive/*|knowledge/*/support/*) return 0 ;;
    outputs/crm-corpus/generated/*|outputs/crm-corpus/assets/*) return 0 ;;
    */node_modules/*|node_modules/*) return 0 ;;
  esac
  return 1
}

# Plumbing files (is_plumbing in validate.sh): exempt from node-frontmatter
# checks. The pattern list matches by substring, same as the validator.
is_plumbing() {
  case "$REL" in
    knowledge/*/INDEX.md) return 0 ;;
    knowledge/*/canon/README.md) return 0 ;;
    knowledge/*/canon/agent-load-order.md) return 0 ;;
    knowledge/*/synthesis/README.md) return 0 ;;
  esac
  local pattern
  for pattern in \
    "README.md" "CLAUDE.md" "AGENTS.md" "CANONICAL-GATES.md" "START-HERE.md" \
    "OBSIDIAN-DASHBOARD.md" ".obsidian/" "_system/" "swarms/" "docs/" \
    "data/source-archives/" ".claude/hooks/" "entities/README.md" "sessions/"; do
    case "$REL" in
      *"$pattern"*) return 0 ;;
    esac
  done
  return 1
}

# Dash-ban exemptions (the rg glob excludes in the validator's dash check).
dash_exempt() {
  case "$REL" in
    sessions/*|swarms/*|_system/*|docs/*|.codex/*|.claude/*) return 0 ;;
    */archive/*|*/support/*|*/waves/surfaces/dist/*) return 0 ;;
  esac
  return 1
}

FINDINGS=0
finding() {
  echo "LINT $REL: $1"
  FINDINGS=$((FINDINGS + 1))
}

NODE_CHECKED=0
if ! is_pruned && ! is_plumbing; then
  NODE_CHECKED=1
fi

# --- Frontmatter and required keys -------------------------------------------

LIFECYCLE=""
if [ "$NODE_CHECKED" -eq 1 ]; then
  FM="$(awk 'NR==1 && $0!="---"{exit 1} NR>1{if($0=="---"){found=1;exit} print}' "$ABS" 2>/dev/null)" || FM=""
  HAS_FM=0
  if head -n 1 "$ABS" | grep -qx -- '---' && [ -n "$FM" ]; then
    # Confirm the closing delimiter exists (awk above prints nothing useful otherwise).
    if awk 'NR==1{next} $0=="---"{found=1;exit} END{exit !found}' "$ABS"; then
      HAS_FM=1
    fi
  fi

  if [ "$HAS_FM" -eq 0 ]; then
    finding "missing YAML frontmatter block"
  else
    for key in id type namespace lifecycle_state summary confidence retrieval_class export_class; do
      if ! printf '%s\n' "$FM" | grep -q "^${key}:"; then
        finding "missing required frontmatter key '${key}:'"
      fi
    done
    LIFECYCLE="$(printf '%s\n' "$FM" | sed -n 's/^lifecycle_state:[[:space:]]*//p' | head -1 | tr -d '"' | tr -d "'")"
  fi
fi

# --- Em and en dash ban -------------------------------------------------------

if ! dash_exempt; then
  EM=$'\xe2\x80\x94'
  EN=$'\xe2\x80\x93'
  while IFS= read -r hit; do
    [ -n "$hit" ] || continue
    finding "em or en dash at line ${hit%%:*}"
  done < <(grep -n -e "$EM" -e "$EN" "$ABS" 2>/dev/null | cut -d: -f1 | sed 's/$/:/')
fi

# --- Placeholder text ---------------------------------------------------------
# Applies to node-checked files above lifecycle_state: scratch (voice-and-style:
# no placeholder text in any node above scratch).

if [ "$NODE_CHECKED" -eq 1 ] && [ "$LIFECYCLE" != "scratch" ]; then
  while IFS= read -r hit; do
    [ -n "$hit" ] || continue
    finding "placeholder text at line ${hit%%:*}"
  done < <(grep -nE '(\{placeholder\}|\[insert here\]|\bTBD\b|\bTODO\b)' "$ABS" 2>/dev/null | cut -d: -f1 | sed 's/$/:/')
fi

# --- Result -------------------------------------------------------------------

if [ "$FINDINGS" -gt 0 ]; then
  echo "node-lint: $FINDINGS finding(s) in $REL"
  exit 2
fi

echo "node-lint: clean: $REL"
exit 0
