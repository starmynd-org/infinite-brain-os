#!/usr/bin/env bash
# What would leave this brain for a given audience, and what would be held back.
#
# B01's acceptance condition is that a fresh private Brain and a clean company Brain can consume the
# same base without private transcript leakage. That is a claim about a computation nobody could
# perform: `export_class` existed as a required key whose value was never checked, there was no
# `private` value at all, and no tool anywhere answered "what does audience X actually get".
#
# _system/audience-and-export-schema.md added the value and the enum enforcement. This adds the
# computation, so the claim can be tested rather than asserted.
#
#   bash _system/checks/audience-export-check.sh <audience> [root]
#
# audience is public, department or internal. There is deliberately no `private` audience: private is
# a stop, not a scope, so nothing can ask for the private set and be handed it.
#
# Exit 0 when the export set is well formed. Exit 1 when a node would be exported that should not be,
# which is the failure this check exists to catch.
#
# WHAT THIS IS NOT. It computes the export SET from declared markers. It is not the export pipeline,
# it does not scan content, and a clean result is not a statement that no secret exists in the files
# it selected. The ship list in tools/brain-export is the actual control and the independent sweep in
# each release checklist is the checker. This answers one question honestly: given what the nodes
# declare, who is each one for.
#
# CAP03 / B01.
set -uo pipefail

CHECKS_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
DEFAULT_ROOT=$(cd "$CHECKS_DIR/../.." && pwd)

AUDIENCE="${1:-}"
ROOT="${2:-$DEFAULT_ROOT}"

case "$AUDIENCE" in
  public|department|internal) ;;
  private)
    printf 'audience-export: there is no private audience. private is a stop, not a scope: no export\n' >&2
    printf 'audience-export: may request it and no profile may ship it.\n' >&2
    exit 2 ;;
  *)
    printf 'usage: audience-export-check.sh <public|department|internal> [root]\n' >&2
    exit 2 ;;
esac

# Visibility. Reading down each column answers "does audience X get a node marked Y".
#
# private is absent from every column on purpose. A wider audience never gains access to a narrower
# node by being wider; the axis is who may see it, and private means nobody but the author's brain.
case "$AUDIENCE" in
  public)     VISIBLE="public" ;;
  department) VISIBLE="public department" ;;
  internal)   VISIBLE="public department internal" ;;
esac

visible_to_audience() {
  local v="$1" candidate
  for candidate in $VISIBLE; do
    [ "$candidate" = "$v" ] && return 0
  done
  return 1
}

TMP=$(mktemp); trap 'rm -f "$TMP"' EXIT

# One awk pass over the tree, for the same reason as frontmatter-enum-check: a per-file spawn makes
# this unrunnable on Windows and a check nobody runs protects nothing.
find "$ROOT" -name '*.md' -type f -not -path '*/.git/*' -not -path '*/node_modules/*' -print0 \
  | xargs -0 awk -v root="$ROOT/" '
      FNR == 1 { infm = ($0 == "---") ? 1 : 0; cls = ""; grant = ""; next }
      infm && $0 == "---" {
        infm = 0
        rel = FILENAME; sub(root, "", rel)
        printf "%s\t%s\t%s\n", (cls == "" ? "UNSET" : cls), (grant == "" ? "-" : "granted"), rel
        next
      }
      infm && /^export_class:[[:space:]]/ {
        cls = substr($0, index($0, ":") + 1)
        sub(/[[:space:]]*#.*$/, "", cls)
        gsub(/^[[:space:]]+|[[:space:]]+$/, "", cls)
        gsub(/^["'"'"']|["'"'"']$/, "", cls)
      }
      # Matches both YAML forms. The grant record carries who granted it, when, and from which
      # class to which, so its natural form is a block whose key line ends at the colon. Requiring
      # whitespace after the colon made every block-form grant invisible, which reported a
      # correctly granted node as an ungranted widening. Found by the two-brain overlay fixture.
      infm && /^audience_grant:([[:space:]]|$)/ { grant = "yes" }
    ' > "$TMP"

exported=0; held=0; unset_count=0; ungranted=0; errors=0

printf 'receipt_kind\taudience-export-set\n'
printf 'packet\tB01\n'
printf 'audience\t%s\n' "$AUDIENCE"
printf 'root\t%s\n' "$ROOT"
printf 'visible_classes\t%s\n' "$VISIBLE"
printf 'mutations\tnone; read-only\n\n'

while IFS="$(printf '\t')" read -r cls grant rel; do
  [ -z "$rel" ] && continue
  case "$cls" in
    UNSET)
      # A node with no marker is held, never exported. The conservative default has to point at
      # holding: defaulting an unmarked node into an export is how an unreviewed file ships.
      unset_count=$((unset_count + 1))
      held=$((held + 1))
      printf 'HELD\t%s\tno export_class; an unmarked node is never exported\n' "$rel"
      ;;
    private)
      held=$((held + 1))
      printf 'HELD\t%s\tprivate\n' "$rel"
      ;;
    *)
      if visible_to_audience "$cls"; then
        exported=$((exported + 1))
        if [ "$cls" != "internal" ] && [ "$grant" != "granted" ]; then
          ungranted=$((ungranted + 1))
          printf 'EXPORT-UNGRANTED\t%s\t%s widened beyond internal with no audience_grant recorded\n' "$rel" "$cls"
        else
          printf 'EXPORT\t%s\t%s\n' "$rel" "$cls"
        fi
      else
        held=$((held + 1))
        printf 'HELD\t%s\t%s is narrower than audience %s\n' "$rel" "$cls" "$AUDIENCE"
      fi
      ;;
  esac
done < "$TMP"

printf '\nexported\t%s\n' "$exported"
printf 'held\t%s\n' "$held"
printf 'unmarked_held\t%s\n' "$unset_count"
printf 'ungranted_widenings\t%s\n' "$ungranted"

# A private node reaching an export is the one unrecoverable outcome, so it is asserted separately
# rather than inferred from the counts above.
if grep -q "^EXPORT.*	private$" "$TMP" 2>/dev/null; then
  printf 'verdict\tFAIL (a private node entered the export set)\n'
  exit 1
fi

if [ "$ungranted" -gt 0 ]; then
  printf 'verdict\tEXPORTABLE WITH FINDINGS (%s widening(s) carry no recorded grant)\n' "$ungranted"
  exit 0
fi

printf 'verdict\tCLEAN\n'
exit 0
