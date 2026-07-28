#!/usr/bin/env bash
# tool-three-layer-standard-check.sh
#
# Enforced completeness check for the tool three-layer standard.
# For each root tool pointer (tools/*.md except README and _template), fail when
# the file neither references its expected knowledge/<slug>-tool-contract
# namespace nor declares contract_status: pointer-only. For each
# knowledge/*-tool-contract namespace, fail when no root tool pointer references
# it.
#
# Enforcement posture: ERROR as of 2026-06-17 (tool knowledge-graph completion
# program close). Exits non-zero when any invariant is violated; exits 0 when the
# standard holds. validate.sh treats a non-zero exit as a validation failure.
# Before program close this check was warn-only during the backfill.

set -u

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
TOOLS_DIR="$ROOT/tools"
KNOWLEDGE_DIR="$ROOT/knowledge"

issue_count=0

note() {
  echo "tool-three-layer-standard: $1"
  issue_count=$((issue_count + 1))
}

has_pointer_only_status() {
  local file="$1"
  grep -Eq '^contract_status:[[:space:]]*"?(pointer-only)"?[[:space:]]*$' "$file"
}

tool_references_namespace() {
  local file="$1"
  local namespace_slug="$2"
  grep -Fq "$namespace_slug" "$file"
}

pointer_name_for_namespace() {
  local namespace_slug="$1"
  printf '%s\n' "${namespace_slug%-tool-contract}.md"
}

# Newline-delimited list, not an array: bash 3.2 (stock macOS) has no mapfile,
# and BSD find has no -printf, so the basename is stripped with sed. An empty
# list stays an empty string, which every consumer below handles.
namespace_slugs="$(find "$KNOWLEDGE_DIR" -maxdepth 1 -mindepth 1 -type d -name '*-tool-contract' | sed 's|.*/||' | sort)"

for tool_file in "$TOOLS_DIR"/*.md; do
  [ -e "$tool_file" ] || continue
  base="$(basename "$tool_file")"
  case "$base" in
    README.md|_template.md) continue ;;
  esac
  tool_slug="${base%.md}"
  expected_namespace="${tool_slug}-tool-contract"

  if has_pointer_only_status "$tool_file"; then
    continue
  fi

  if ! printf '%s\n' "$namespace_slugs" | grep -Fxq "$expected_namespace"; then
    note "pointer missing expected graph: tools/$base expects knowledge/$expected_namespace/ but that namespace does not exist and the pointer is not contract_status: pointer-only"
    continue
  fi

  if ! tool_references_namespace "$tool_file" "$expected_namespace"; then
    note "pointer missing expected graph link: tools/$base does not reference knowledge/$expected_namespace/ and is not contract_status: pointer-only"
  fi
done

while IFS= read -r namespace_slug; do
  [ -n "$namespace_slug" ] || continue
  found_pointer=0
  for tool_file in "$TOOLS_DIR"/*.md; do
    [ -e "$tool_file" ] || continue
    base="$(basename "$tool_file")"
    case "$base" in
      README.md|_template.md) continue ;;
    esac
    if tool_references_namespace "$tool_file" "$namespace_slug"; then
      found_pointer=1
      break
    fi
  done

  if [ "$found_pointer" -eq 0 ]; then
    note "namespace missing pointer: knowledge/$namespace_slug/ has no referencing root tool pointer (expected tools/$(pointer_name_for_namespace "$namespace_slug"))"
  fi
done <<< "$namespace_slugs"

if [ "$issue_count" -eq 0 ]; then
  echo "tool-three-layer-standard: all root pointers map to a graph or explicit pointer-only exemption, and every *-tool-contract namespace has a pointer."
  exit 0
fi

echo "tool-three-layer-standard: $issue_count error(s) (enforced as of 2026-06-17, tool-kg program close)."
exit 1
