#!/usr/bin/env bash
# canon-field-check.sh
#
# Deterministic canon-field completeness check for full-canon namespaces.
#
# Implements the four canon-field claims that `_system/promotion-path-rules.md` and
# `_system/freshness-review-rules.md` state, plus the freshness_posture enum claim:
#
#   1. verified_at present on the canon node of record
#   2. verified_by present on the canon node of record
#   3. derived_from provenance present on the canon node of record
#   4. a `## Changelog` section present on the canon node of record
#   5. registry freshness_posture is one of review-on-edit | periodic | live (FRESH-2)
#
# Scope: for every namespace whose registry entry declares `canon_posture: full`, the canon
# nodes of record are `canon/core-doctrine.md` (or `canon/core-contract.md` for the
# tool-contract profile, per namespace-profiles.md) and `canon/current-truth.md` when present.
# The navigational canon files (`canon/README.md`, `canon/agent-load-order.md`) are
# frontmatter-exempt plumbing (V2 contract Part 7.3) and are deliberately out of scope.
#
# Enforcement posture: WARN-ONLY as of 2026-07-16 (sprint 2026-07-16-system-drift-repair).
# `_system/validate.sh` reports this script's findings as warnings and does NOT consume the
# exit code as a failure. The check exits 2 when it finds gaps so a future caller can promote
# it without changing the script.
#
# Why warn-only and not enforced: at implementation the tree could not pass. `verified_at`
# and `verified_by` record OPERATOR approval of canon, and doctrine forbids an agent
# self-approving canon, so the gap cannot be closed by an agent backfilling the fields.
# Promoting this check to error is an operator decision recorded per the promotion path in
# `_system/enforcement-tiers.md`.

set -u

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
NS_DIR="$ROOT/_system/namespaces"
KNOWLEDGE_DIR="$ROOT/knowledge"

issue_count=0
file_count=0

note() {
  echo "canon-field: $1"
  issue_count=$((issue_count + 1))
}

# registry_field <slug> <key>: echo the frontmatter value from _system/namespaces/<slug>.md
registry_field() {
  local slug="$1" key="$2" file="$NS_DIR/$slug.md"
  [[ -f "$file" ]] || return 1
  grep -m1 -E "^${key}:" "$file" 2>/dev/null \
    | sed -E "s/^${key}:[[:space:]]*//" \
    | sed -E 's/^"(.*)"$/\1/' \
    | sed -E "s/^'(.*)'\$/\1/"
}

# frontmatter <file>: echo the YAML block between the first two --- fences
frontmatter() {
  awk 'NR==1 && $0!="---" {exit} NR==1 {next} /^---[[:space:]]*$/ {exit} {print}' "$1"
}

# --- FRESH-2: freshness_posture enum -----------------------------------------------------
for entry in "$NS_DIR"/*.md; do
  [[ -e "$entry" ]] || continue
  base="$(basename "$entry")"
  [[ "$base" == "INDEX.md" ]] && continue
  slug="${base%.md}"
  posture="$(registry_field "$slug" "freshness_posture" || true)"
  case "$posture" in
    review-on-edit|periodic|live) ;;
    "") note "registry _system/namespaces/$base declares no freshness_posture (FRESH-2: expected review-on-edit, periodic, or live)" ;;
    *)  note "registry _system/namespaces/$base declares freshness_posture: $posture (FRESH-2: expected review-on-edit, periodic, or live)" ;;
  esac
done

# --- canon-field presence on full-canon namespaces ---------------------------------------
for entry in "$NS_DIR"/*.md; do
  [[ -e "$entry" ]] || continue
  base="$(basename "$entry")"
  [[ "$base" == "INDEX.md" ]] && continue
  slug="${base%.md}"

  [[ "$(registry_field "$slug" "canon_posture" || true)" == "full" ]] || continue

  canon_dir="$KNOWLEDGE_DIR/$slug/canon"
  if [[ ! -d "$canon_dir" ]]; then
    note "knowledge/$slug declares canon_posture: full but has no canon/ directory"
    continue
  fi

  profile="$(registry_field "$slug" "profile" || true)"
  if [[ "$profile" == "tool-contract" && -f "$canon_dir/core-contract.md" ]]; then
    nodes_of_record=("core-contract.md")
  else
    nodes_of_record=("core-doctrine.md")
  fi
  [[ -f "$canon_dir/current-truth.md" ]] && nodes_of_record+=("current-truth.md")

  for node in "${nodes_of_record[@]}"; do
    target="$canon_dir/$node"
    [[ -f "$target" ]] || continue
    file_count=$((file_count + 1))

    fm="$(frontmatter "$target")"
    missing=()

    grep -qE "^verified_at:" <<< "$fm"  || missing+=("verified_at")
    grep -qE "^verified_by:" <<< "$fm"  || missing+=("verified_by")
    grep -q  "derived_from"   <<< "$fm" || missing+=("derived_from")
    grep -qE "^##[[:space:]]+Changelog" "$target" || missing+=("## Changelog")

    if [[ ${#missing[@]} -gt 0 ]]; then
      note "knowledge/$slug/canon/$node is missing: $(IFS='|'; echo "${missing[*]}" | sed 's/|/, /g')"
    fi
  done
done

if [[ $issue_count -eq 0 ]]; then
  echo "canon-field: all full-canon nodes of record carry verified_at, verified_by, derived_from, and a Changelog, and every registry freshness_posture is in the enum ($file_count node(s) checked)."
  exit 0
fi

echo "canon-field: $issue_count finding(s) across $file_count canon node(s) of record (WARN-ONLY as of 2026-07-16; promotion to error is an operator decision per _system/enforcement-tiers.md)."
exit 2
