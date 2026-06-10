#!/usr/bin/env bash
# canon-obligation-language.sh
#
# Warn-only check: canon describes the system as it runs. This script greps every
# knowledge namespace's canon/ folder for obligation phrases that usually mean
# roadmap or future-spec content has leaked into canon. Findings are warnings for
# curator review, not failures: requirements and gaps belong in synthesis/, per
# knowledge/ai-architecture/synthesis/autonomy-readiness-requirements.md and the
# canon boundary in _system/canon-layer-schema.md.
#
# Always exits 0. Promotion to a blocking check is a later operator decision.

set -u

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"

PHRASES=(
  "still lacks"
  "does not yet"
  "will need"
  "the biggest gap"
  "not yet built"
)

warn_count=0

for canon_dir in "$ROOT"/knowledge/*/canon; do
  [ -d "$canon_dir" ] || continue
  for phrase in "${PHRASES[@]}"; do
    while IFS= read -r hit; do
      [ -n "$hit" ] || continue
      echo "WARN obligation language in canon: $hit"
      warn_count=$((warn_count + 1))
    done < <(grep -rni --include="*.md" "$phrase" "$canon_dir" 2>/dev/null | sed "s|^$ROOT/||")
  done
done

if [ "$warn_count" -eq 0 ]; then
  echo "OK: no obligation language found in any knowledge/*/canon/ folder."
else
  echo "Total warnings: $warn_count (warn-only; roadmap content belongs in synthesis/)."
fi

exit 0
