#!/usr/bin/env bash
# sync-adapters.sh
# Regenerate the .claude/ and .codex/ runtime adapters from the canonical entities/ files.
# Use this if your OS does not support symlinks (Windows native, restricted CI).
# Run from the repo root: bash sync-adapters.sh
#
# WHY THE CODEX HALF OF THIS SCRIPT CHANGED SHAPE.
#
# The previous version wrote entities/{commands,agents,skills} out as flat .md files under
# .codex/{commands,agents,skills}/. Measured against codex-cli 0.146.0, from inside a project
# directory with an isolated CODEX_HOME, none of those three locations is read. The starter was
# shipping a Codex adapter that Codex has never once loaded, and it looked correct on disk, which is
# the reason nobody noticed: the failure mode of an inert adapter is silence.
#
# What IS read at project level is one shape:
#
#     .codex/skills/<name>/SKILL.md        read
#     .codex/skills/<name>.md   (flat)     not read
#     .codex/agents/<name>.md              not read
#     .codex/commands/<name>.md            not read
#     .codex/commands/<name>/SKILL.md      not read
#     .codex/prompts/<name>.md             not read
#     AGENTS.md at the project root        read
#
# Negative control: a .codex/skills/<dir> containing no SKILL.md is not read, so the directory
# itself is not the trigger.
#
# Three further properties of that shape were measured rather than assumed, because each one
# changes what this script must emit:
#
#   1. The frontmatter `name` is what Codex lists and invokes. The directory is only the locator.
#      A SKILL.md in a directory called `mismatched` whose frontmatter says `name:
#      totally-different-name` is listed as `totally-different-name`.
#   2. `name` is optional. With no `name` key, Codex falls back to the directory name.
#   3. `description` is REQUIRED, and its absence is silent. A SKILL.md with no description is not
#      listed at all: not an error, not a warning, simply absent. That is why this script refuses
#      to emit a skill for an entity that has no description instead of writing a file that would
#      look fine on disk and be invisible in use.
#
# Only `name` and `description` are loaded at startup. The body is read on demand when the skill is
# invoked, so body size costs nothing at session start.
#
# WHAT THIS SCRIPT WILL NOT DO. It does not delete the flat files the previous version generated.
# Those files ship in the starter today, and removing files from the shipped tree is a decision
# about the product, not a side effect of fixing a generator. They are reported as inert and left
# in place; `--prune-inert` removes them for anyone who wants that, on purpose and by name.

if [ "${ADAPTER_SYNC_LIB_ONLY:-0}" = "1" ]; then
  # Sourced by _system/checks/adapter-sync-check.sh for its helpers. The check is warn-only and
  # must always exit 0, so `set -e` is deliberately not inherited.
  set -u
else
  set -euo pipefail
fi

# The Claude Code adapter is unchanged: Claude reads flat .md files in these four folders.
CLAUDE_MAP=(commands agents skills rules)

# The Codex adapter. Both entity types become skills because both are what Codex calls a skill: a
# named instruction set the model selects when it applies. This is the one judgement call in the
# rewrite and it is deliberately a single editable line, because it is the line a reviewer is most
# likely to want to change. Dropping `agents` here leaves the skills half working on its own.
#
# `commands` is absent on purpose. A Claude command is user-invoked, a Codex skill is model-
# selected, and there is no project-level Codex surface for the former: .codex/commands and
# .codex/prompts are both unread. Mapping commands to skills would silently convert eight
# user-invoked commands into eight things Codex may decide to run by itself, which is a change to
# what the starter does, not a fix to how it is written down. Left for a product decision.
CODEX_SKILL_SOURCES=(skills agents)

CODEX_SKILL_ROOT=".codex/skills"

# --- reading canonical entities -------------------------------------------------------------------

# codex_skill_content <entity-file> <type> <stem>
#   stdout: the full SKILL.md text
#   exit 3: the entity has no description, so no file should be written for it
#
# One pass over the file, on purpose. The obvious way to write this is four passes (find the
# frontmatter end, read `description`, read `name`, then cut the body), and that is how it was
# written first. On this platform a process spawn dominates the work, so four passes over 48 small
# files took over a minute and the drift check would have paid it a second time. One awk program
# that knows the file format is both faster and less to get wrong.
#
# Deterministic output: no timestamps, no run-dependent values, so re-running produces no diff and
# the drift check can compare byte for byte.
codex_skill_content() {
  awk -v stem="$3" -v type="$2" '
    BEGIN { sq = sprintf("%c", 39); dq = sprintf("%c", 34); bs = sprintf("%c", 92) }

    # Trim, then strip one matching pair of surrounding quotes. Done by character comparison rather
    # than by a regex so this program carries no quote or backslash characters of its own.
    function unquote(v,   f, l) {
      sub(/^[[:space:]]+/, "", v); sub(/[[:space:]]+$/, "", v)
      if (length(v) >= 2) {
        f = substr(v, 1, 1); l = substr(v, length(v), 1)
        if (f == l && (f == sq || f == dq)) v = substr(v, 2, length(v) - 2)
      }
      return v
    }

    # A YAML double-quoted scalar, escaped a character at a time. A dynamic regex holding a single
    # backslash is not portable across awks, and descriptions here are long English sentences that
    # can contain both quote characters, so the loop is the honest way to do it.
    function yamlesc(s,   i, c, out) {
      out = ""
      for (i = 1; i <= length(s); i++) {
        c = substr(s, i, 1)
        if (c == bs || c == dq) out = out bs
        out = out c
      }
      return out
    }

    NR == 1 { if ($0 == "---") { inf = 1; next } else { body = 1 } }
    inf && /^---[[:space:]]*$/ { inf = 0; body = 1; next }
    inf {
      if (index($0, "description:") == 1)  desc = unquote(substr($0, 13))
      else if (index($0, "name:") == 1)   cname = unquote(substr($0, 6))
      next
    }
    body { lines[++n] = $0 }

    END {
      # Refused by the caller rather than written empty. Codex silently omits a skill whose
      # description is missing, so an empty one is worse than none: it looks right on disk.
      if (desc == "") exit 3

      print "---"
      print "name: " stem
      print "description: " dq yamlesc(desc) dq
      print "---"
      print ""
      print "<!-- GENERATED by sync-adapters.sh from entities/" type "/" stem ".md. Do not edit this"
      print "     file; edit the canonical entity and re-run the script. -->"
      if (cname != "" && cname != stem) print "<!-- Canonical name: " cname " -->"
      print ""
      for (i = 1; i <= n; i++) print lines[i]
    }
  ' "$1"
}

# content_matches_file <content> <file> -> true when the file already holds this generated content
#
# Shared by the generator and by the drift check on purpose. If the two decided "unchanged"
# differently they would deadlock: the check would report drift on a file the generator considers
# current, and re-running the generator would never clear it. One helper makes agreement structural
# rather than a thing two files have to remember about each other.
#
# $(<file) is a bash redirection, so this costs no process. It strips trailing newlines from both
# sides, which is why the generator always writes exactly one, and why a hand-added blank line at
# the end of a generated file is tolerated identically by both tools.
content_matches_file() {
  [ -e "$2" ] || return 1
  [ "$(<"$2")" = "$1" ]
}

# codex_skill_sources <root> -> one tab-separated "<type> <stem> <file>" line per candidate entity
#
# Candidates only. Whether an entity can actually become a skill depends on its description and on
# name collisions, and the generator and the drift check need to report those two differently while
# agreeing on what they are, so neither is decided here.
codex_skill_sources() {
  local root="$1" type f base
  for type in "${CODEX_SKILL_SOURCES[@]}"; do
    [ -d "$root/entities/$type" ] || continue
    for f in "$root/entities/$type"/*.md; do
      [ -e "$f" ] || continue
      base="${f##*/}"
      printf '%s\t%s\t%s\n' "$type" "${base%.md}" "$f"
    done
  done
}

# --- the run ---------------------------------------------------------------------------------------

usage() {
  cat <<'USAGE'
Usage: bash sync-adapters.sh [--prune-inert]

  --prune-inert   Also delete the .codex files that codex-cli never reads (the flat
                  .codex/{agents,skills,commands}/*.md the previous generator wrote) and any
                  .codex/skills/<dir> whose canonical entity no longer exists. Off by default:
                  those files ship in the starter today and removing them is a product decision.
USAGE
}

main() {
  local repo_root prune=0 arg
  repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

  for arg in "$@"; do
    case "$arg" in
      --prune-inert) prune=1 ;;
      -h|--help) usage; return 0 ;;
      *) printf 'sync-adapters: unknown argument: %s\n' "$arg" >&2; usage >&2; return 2 ;;
    esac
  done

  cd "$repo_root"

  local synced=0 skipped=0 refused=0 type f base target content

  # --- the Claude Code adapter: flat copies, unchanged behaviour ---------------------------------
  for type in "${CLAUDE_MAP[@]}"; do
    [ -d "entities/$type" ] || continue
    mkdir -p ".claude/$type"
    for f in "entities/$type"/*.md; do
      [ -e "$f" ] || continue
      base="${f##*/}"
      target=".claude/$type/$base"
      if [ -e "$target" ] && cmp -s "$f" "$target"; then
        skipped=$((skipped + 1))
        continue
      fi
      cp -f "$f" "$target"
      synced=$((synced + 1))
    done
  done

  # --- the Codex adapter: .codex/skills/<name>/SKILL.md ------------------------------------------
  local seen="" stem dup=0
  mkdir -p "$CODEX_SKILL_ROOT"

  while IFS="$(printf '\t')" read -r type stem f; do
    [ -n "${stem:-}" ] || continue

    case "$seen" in
      *"|$stem|"*)
        # Two canonical entities want one Codex skill name. Codex would list whichever was written
        # last and the other would vanish without a word, so neither is written.
        printf 'adapter-sync: REFUSED name collision on %s; more than one entity maps to\n' "$stem"
        printf '              %s/%s/SKILL.md. Rename one canonical file.\n' "$CODEX_SKILL_ROOT" "$stem"
        refused=$((refused + 1))
        dup=1
        continue
        ;;
    esac
    seen="$seen|$stem|"

    # `if` rather than a bare assignment so exit 3 is handled here instead of tripping set -e.
    if content="$(codex_skill_content "$f" "$type" "$stem")"; then
      :
    else
      printf 'adapter-sync: REFUSED entities/%s/%s.md has no description; Codex lists no skill\n' "$type" "$stem"
      printf '              without one and says nothing about it, so %s/%s/SKILL.md\n' "$CODEX_SKILL_ROOT" "$stem"
      printf '              was not written. Add a description to the canonical entity.\n'
      refused=$((refused + 1))
      continue
    fi

    target="$CODEX_SKILL_ROOT/$stem/SKILL.md"
    if content_matches_file "$content" "$target"; then
      skipped=$((skipped + 1))
      continue
    fi
    mkdir -p "$CODEX_SKILL_ROOT/$stem"
    printf '%s\n' "$content" > "$target"
    synced=$((synced + 1))
  done <<EOF
$(codex_skill_sources "$repo_root")
EOF

  # --- inert leftovers: reported, and removed only when asked ------------------------------------
  local inert=0 pruned=0 d
  for f in .codex/agents/*.md .codex/commands/*.md .codex/skills/*.md; do
    [ -e "$f" ] || continue
    inert=$((inert + 1))
    if [ "$prune" -eq 1 ]; then rm -f "$f"; pruned=$((pruned + 1)); fi
  done

  # A skill directory whose canonical entity is gone.
  if [ -d "$CODEX_SKILL_ROOT" ]; then
    for d in "$CODEX_SKILL_ROOT"/*/; do
      [ -d "$d" ] || continue
      stem="${d%/}"; stem="${stem##*/}"
      case "$seen" in
        *"|$stem|"*) continue ;;
      esac
      inert=$((inert + 1))
      if [ "$prune" -eq 1 ]; then rm -rf "$d"; pruned=$((pruned + 1)); fi
    done
  fi

  # --- report -------------------------------------------------------------------------------------
  printf 'adapter-sync: wrote %s file(s), %s already current.\n' "$synced" "$skipped"
  printf '              .claude/{%s} as flat .md; .codex/skills/<name>/SKILL.md from {%s}.\n' \
    "$(printf '%s,' "${CLAUDE_MAP[@]}" | sed 's/,$//')" \
    "$(printf '%s,' "${CODEX_SKILL_SOURCES[@]}" | sed 's/,$//')"

  if [ "$refused" -gt 0 ]; then
    printf '              %s entit(y|ies) refused; see the REFUSED lines above. Nothing was written\n' "$refused"
    printf '              for them, deliberately, because the file would have been inert.\n'
  fi

  if [ "$inert" -gt 0 ]; then
    if [ "$prune" -eq 1 ]; then
      printf '              removed %s inert .codex path(s) that codex-cli does not read.\n' "$pruned"
    else
      printf '              %s inert .codex path(s) remain: flat .codex/{agents,skills,commands}/*.md\n' "$inert"
      printf '              are never read by codex-cli 0.146.0. Left in place because they ship in the\n'
      printf '              starter today. Run with --prune-inert to remove them.\n'
    fi
  fi

  printf '              Copies, not symlinks. Re-run after editing any entity in entities/.\n'
  printf '              Codex reads rules through AGENTS.md, not through an adapter subfolder.\n'

  if [ "$dup" -eq 1 ]; then return 1; fi
  return 0
}

if [ "${ADAPTER_SYNC_LIB_ONLY:-0}" != "1" ]; then
  main "$@"
fi
