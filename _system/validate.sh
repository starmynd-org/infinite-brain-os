#!/usr/bin/env bash
# validate.sh
# Checks every node-bearing file in this repository for required frontmatter keys.
# Run from the repository root: bash _system/validate.sh
# Exit code 0 = all checks pass. Exit code 1 = one or more failures.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
FAIL=0
CHECKED=0
ERRORS=()
WARNINGS=()
KNOWLEDGE_NODE_FILES=()
declare -A KNOWLEDGE_NODE_IDS=()
declare -A KNOWLEDGE_HAS_OUTBOUND=()

REPO_MD_WALK_PRUNES=(
  "$REPO_ROOT/.git"
  "$REPO_ROOT/.obsidian"
  "$REPO_ROOT/.codex"
  "$REPO_ROOT/.claude"
  "$REPO_ROOT/_system"
  "$REPO_ROOT/sessions"
  "$REPO_ROOT/swarms"
  "$REPO_ROOT/docs"
  "$REPO_ROOT/intake"
  "$REPO_ROOT/data/source-archives"
)

GENERATED_MD_WALK_PRUNES=(
  "*/waves/surfaces/dist"
  "*/waves/surfaces/dist/*"
  "*/knowledge/*/archive"
  "*/knowledge/*/archive/*"
  "*/knowledge/*/support"
  "*/knowledge/*/support/*"
  "*/outputs/crm-corpus/generated"
  "*/outputs/crm-corpus/generated/*"
  "*/outputs/crm-corpus/assets"
  "*/outputs/crm-corpus/assets/*"
  "*/node_modules"
  "*/node_modules/*"
)

# Files that are plumbing and do not need frontmatter
PLUMBING_PATTERNS=(
  "README.md"
  "CLAUDE.md"
  "AGENTS.md"
  "CANONICAL-GATES.md"
  "CONTRIBUTING.md"
  "START-HERE.md"
  "OBSIDIAN-DASHBOARD.md"
  ".obsidian/"
  "_system/"
  "swarms/"
  "docs/"
  "data/source-archives/"
  ".claude/hooks/"
  "entities/README.md"
  "sessions/"
)

# REQUIRED_KEYS lists fields every node-bearing file must declare.
# v3.1 (spec revision 4) introduces additional optional fields that this script
# recognizes but does not require. See V3_1_OPTIONAL_KEYS below.
REQUIRED_KEYS=(
  "id:"
  "type:"
  "namespace:"
  "lifecycle_state:"
  "summary:"
  "confidence:"
  "retrieval_class:"
  "export_class:"
)

# v3.1 optional frontmatter fields (recognized; not required)
V3_1_OPTIONAL_KEYS=(
  "state_stored_at:"
  "analytical_view:"
  "candidate_max_age:"
  "group:"
)

is_plumbing() {
  local filepath="$1"
  local rel="${filepath#$REPO_ROOT/}"
  if [[ "$rel" == knowledge/*/INDEX.md ]]; then
    return 0
  fi
  if [[ "$rel" == knowledge/*/support/* ]]; then
    return 0
  fi
  if [[ "$rel" == knowledge/*/archive/* ]]; then
    return 0
  fi
  # V2 (contract Part 7.3): navigational canon and synthesis files carry no node
  # frontmatter. The substantive nodes canon/core-doctrine.md, canon/current-truth.md,
  # and synthesis/*.md (other than synthesis/README.md) are NOT exempted here, so they
  # still require frontmatter.
  if [[ "$rel" == knowledge/*/canon/README.md ]]; then
    return 0
  fi
  if [[ "$rel" == knowledge/*/canon/agent-load-order.md ]]; then
    return 0
  fi
  if [[ "$rel" == knowledge/*/synthesis/README.md ]]; then
    return 0
  fi
  # V2 (contract Part 7.3): the intake/ tree is operative OS scaffolding, not knowledge
  # nodes, so it is exempt from node-frontmatter checks. Processed-receipt completeness
  # is enforced separately below (check_intake_receipt_completeness), not via frontmatter.
  if [[ "$rel" == intake/* ]]; then
    return 0
  fi
  for pattern in "${PLUMBING_PATTERNS[@]}"; do
    if [[ "$rel" == *"$pattern"* ]]; then
      return 0
    fi
  done
  return 1
}

extract_frontmatter() {
  local filepath="$1"
  local line first_line=1 in_frontmatter=0
  local frontmatter_lines=()

  while IFS= read -r line || [[ -n "$line" ]]; do
    if [[ $first_line -eq 1 ]]; then
      first_line=0
      if [[ "$line" != "---" ]]; then
        return 1
      fi
      in_frontmatter=1
      continue
    fi

    if [[ $in_frontmatter -eq 1 && "$line" == "---" ]]; then
      printf '%s\n' "${frontmatter_lines[@]}"
      return 0
    fi

    frontmatter_lines+=("$line")
  done < "$filepath"

  return 1
}

frontmatter_has_key() {
  local frontmatter="$1"
  local key="$2"
  local line
  while IFS= read -r line; do
    [[ "$line" == "$key"* ]] && return 0
  done <<< "$frontmatter"
  return 1
}

trim_wrapping_quotes() {
  local value="$1"
  value="${value%\"}"
  value="${value#\"}"
  value="${value%\'}"
  value="${value#\'}"
  printf '%s\n' "$value"
}

frontmatter_value_from_text() {
  local frontmatter="$1"
  local key="$2"
  local line value
  while IFS= read -r line; do
    [[ "$line" == "$key"* ]] || continue
    value="${line#"$key"}"
    value="${value#"${value%%[![:space:]]*}"}"
    printf '%s\n' "$value"
    return 0
  done <<< "$frontmatter"
  return 1
}

aliases_block_has_value() {
  local frontmatter="$1"
  local wanted="$2"
  local line in_aliases=0 alias_value

  while IFS= read -r line; do
    if [[ $in_aliases -eq 0 ]]; then
      [[ "$line" == "aliases:"* ]] || continue
      in_aliases=1
      continue
    fi

    if [[ "$line" != " "* && "$line" != "-"* ]]; then
      break
    fi

    if [[ "$line" == *"$wanted"* ]]; then
      return 0
    fi

    if [[ "$line" == "-"* ]]; then
      alias_value="${line#-}"
      alias_value="${alias_value#"${alias_value%%[![:space:]]*}"}"
      alias_value="$(trim_wrapping_quotes "$alias_value")"
      [[ "$alias_value" == "$wanted" ]] && return 0
    fi
  done <<< "$frontmatter"

  return 1
}

frontmatter_alias_values() {
  local frontmatter="$1"
  local line in_aliases=0 alias_value inline_values raw_item
  local inline_items=()

  while IFS= read -r line; do
    if [[ $in_aliases -eq 0 ]]; then
      [[ "$line" == "aliases:"* ]] || continue
      inline_values="${line#aliases:}"
      inline_values="${inline_values#"${inline_values%%[![:space:]]*}"}"
      if [[ "$inline_values" == \[*\] ]]; then
        inline_values="${inline_values#[}"
        inline_values="${inline_values%]}"
        IFS=',' read -r -a inline_items <<< "$inline_values"
        for raw_item in "${inline_items[@]}"; do
          alias_value="${raw_item#"${raw_item%%[![:space:]]*}"}"
          alias_value="${alias_value%"${alias_value##*[![:space:]]}"}"
          alias_value="$(trim_wrapping_quotes "$alias_value")"
          [[ -n "$alias_value" ]] && printf '%s\n' "$alias_value"
        done
        return 0
      fi
      in_aliases=1
      continue
    fi

    if [[ "$line" != " "* && "$line" != "-"* ]]; then
      break
    fi

    if [[ "$line" == "-"* ]]; then
      alias_value="${line#-}"
      alias_value="${alias_value#"${alias_value%%[![:space:]]*}"}"
      alias_value="${alias_value%"${alias_value##*[![:space:]]}"}"
      alias_value="$(trim_wrapping_quotes "$alias_value")"
      [[ -n "$alias_value" ]] && printf '%s\n' "$alias_value"
    fi
  done <<< "$frontmatter"
}

repo_markdown_walk() {
  local find_args=("$REPO_ROOT" "(")
  local prune

  for prune in "${REPO_MD_WALK_PRUNES[@]}"; do
    find_args+=(-path "$prune" -o)
  done
  for prune in "${GENERATED_MD_WALK_PRUNES[@]}"; do
    find_args+=(-path "$prune" -o)
  done

  unset 'find_args[${#find_args[@]}-1]'
  find_args+=(")" -prune -o -name "*.md" -print0)

  find "${find_args[@]}"
}

graph_markdown_walk() {
  local root="$1"

  if [[ "$root" == "$REPO_ROOT/knowledge" ]]; then
    find "$root" \
      \( -path '*/.git/*' \
      -o -path '*/archive' \
      -o -path '*/archive/*' \
      -o -path '*/support' \
      -o -path '*/support/*' \
      -o -path '*/waves/surfaces/dist' \
      -o -path '*/waves/surfaces/dist/*' \) -prune \
      -o -name '*.md' -print0
    return
  fi

  find "$root" -name '*.md' -not -path '*/.git/*' -print0
}

GRAPH_MD_GLOBS=(
  "-g" "*.md"
  "-g" "!**/archive/**"
  "-g" "!**/support/**"
  "-g" "!**/waves/surfaces/dist/**"
)

check_project_pointers() {
  local filepath="$1"
  local frontmatter="$2"
  local type_value

  type_value="$(frontmatter_value_from_text "$frontmatter" "type:")"
  type_value="$(trim_wrapping_quotes "$type_value")"
  if [[ "$type_value" =~ ^[Pp]roject$ ]]; then
    local missing=()
    local field
    for field in state_stored_at analytical_view updated project_status owner_department owner_agent parent_initiative review_cadence linked_swarm_id; do
      if ! frontmatter_has_key "$frontmatter" "${field}:"; then
        missing+=("$field")
      fi
    done
    if [[ ${#missing[@]} -gt 0 ]]; then
      WARNINGS+=("PROJECT CONTRACT: ${filepath#$REPO_ROOT/} is missing normalized project field(s): ${missing[*]}")
    fi
  fi
}

check_projects_contract() {
  if [[ -d "$REPO_ROOT/projects" && ! -f "$REPO_ROOT/projects/README.md" ]]; then
    WARNINGS+=("PROJECT CONTRACT: projects/README.md is missing")
  fi
}

frontmatter_value() {
  local filepath="$1"
  local key="$2"
  local frontmatter
  frontmatter="$(extract_frontmatter "$filepath")"
  frontmatter_value_from_text "$frontmatter" "$key"
}

check_obsidian_alias_compat() {
  local filepath="$1"
  local frontmatter="$2"
  local rel basename_no_ext node_id

  rel="${filepath#$REPO_ROOT/}"
  basename_no_ext="$(basename "$filepath" .md)"
  node_id="$(frontmatter_value_from_text "$frontmatter" "id:")"
  node_id="$(trim_wrapping_quotes "$node_id")"

  if [[ -z "$node_id" || "$basename_no_ext" == "$node_id" ]]; then
    return
  fi

  if ! aliases_block_has_value "$frontmatter" "$node_id"; then
    WARNINGS+=("OBSIDIAN COMPAT: $rel links best by filename '$basename_no_ext', but id is '$node_id' and aliases does not include that id")
  fi
}

# ---------------------------------------------------------------------------
# V2 profile-aware checks (contract Part 7.3, guardrail G5)
# ---------------------------------------------------------------------------

# registry_field <namespace-slug> <field-key>
# Reads a single scalar field from the frontmatter of
# _system/namespaces/<slug>.md. Returns empty string if the registry file or the
# field is absent (graceful when V2 fields have not been added yet).
registry_field() {
  local slug="$1"
  local key="$2"
  local ns_file="$REPO_ROOT/_system/namespaces/${slug}.md"
  [[ -f "$ns_file" ]] || return 0
  awk '/^---/{c++;next} c==1{print} c==2{exit}' "$ns_file" \
    | sed -n "s/^${key}:[[:space:]]*//p" \
    | head -1 \
    | tr -d '"' \
    | tr -d "'"
}

# Serious-namespace base surfaces (contract Part 1.2).
BASE_SURFACES=(INDEX.md canon playbooks support synthesis)

# Reduced-base namespaces are exempted from the serious-base-surface requirement.
# personal-operator GRADUATED to a serious namespace on 2026-06-03 (sprint
# 2026-06-03-chief-of-staff-buildout, Wave 0) and was removed from this list so its serious
# base is enforced (migration Rule 6: the validator evolves with the doctrine in the same wave).
# _examples/* starter scaffolds remain reduced-base via is_reduced_base_namespace below.
REDUCED_BASE_NAMESPACES=()

is_reduced_base_namespace() {
  local slug="$1"
  local ns
  # Registry-driven (preferred): a namespace declares `reduced_base: true` in its registry entry.
  # Graduating a namespace to the serious base is then a registry edit (set false / remove the field),
  # not a validator code change. This is the scalable path for many departments bringing domain
  # namespaces that start reduced-base and graduate.
  [[ "$(registry_field "$slug" "reduced_base")" == "true" ]] && return 0
  # Legacy explicit list (kept for any namespace not yet carrying the registry field).
  for ns in "${REDUCED_BASE_NAMESPACES[@]}"; do
    [[ "$slug" == "$ns" ]] && return 0
  done
  # Treat any _examples/* namespace as reduced base (starter and example scaffolds).
  [[ "$slug" == _examples* ]] && return 0
  return 1
}

# is_v2_queued
# A namespace whose registry declares v2_status: queued is scheduled for V2 upgrade but
# not yet upgraded (contract Part 12, migration compatibility: additive and non-blocking
# during transition). Its missing base surfaces and full-canon files are WARNINGS, not
# ERRORS, so the validator stays green while the queued upgrade is tracked in the audit
# packets. Any namespace without v2_status: queued (absent, or v2_status: upgraded) is
# enforced as an ERROR, so V2-upgraded and newly created namespaces must comply.
is_v2_queued() {
  local slug="$1"
  [[ "$(registry_field "$slug" "v2_status")" == "queued" ]]
}

# check_base_surfaces
# Every serious namespace under knowledge/ must have the shared base surfaces. Missing
# a base surface is an error. Reduced-base namespaces (_examples/* starter scaffolds)
# are exempt.
check_base_surfaces() {
  local ns_dir slug surface target queued msg
  for ns_dir in "$REPO_ROOT"/knowledge/*/; do
    [[ -d "$ns_dir" ]] || continue
    slug="$(basename "$ns_dir")"
    [[ "$slug" == _examples ]] && continue
    if is_reduced_base_namespace "$slug"; then
      continue
    fi
    queued=0
    is_v2_queued "$slug" && queued=1
    for surface in "${BASE_SURFACES[@]}"; do
      target="${ns_dir}${surface}"
      if [[ "$surface" == *.md ]]; then
        [[ -f "$target" ]] && continue
      else
        [[ -d "$target" ]] && continue
      fi
      msg="knowledge/$slug is missing required $([[ "$surface" == *.md ]] && echo "file '$surface'" || echo "folder '$surface/'") (contract Part 1.2)"
      if [[ $queued -eq 1 ]]; then
        WARNINGS+=("QUEUED V2 GAP: $msg [v2_status: queued, upgrade tracked in Namespace_Audits]")
      else
        ERRORS+=("MISSING BASE SURFACE: $msg")
        FAIL=1
      fi
    done
  done
}

# check_full_canon
# Namespaces with canon_posture: full must carry canon/README.md, canon/core-doctrine.md,
# and canon/agent-load-order.md (contract Part 3.3, Part 3.5). canon_posture is read from
# the registry frontmatter; namespaces without the field are skipped.
# Profile awareness: a namespace whose registry entry declares profile: tool-contract uses
# canon/core-contract.md as its canon file of record (namespace-profiles.md, tool-contract
# profile), so core-contract.md satisfies the core-doctrine.md requirement for it.
check_full_canon() {
  local ns_dir slug posture profile cf queued
  local full_canon_files=(README.md core-doctrine.md agent-load-order.md)
  for ns_dir in "$REPO_ROOT"/knowledge/*/; do
    [[ -d "$ns_dir" ]] || continue
    slug="$(basename "$ns_dir")"
    [[ "$slug" == _examples ]] && continue
    posture="$(registry_field "$slug" "canon_posture")"
    [[ "$posture" == "full" ]] || continue
    profile="$(registry_field "$slug" "profile")"
    queued=0
    is_v2_queued "$slug" && queued=1
    for cf in "${full_canon_files[@]}"; do
      if [[ "$cf" == "core-doctrine.md" && "$profile" == "tool-contract" && -f "${ns_dir}canon/core-contract.md" ]]; then
        continue
      fi
      [[ -f "${ns_dir}canon/${cf}" ]] && continue
      if [[ $queued -eq 1 ]]; then
        WARNINGS+=("QUEUED V2 GAP: knowledge/$slug declares canon_posture: full but is missing canon/$cf (contract Part 3.3) [v2_status: queued, upgrade tracked in Namespace_Audits]")
      else
        ERRORS+=("MISSING FULL-CANON FILE: knowledge/$slug declares canon_posture: full but is missing canon/$cf (contract Part 3.3)")
        FAIL=1
      fi
    done
  done
}

check_sessions_base() {
  local sessions_dir="$REPO_ROOT/sessions"
  local required=("README.md" "active" "closed" "logs" "reviews" "templates")
  local item

  [[ -d "$sessions_dir" ]] || return 0

  for item in "${required[@]}"; do
    if [[ "$item" == *.md ]]; then
      [[ -f "$sessions_dir/$item" ]] && continue
      ERRORS+=("MISSING SESSIONS SURFACE: sessions/$item is required by session-ledger-rules")
      FAIL=1
    else
      [[ -d "$sessions_dir/$item" ]] && continue
      ERRORS+=("MISSING SESSIONS SURFACE: sessions/$item/ is required by session-ledger-rules")
      FAIL=1
    fi
  done
}

# check_surface_declarations
# Every live surface declaration under _system/surface-registry/ must carry all nine
# declaration items (surface-contract-rules.md). INDEX.md, README.md, and _-prefixed
# templates are skipped. No-op while no surface is registered. Reasoning: [[surface-boundary]].
check_surface_declarations() {
  local reg_dir="$REPO_ROOT/_system/surface-registry"
  local f base rel field
  local required_fields=(
    "Truth sources read"
    "Owned runtime state"
    "Disallowed ownership"
    "Write paths"
    "Promotion and approval gates"
    "Identity and auth boundary"
    "Agent runtime binding"
    "Observability and metering"
    "Self-host posture"
  )

  [[ -d "$reg_dir" ]] || return 0

  for f in "$reg_dir"/*.md; do
    [[ -e "$f" ]] || continue
    base="$(basename "$f")"
    [[ "$base" == "INDEX.md" || "$base" == "README.md" || "$base" == _* ]] && continue
    rel="${f#$REPO_ROOT/}"
    for field in "${required_fields[@]}"; do
      if ! grep -Fq -- "$field" "$f"; then
        ERRORS+=("INCOMPLETE SURFACE DECLARATION: $rel is missing the '$field' item (9-item contract in _system/surface-contract-rules.md)")
        FAIL=1
      fi
    done
  done
}

normalize_wikilink_target() {
  local target="$1"
  target="${target#\[\[}"
  target="${target%\]\]}"
  target="${target%%|*}"
  target="${target%%#*}"
  target="${target##*/}"
  target="${target#"${target%%[![:space:]]*}"}"
  target="${target%"${target##*[![:space:]]}"}"
  printf '%s\n' "$target"
}

normalize_relative_link_target() {
  local target="$1"
  target="${target#](}"
  target="${target%)}"
  target="${target%% *}"
  printf '%s\n' "$target"
}

populate_resolvable_targets() {
  local path match frontmatter target_id alias_value base_name

  if command -v rg >/dev/null 2>&1; then
    while IFS= read -r -d '' path; do
      base_name="${path##*/}"
      RESOLVABLE_TARGETS["${base_name%.md}"]=1
    done < <(rg --files --null "${LINK_INDEX_DIRS[@]}" "${GRAPH_MD_GLOBS[@]}")

    while IFS= read -r match; do
      match="${match#id:}"
      match="${match#"${match%%[![:space:]]*}"}"
      match="$(trim_wrapping_quotes "$match")"
      [[ -n "$match" ]] && RESOLVABLE_TARGETS["$match"]=1
    done < <(rg --no-filename -o '^id:[[:space:]]*["'"'"']?[^"'"'"']+' "${LINK_INDEX_DIRS[@]}" "${GRAPH_MD_GLOBS[@]}")

    while IFS= read -r match; do
      match="$(trim_wrapping_quotes "$match")"
      [[ -n "$match" ]] && RESOLVABLE_TARGETS["$match"]=1
    done < <(rg --no-filename -o '"[a-z0-9][a-z0-9-]*"' "${LINK_INDEX_DIRS[@]}" "${GRAPH_MD_GLOBS[@]}")
    return
  fi

  for path in "${LINK_INDEX_DIRS[@]}"; do
    [[ -d "$path" ]] || continue
    while IFS= read -r -d '' path; do
      base_name="${path##*/}"
      RESOLVABLE_TARGETS["${base_name%.md}"]=1
      if frontmatter="$(extract_frontmatter "$path")"; then
        target_id="$(frontmatter_value_from_text "$frontmatter" "id:")"
        target_id="$(trim_wrapping_quotes "$target_id")"
        [[ -n "$target_id" ]] && RESOLVABLE_TARGETS["$target_id"]=1
        while IFS= read -r alias_value; do
          [[ -n "$alias_value" ]] && RESOLVABLE_TARGETS["$alias_value"]=1
        done < <(frontmatter_alias_values "$frontmatter")
      fi
    done < <(graph_markdown_walk "$path")
  done
}

scan_knowledge_links() {
  local entry rel file_dir link_target resolved file rest

  if command -v rg >/dev/null 2>&1; then
    while IFS= read -r entry; do
      file="${entry%%:*}"
      rest="${entry#*:}"
      rest="${rest#*:}"
      link_target="$(normalize_wikilink_target "$rest")"
      [[ -z "$link_target" ]] && continue
      REFERENCED_NAMES["$link_target"]=1
      if [[ -z "${RESOLVABLE_TARGETS[$link_target]+x}" ]]; then
        rel="${file#$REPO_ROOT/}"
        WARNINGS+=("BROKEN WIKILINK: $rel references [[$link_target]] but no file '$link_target.md' or matching id/alias exists in the vault (knowledge/, _system/, entities/, workflows/, intake/)")
        BROKEN_LINK_WARN=$((BROKEN_LINK_WARN + 1))
      fi
    done < <(rg -n -o --no-heading --color=never '\[\[[^\[\]]+\]\]' "$REPO_ROOT/knowledge" "${GRAPH_MD_GLOBS[@]}")

    while IFS= read -r entry; do
      file="${entry%%:*}"
      rest="${entry#*:}"
      rest="${rest#*:}"
      link_target="$(normalize_relative_link_target "$rest")"
      case "$link_target" in
        http://*|https://*|mailto:*|\#*|"") continue ;;
      esac
      link_target="${link_target%%#*}"
      [[ -z "$link_target" ]] && continue
      [[ "$link_target" == *.md ]] || continue
      file_dir="${file%/*}"
      if [[ "$link_target" == /* ]]; then
        resolved="$REPO_ROOT$link_target"
      else
        resolved="$file_dir/$link_target"
      fi
      if [[ ! -f "$resolved" ]]; then
        rel="${file#$REPO_ROOT/}"
        WARNINGS+=("BROKEN RELATIVE LINK: $rel points at '$link_target' which does not resolve to a file")
        BROKEN_LINK_WARN=$((BROKEN_LINK_WARN + 1))
      fi
    done < <(rg -n -o --no-heading --color=never '\]\([^)]+\)' "$REPO_ROOT/knowledge" "${GRAPH_MD_GLOBS[@]}")
    return
  fi

  while IFS= read -r -d '' file; do
    rel="${file#$REPO_ROOT/}"
    [[ "$rel" == knowledge/*/archive/* ]] && continue
    file_dir="${file%/*}"
    while IFS=$'\t' read -r link_type link_target; do
      [[ -z "$link_target" ]] && continue
      if [[ "$link_type" == "wiki" ]]; then
        REFERENCED_NAMES["$link_target"]=1
        if [[ -z "${RESOLVABLE_TARGETS[$link_target]+x}" ]]; then
          WARNINGS+=("BROKEN WIKILINK: $rel references [[$link_target]] but no file '$link_target.md' or matching id/alias exists in the vault (knowledge/, _system/, entities/, workflows/, intake/)")
          BROKEN_LINK_WARN=$((BROKEN_LINK_WARN + 1))
        fi
        continue
      fi

      case "$link_target" in
        http://*|https://*|mailto:*|\#*|"") continue ;;
      esac
      link_target="${link_target%%#*}"
      [[ -z "$link_target" ]] && continue
      [[ "$link_target" == *.md ]] || continue
      if [[ "$link_target" == /* ]]; then
        resolved="$REPO_ROOT$link_target"
      else
        resolved="$file_dir/$link_target"
      fi
      if [[ ! -f "$resolved" ]]; then
        WARNINGS+=("BROKEN RELATIVE LINK: $rel points at '$link_target' which does not resolve to a file")
        BROKEN_LINK_WARN=$((BROKEN_LINK_WARN + 1))
      fi
    done < <(
      awk '
        {
          wiki_line = $0
          while (match(wiki_line, /\[\[[^][]+\]\]/)) {
            target = substr(wiki_line, RSTART + 2, RLENGTH - 4)
            sub(/\|.*/, "", target)
            sub(/#.*/, "", target)
            sub(/^.*\//, "", target)
            gsub(/^[[:space:]]+|[[:space:]]+$/, "", target)
            if (target != "") {
              print "wiki\t" target
            }
            wiki_line = substr(wiki_line, RSTART + RLENGTH)
          }

          rel_line = $0
          while (match(rel_line, /\]\([^)]+\)/)) {
            target = substr(rel_line, RSTART + 2, RLENGTH - 3)
            sub(/[[:space:]].*$/, "", target)
            if (target != "") {
              print "rel\t" target
            }
            rel_line = substr(rel_line, RSTART + RLENGTH)
          }
        }
      ' "$file"
    )
  done < <(graph_markdown_walk "$REPO_ROOT/knowledge")
}

run_python_markdown_scan() {
  python3 - "$REPO_ROOT" <<'PY'
import fnmatch
import os
import re
import sys

repo = os.path.abspath(sys.argv[1])
required_keys = [
    "id:",
    "type:",
    "namespace:",
    "lifecycle_state:",
    "summary:",
    "confidence:",
    "retrieval_class:",
    "export_class:",
]
project_fields = [
    "state_stored_at",
    "analytical_view",
    "updated",
    "project_status",
    "owner_department",
    "owner_agent",
    "parent_initiative",
    "review_cadence",
    "linked_swarm_id",
]
plumbing_patterns = [
    "README.md",
    "CLAUDE.md",
    "AGENTS.md",
    "CANONICAL-GATES.md",
    "CONTRIBUTING.md",
    "START-HERE.md",
    "OBSIDIAN-DASHBOARD.md",
    ".obsidian/",
    "_system/",
    "swarms/",
    "docs/",
    "data/source-archives/",
    ".claude/hooks/",
    "entities/README.md",
    "sessions/",
]
repo_walk_prunes = {
    ".git",
    ".obsidian",
    ".codex",
    ".claude",
    "_system",
    "sessions",
    "swarms",
    "docs",
    "intake",
}
graph_roots = ["knowledge", "_system", "entities", "workflows", "intake"]

wikilink_re = re.compile(r"\[\[([^\[\]]+)\]\]")
relative_link_re = re.compile(r"\]\(([^)]+)\)")
quoted_slug_re = re.compile(r'"([a-z0-9][a-z0-9-]*)"')

def relpath(path: str) -> str:
    return os.path.relpath(path, repo).replace(os.sep, "/")

def trim_quotes(value: str) -> str:
    value = value.strip()
    if len(value) >= 2 and value[0] == value[-1] and value[0] in {"'", '"'}:
        return value[1:-1]
    return value

def frontmatter_data(path: str):
    try:
        with open(path, "r", encoding="utf-8") as fh:
            text = fh.read()
    except UnicodeDecodeError:
        with open(path, "r", encoding="utf-8", errors="replace") as fh:
            text = fh.read()
    lines = text.splitlines()
    if not lines or lines[0] != "---":
        return None, None, text
    fm_lines = []
    for line in lines[1:]:
        if line == "---":
            return "\n".join(fm_lines), fm_lines, text
        fm_lines.append(line)
    return None, None, text

def fm_has_key(fm_lines, key):
    return any(line.startswith(key) for line in fm_lines)

def fm_value(fm_lines, key):
    prefix = f"{key}:"
    for line in fm_lines:
      if line.startswith(prefix):
        return line[len(prefix):].lstrip()
    return ""

def alias_values(fm_lines):
    values = []
    in_aliases = False
    for line in fm_lines:
        if not in_aliases:
            if not line.startswith("aliases:"):
                continue
            inline = line[len("aliases:"):].strip()
            if inline.startswith("[") and inline.endswith("]"):
                inner = inline[1:-1]
                for raw in inner.split(","):
                    value = trim_quotes(raw.strip())
                    if value:
                        values.append(value)
                return values
            in_aliases = True
            continue
        if line and not line.startswith(" ") and not line.startswith("-"):
            break
        stripped = line.lstrip()
        if stripped.startswith("-"):
            value = trim_quotes(stripped[1:].strip())
            if value:
                values.append(value)
    return values

def aliases_has_value(fm_lines, wanted):
    in_aliases = False
    for line in fm_lines:
        if not in_aliases:
            if not line.startswith("aliases:"):
                continue
            in_aliases = True
            inline = line[len("aliases:"):].strip()
            if inline.startswith("[") and inline.endswith("]"):
                return wanted in alias_values(fm_lines)
            continue
        if line and not line.startswith(" ") and not line.startswith("-"):
            break
        if wanted in line:
            return True
        stripped = line.lstrip()
        if stripped.startswith("-") and trim_quotes(stripped[1:].strip()) == wanted:
            return True
    return False

def is_generated_excluded(rel):
    if "/waves/surfaces/dist/" in f"/{rel}/":
        return True
    return (
        rel.startswith("knowledge/")
        and (
            "/archive/" in rel
            or rel.endswith("/archive")
            or "/support/" in rel
            or rel.endswith("/support")
        )
    )

def is_plumbing(rel):
    if fnmatch.fnmatch(rel, "knowledge/*/INDEX.md"):
        return True
    if fnmatch.fnmatch(rel, "knowledge/*/support/*"):
        return True
    if fnmatch.fnmatch(rel, "knowledge/*/archive/*"):
        return True
    if fnmatch.fnmatch(rel, "knowledge/*/canon/README.md"):
        return True
    if fnmatch.fnmatch(rel, "knowledge/*/canon/agent-load-order.md"):
        return True
    if fnmatch.fnmatch(rel, "knowledge/*/synthesis/README.md"):
        return True
    if rel.startswith("intake/"):
        return True
    if rel.startswith("outputs/crm-corpus/generated/"):
        return True
    if rel.startswith("outputs/crm-corpus/assets/"):
        return True
    return any(pattern in rel for pattern in plumbing_patterns)

def walk_repo_markdown():
    for root, dirs, files in os.walk(repo):
        rel_root = os.path.relpath(root, repo).replace(os.sep, "/")
        dirs[:] = [
            d for d in dirs
            if not (
                d == "node_modules"
                or (rel_root == "." and d in repo_walk_prunes)
                or (rel_root == "data" and d == "source-archives")
                or (
                    rel_root.startswith("knowledge/")
                    and d in {"archive", "support"}
                )
                or (
                    rel_root.endswith("waves/surfaces")
                    and d == "dist"
                )
            )
        ]
        for name in files:
            if not name.endswith(".md"):
                continue
            path = os.path.join(root, name)
            rel = relpath(path)
            if is_generated_excluded(rel):
                continue
            yield path, rel

def walk_graph_markdown(root_name):
    root = os.path.join(repo, root_name)
    if not os.path.isdir(root):
        return
    for current_root, dirs, files in os.walk(root):
        rel_root = relpath(current_root)
        dirs[:] = [
            d for d in dirs
            if not (
                d == ".git"
                or (
                    root_name == "knowledge"
                    and (
                        d in {"archive", "support"}
                        or (rel_root.endswith("waves/surfaces") and d == "dist")
                    )
                )
            )
        ]
        for name in files:
            if not name.endswith(".md"):
                continue
            path = os.path.join(current_root, name)
            rel = relpath(path)
            if root_name == "knowledge" and is_generated_excluded(rel):
                continue
            yield path, rel

checked = 0
errors = []
warnings = []
knowledge_nodes = []

for path, rel in walk_repo_markdown():
    if is_plumbing(rel):
        continue
    checked += 1
    fm_text, fm_lines, text = frontmatter_data(path)
    if fm_text is None:
        errors.append(f"MISSING FRONTMATTER: {rel}")
        continue

    for key in required_keys:
        if not fm_has_key(fm_lines, key):
            errors.append(f"MISSING KEY '{key}': {rel}")

    type_value = trim_quotes(fm_value(fm_lines, "type"))
    if type_value.lower() == "project":
        missing = [field for field in project_fields if not fm_has_key(fm_lines, f"{field}:")]
        if missing:
            warnings.append(
                f"PROJECT CONTRACT: {rel} is missing normalized project field(s): {' '.join(missing)}"
            )

    node_id = trim_quotes(fm_value(fm_lines, "id"))
    base_name = os.path.splitext(os.path.basename(path))[0]
    if node_id and base_name != node_id and not aliases_has_value(fm_lines, node_id):
        warnings.append(
            f"OBSIDIAN COMPAT: {rel} links best by filename '{base_name}', but id is '{node_id}' and aliases does not include that id"
        )

    if rel.startswith("knowledge/") and "/archive/" not in rel and os.path.basename(path) != "INDEX.md":
        knowledge_nodes.append(
            {
                "rel": rel,
                "base": base_name,
                "id": node_id,
                "has_outbound": fm_has_key(fm_lines, "edges:") and "target: [[" in fm_text,
            }
        )

resolvable = set()
for root_name in graph_roots:
    for path, rel in walk_graph_markdown(root_name):
        base_name = os.path.splitext(os.path.basename(path))[0]
        resolvable.add(base_name)
        fm_text, fm_lines, text = frontmatter_data(path)
        if fm_lines:
            target_id = trim_quotes(fm_value(fm_lines, "id"))
            if target_id:
                resolvable.add(target_id)
        for match in quoted_slug_re.findall(text):
            resolvable.add(match)

referenced = set()
for path, rel in walk_graph_markdown("knowledge"):
    _, _, text = frontmatter_data(path)
    for raw in wikilink_re.findall(text):
        target = raw.split("|", 1)[0].split("#", 1)[0].rsplit("/", 1)[-1].strip()
        if not target:
            continue
        referenced.add(target)
        if target not in resolvable:
            warnings.append(
                f"BROKEN WIKILINK: {rel} references [[{target}]] but no file '{target}.md' or matching id/alias exists in the vault (knowledge/, _system/, entities/, workflows/, intake/)"
            )
    file_dir = os.path.dirname(path)
    for raw in relative_link_re.findall(text):
        target = raw.split(" ", 1)[0]
        if not target or target.startswith(("http://", "https://", "mailto:", "#")):
            continue
        target = target.split("#", 1)[0]
        if not target.endswith(".md"):
            continue
        resolved = os.path.join(repo, target.lstrip("/")) if target.startswith("/") else os.path.join(file_dir, target)
        if not os.path.isfile(resolved):
            warnings.append(
                f"BROKEN RELATIVE LINK: {rel} points at '{target}' which does not resolve to a file"
            )

for node in knowledge_nodes:
    if node["has_outbound"]:
        continue
    if node["base"] in referenced:
        continue
    if node["id"] and node["id"] in referenced:
        continue
    warnings.append(
        f"ORPHAN NODE: {node['rel']} has no outbound edges and is not referenced by any other node"
    )

print(f"CHECKED\t{checked}")
for warning in warnings:
    print(f"WARNING\t{warning}")
for error in errors:
    print(f"ERROR\t{error}")
PY
}

FAST_PYTHON_SCAN=0
if command -v python3 >/dev/null 2>&1; then
  while IFS=$'\t' read -r kind payload; do
    case "$kind" in
      CHECKED)
        CHECKED="$payload"
        ;;
      WARNING)
        WARNINGS+=("$payload")
        ;;
      ERROR)
        ERRORS+=("$payload")
        FAIL=1
        ;;
    esac
  done < <(run_python_markdown_scan)
  FAST_PYTHON_SCAN=1
else
  while IFS= read -r -d '' file; do
    if is_plumbing "$file"; then
      continue
    fi

    if [[ "$file" != *.md ]]; then
      continue
    fi

    CHECKED=$((CHECKED + 1))
    rel="${file#$REPO_ROOT/}"

    if ! frontmatter="$(extract_frontmatter "$file")"; then
      ERRORS+=("MISSING FRONTMATTER: $rel")
      FAIL=1
      continue
    fi

    for key in "${REQUIRED_KEYS[@]}"; do
      if ! frontmatter_has_key "$frontmatter" "$key"; then
        ERRORS+=("MISSING KEY '$key': $rel")
        FAIL=1
      fi
    done

    check_project_pointers "$file" "$frontmatter"
    check_obsidian_alias_compat "$file" "$frontmatter"

    if [[ "$rel" == knowledge/* && "$rel" != knowledge/*/archive/* ]]; then
      base_name="${file##*/}"
      if [[ "$base_name" != "INDEX.md" ]]; then
        node_id="$(frontmatter_value_from_text "$frontmatter" "id:")"
        node_id="$(trim_wrapping_quotes "$node_id")"
        KNOWLEDGE_NODE_FILES+=("$file")
        KNOWLEDGE_NODE_IDS["$file"]="$node_id"
        if frontmatter_has_key "$frontmatter" "edges:" && [[ "$frontmatter" == *"target: [["* ]]; then
          KNOWLEDGE_HAS_OUTBOUND["$file"]=1
        else
          KNOWLEDGE_HAS_OUTBOUND["$file"]=0
        fi
      fi
    fi
  done < <(repo_markdown_walk)
fi

NAMESPACE_DIR="$REPO_ROOT/_system/namespaces"
NS_CHECKED=0

NAMESPACE_REQUIRED_KEYS=(
  "id:"
  "name:"
  "purpose:"
  "owner:"
  "lifecycle_state:"
  "created:"
)

NAMESPACE_ALLOWED_LIFECYCLE="scratch|research|candidate|canon|archive"

if [[ -d "$NAMESPACE_DIR" ]]; then
  echo "Checking namespace files in _system/namespaces/..."
  while IFS= read -r -d '' ns_file; do
    local_frontmatter=""
    ns_rel="${ns_file#$REPO_ROOT/}"
    ns_base="$(basename "$ns_file")"

    if [[ "$ns_base" == "INDEX.md" ]]; then
      continue
    fi

    NS_CHECKED=$((NS_CHECKED + 1))

    if ! local_frontmatter="$(extract_frontmatter "$ns_file")"; then
      ERRORS+=("NAMESPACE FILE MISSING FRONTMATTER: $ns_rel")
      FAIL=1
      continue
    fi

    for key in "${NAMESPACE_REQUIRED_KEYS[@]}"; do
      if ! frontmatter_has_key "$local_frontmatter" "$key"; then
        ERRORS+=("NAMESPACE FILE MISSING KEY '$key': $ns_rel")
        FAIL=1
      fi
    done

    ls_value="$(frontmatter_value_from_text "$local_frontmatter" "lifecycle_state:")"
    ls_value="$(trim_wrapping_quotes "$ls_value")"
    if [[ -n "$ls_value" ]] && ! [[ "$ls_value" =~ ^($NAMESPACE_ALLOWED_LIFECYCLE)$ ]]; then
      ERRORS+=("NAMESPACE FILE INVALID lifecycle_state '$ls_value' (must be $NAMESPACE_ALLOWED_LIFECYCLE): $ns_rel")
      FAIL=1
    fi

    if frontmatter_has_key "$local_frontmatter" "group:"; then
      group_value="$(frontmatter_value_from_text "$local_frontmatter" "group:")"
      group_value="$(trim_wrapping_quotes "$group_value")"
      if [[ -z "$group_value" ]]; then
        ERRORS+=("NAMESPACE FILE EMPTY group: field (omit the field or set a value): $ns_rel")
        FAIL=1
      fi
    fi
  done < <(find "$NAMESPACE_DIR" -maxdepth 1 -name "*.md" -print0)

  echo "Checked $NS_CHECKED namespace files."
fi

echo "Checking runtime adapter files..."

if [[ -f "$REPO_ROOT/paperclip-mapping.json" ]]; then
  if command -v python3 >/dev/null 2>&1; then
    if ! python3 -m json.tool "$REPO_ROOT/paperclip-mapping.json" >/dev/null 2>&1; then
      ERRORS+=("INVALID JSON: paperclip-mapping.json")
      FAIL=1
    fi
  else
    WARNINGS+=("python3 not found; skipped JSON validation for paperclip-mapping.json")
  fi
fi

N8N_DIR="$REPO_ROOT/automations/n8n"
if [[ -d "$N8N_DIR" ]]; then
  while IFS= read -r -d '' json_file; do
    rel="${json_file#$REPO_ROOT/}"
    companion="${json_file%.json}.md"
    if [[ ! -f "$companion" ]]; then
      ERRORS+=("N8N WORKFLOW MISSING COMPANION MD: $rel")
      FAIL=1
    fi
    if command -v python3 >/dev/null 2>&1; then
      if ! python3 -m json.tool "$json_file" >/dev/null 2>&1; then
        ERRORS+=("INVALID N8N WORKFLOW JSON: $rel")
        FAIL=1
      fi
      semantic_output="$(python3 - <<'PY' "$json_file"
import json, sys
path = sys.argv[1]
with open(path, "r", encoding="utf-8") as fh:
    data = json.load(fh)
nodes = data.get("nodes", [])
messages = []
for node in nodes:
    node_type = node.get("type", "")
    params = node.get("parameters", {}) or {}
    if node_type == "n8n-nodes-base.ssh" and "authentication" not in params:
        messages.append(f"SSH_AUTH:{node.get('name', '<unnamed>')}")
    if node_type == "n8n-nodes-base.webhook":
        messages.append("WEBHOOK_PROBE")
print("\n".join(messages))
PY
)"
      if printf '%s\n' "$semantic_output" | grep -q '^SSH_AUTH:'; then
        WARNINGS+=("N8N RUNTIME COMPAT: $rel contains SSH node(s) without explicit authentication mode; declare privateKey or password explicitly")
      fi
      if printf '%s\n' "$semantic_output" | grep -q '^WEBHOOK_PROBE$'; then
        WARNINGS+=("N8N RUNTIME COMPAT: $rel contains webhook node(s); import plus activation is not enough, so record a post-activation endpoint probe and track unresolved parity in PKM-19")
      fi
    else
      WARNINGS+=("python3 not found; skipped JSON validation for $rel")
    fi
  done < <(find "$N8N_DIR" -maxdepth 1 -name "*.json" -print0)

  while IFS= read -r -d '' md_file; do
    rel="${md_file#$REPO_ROOT/}"
    companion="${md_file%.md}.json"
    if [[ ! -f "$companion" ]]; then
      ERRORS+=("N8N COMPANION MD MISSING WORKFLOW JSON: $rel")
      FAIL=1
    fi
  done < <(find "$N8N_DIR" -maxdepth 1 -name "*.md" -print0)
fi

echo "Checking V2 base surfaces and canon posture..."
check_base_surfaces
check_full_canon
check_sessions_base
check_surface_declarations
check_projects_contract

# ---------------------------------------------------------------------------
# Broken-link detection (contract Part 7.3). Warnings, not errors, so forward
# references and not-yet-built nodes do not block the build.
# ---------------------------------------------------------------------------
echo "Checking links (wikilinks and relative markdown links)..."

# Build the resolvable-target index once: every node name under knowledge/ and
# _system/ that a [[wikilink]] could resolve to. A target resolves if a file named
# <name>.md exists anywhere under those trees, or if <name> is declared as an id or
# alias in any frontmatter. We index by basename without extension plus declared ids.
LINK_INDEX_DIRS=("$REPO_ROOT/knowledge" "$REPO_ROOT/_system" "$REPO_ROOT/entities" "$REPO_ROOT/workflows" "$REPO_ROOT/intake")
declare -A RESOLVABLE_TARGETS=()
declare -A REFERENCED_NAMES=()
BROKEN_LINK_WARN=0
if [[ $FAST_PYTHON_SCAN -eq 0 ]]; then
  populate_resolvable_targets
  scan_knowledge_links
fi

# ---------------------------------------------------------------------------
# Orphan detection (contract Part 7.3). A knowledge node with no outbound edges
# AND no inbound reference from any other node is an orphan. Warning only.
# Scope: substantive nodes only (exclude archive, support, INDEX). The candidate set
# is small (about 70 nodes) so this is cheap.
# ---------------------------------------------------------------------------
echo "Checking for orphan nodes..."
if [[ $FAST_PYTHON_SCAN -eq 0 ]]; then
  for file in "${KNOWLEDGE_NODE_FILES[@]}"; do
    rel="${file#$REPO_ROOT/}"
    base="${file##*/}"
    base="${base%.md}"
    node_id="${KNOWLEDGE_NODE_IDS["$file"]-}"
    has_outbound="${KNOWLEDGE_HAS_OUTBOUND["$file"]-0}"

    referenced=0
    if [[ -n "${REFERENCED_NAMES[$base]+x}" ]]; then
      referenced=1
    elif [[ -n "$node_id" && -n "${REFERENCED_NAMES[$node_id]+x}" ]]; then
      referenced=1
    fi

    if [[ $has_outbound -eq 0 && $referenced -eq 0 ]]; then
      WARNINGS+=("ORPHAN NODE: $rel has no outbound edges and is not referenced by any other node")
    fi
  done
fi

# ---------------------------------------------------------------------------
# Intake completeness (contract Part 7.3). A processed receipt missing a routing
# decision link or a destination link is an error in intake/. Real receipts are
# files under intake/processed/ or intake/destinations/*/processed/ that carry
# frontmatter type: "processed-receipt". The schema doc under intake/schemas/ has no
# frontmatter and is not a receipt, so it is not checked.
# ---------------------------------------------------------------------------
echo "Checking intake processed-receipt completeness..."
INTAKE_PROCESSED_DIRS=("$REPO_ROOT/intake/processed" "$REPO_ROOT/intake/destinations")
RECEIPTS_CHECKED=0
for pdir in "${INTAKE_PROCESSED_DIRS[@]}"; do
  [[ -d "$pdir" ]] || continue
  while IFS= read -r -d '' rfile; do
    rrel="${rfile#$REPO_ROOT/}"
    # Must have frontmatter to be a receipt.
    if ! rfm="$(extract_frontmatter "$rfile")"; then
      continue
    fi
    # Only files declaring the processed-receipt type are receipts.
    printf '%s\n' "$rfm" | grep -qE '^type:[[:space:]]*["'"'"']?processed-receipt["'"'"']?' || continue

    RECEIPTS_CHECKED=$((RECEIPTS_CHECKED + 1))

    if ! printf '%s\n' "$rfm" | grep -qE '^routing_decision:[[:space:]]*["'"'"']?\[\['; then
      ERRORS+=("INTAKE RECEIPT INCOMPLETE: $rrel is missing a routing_decision wikilink (contract Part 7.3, processed-receipt schema)")
      FAIL=1
    fi
    if ! printf '%s\n' "$rfm" | grep -qE '^destination:'; then
      ERRORS+=("INTAKE RECEIPT INCOMPLETE: $rrel is missing a destination block (contract Part 7.3, processed-receipt schema)")
      FAIL=1
    fi
  done < <(find "$pdir" -name '*.md' -not -path '*/.git/*' -print0)
done

echo "Checking for em dashes and en dashes..."
if command -v rg >/dev/null 2>&1; then
  if rg -n --pcre2 '[\x{2014}\x{2013}]' "$REPO_ROOT" \
      -g '*.md' \
      -g '!sessions/**' \
      -g '!swarms/**' \
      -g '!_system/**' \
      -g '!docs/**' \
      -g '!.codex/**' \
      -g '!.claude/**' \
      -g '!**/archive/**' \
      -g '!**/support/**' \
      -g '!**/waves/surfaces/dist/**'; then
    ERRORS+=("EM/EN DASH FOUND: see rg output above")
    FAIL=1
  fi
else
  if grep -rP --include="*.md" \
      --exclude-dir=".git" \
      --exclude-dir=".obsidian" \
      --exclude-dir=".codex" \
      --exclude-dir=".claude" \
      --exclude-dir="_system" \
      --exclude-dir="sessions" \
      --exclude-dir="swarms" \
      --exclude-dir="docs" \
      --exclude-dir="archive" \
      --exclude-dir="support" \
      "\xE2\x80\x94|\xE2\x80\x93" "$REPO_ROOT" 2>/dev/null | grep -v "^Binary"; then
    ERRORS+=("EM/EN DASH FOUND: see grep output above")
    FAIL=1
  fi
fi

# ---------------------------------------------------------------------------
# Warn-only shared checks (enforcement-tiers sprint, 2026-06-10). Codex parity:
# Codex does not run the Claude Code hooks, so the validator runs the same
# shared scripts from _system/checks/ here. Output is prefixed as warn-only and
# NEVER affects the exit code. Promotion to blocking is an operator decision
# recorded in _system/enforcement-tiers.md.
# ---------------------------------------------------------------------------
echo "Running warn-only shared checks (_system/checks/)..."
for warn_check in adapter-sync-check.sh session-ledger-status.sh; do
  if [[ -f "$REPO_ROOT/_system/checks/$warn_check" ]]; then
    while IFS= read -r warn_line; do
      [[ -n "$warn_line" ]] || continue
      echo "  WARN-ONLY [$warn_check]: $warn_line"
    done < <(bash "$REPO_ROOT/_system/checks/$warn_check" 2>&1 || true)
  fi
done

echo
echo "Checked $CHECKED node files."

if [[ ${#WARNINGS[@]} -gt 0 ]]; then
  echo
  echo "WARNINGS:"
  printf '  %s\n' "${WARNINGS[@]}"
fi

if [[ $FAIL -ne 0 ]]; then
  echo
  echo "FAILURES:"
  printf '  %s\n' "${ERRORS[@]}"
  echo
  echo "Validation failed with ${#ERRORS[@]} error(s)."
  exit 1
fi

echo
echo "All checks passed."
