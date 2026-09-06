#!/usr/bin/env bash
# The audience grant as a record that can be wrong, rather than a rule in prose.
#
# The schema says an audience widening is never implied: it is recorded on the node as an explicit
# grant. Until now the export check read only whether the key was PRESENT, which makes a grant a
# password rather than a record. Anyone could widen a node by typing the key.
#
# A grant states four things and, if it is to mean anything a week later, a fifth:
#
#   audience_grant:
#     granted_by:     who approved the widening
#     granted_on:     when
#     from_class:     what it was
#     to_class:       what it became; must match the node's export_class today
#     content_digest: sha256 of the node as approved, EXCLUDING this grant block itself,
#                     because a record cannot contain a hash of itself   <- the one that expires
#
# The digest is what makes a grant refutable. Without it "approved" means "approved once, for
# whatever this file said at the time", and the node can be rewritten under a standing approval with
# nothing to notice. With it, an edit after the grant is a STALE grant and the widening is no longer
# covered. That is the same property a rule approval needs, and it uses the same primitive:
# _system/checks/node-digest.sh.
#
# Enforcement: STRICT, and it can afford to be. The shipped tree carries zero grants, so there is no
# inherited debt to grandfather. A malformed grant can only exist because someone wrote one.
#
#   bash _system/checks/audience-grant-check.sh [root]
#
# Exit 0 when every grant is well formed. Exit 1 when any grant is invalid, mismatched or stale.
#
# CAP03 / B01.
set -uo pipefail

CHECKS_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
DEFAULT_ROOT=$(cd "$CHECKS_DIR/../.." && pwd)
ROOT="${1:-$DEFAULT_ROOT}"
DIGEST="$CHECKS_DIR/node-digest.sh"

total=0; valid=0; unpinned=0; invalid=0; stale=0; mismatched=0; needed=0; missing=0

printf 'receipt_kind\taudience-grants\n'
printf 'packet\tB01\n'
printf 'root\t%s\n' "$ROOT"
printf 'mutations\tnone; read-only\n\n'

# One pass to find the nodes that carry a grant and the nodes that need one, so the check reports
# both halves: a malformed grant, and a widening with no grant at all.
while IFS= read -r file; do
  [ -z "$file" ] && continue
  fm=$(awk 'NR==1 && $0!="---" {exit} NR==1 {next} /^---$/ {exit} {print}' "$file")
  cls=$(printf '%s\n' "$fm" | sed -n 's/^export_class:[[:space:]]*//p' | head -1 | sed 's/[[:space:]]*#.*$//' | tr -d '"'"'" | tr -d '[:space:]')
  has_grant=$(printf '%s\n' "$fm" | grep -c '^audience_grant:')
  rel="${file#$ROOT/}"

  if [ "$has_grant" -eq 0 ]; then
    case "$cls" in
      public|department)
        needed=$((needed+1)); missing=$((missing+1))
        printf 'NO-GRANT\t%s\t%s with no audience_grant recorded\n' "$rel" "$cls" ;;
    esac
    continue
  fi

  total=$((total+1))
  [ "$cls" = "public" ] || [ "$cls" = "department" ] && needed=$((needed+1))

  gb=$(printf '%s\n' "$fm" | sed -n 's/^  granted_by:[[:space:]]*//p' | head -1 | tr -d '"'"'")
  go=$(printf '%s\n' "$fm" | sed -n 's/^  granted_on:[[:space:]]*//p' | head -1 | tr -d '"'"'")
  fc=$(printf '%s\n' "$fm" | sed -n 's/^  from_class:[[:space:]]*//p' | head -1 | tr -d '"'"'")
  tc=$(printf '%s\n' "$fm" | sed -n 's/^  to_class:[[:space:]]*//p' | head -1 | tr -d '"'"'")
  cd=$(printf '%s\n' "$fm" | sed -n 's/^  content_digest:[[:space:]]*//p' | head -1 | tr -d '"'"'" | sed 's/^sha256://')

  bad=""
  [ -z "$gb" ] && bad="$bad granted_by"
  [ -z "$go" ] && bad="$bad granted_on"
  [ -z "$fc" ] && bad="$bad from_class"
  [ -z "$tc" ] && bad="$bad to_class"
  if [ -n "$bad" ]; then
    invalid=$((invalid+1))
    printf 'INVALID\t%s\tgrant is missing:%s\n' "$rel" "$bad"
    continue
  fi

  case "$fc" in private|internal|department|public) ;; *) bad="$bad from_class=$fc" ;; esac
  # A grant is a widening. private is a stop, so it can be granted FROM and never TO: a record
  # claiming to have granted something into private would be describing an act that does not exist.
  case "$tc" in internal|department|public) ;; *) bad="$bad to_class=$tc" ;; esac
  if [ -n "$bad" ]; then
    invalid=$((invalid+1))
    printf 'INVALID\t%s\tvalue(s) outside the enum:%s\n' "$rel" "$bad"
    continue
  fi

  if [ "$tc" != "$cls" ]; then
    mismatched=$((mismatched+1))
    printf 'MISMATCH\t%s\tgrant records to_class %s but the node is %s today\n' "$rel" "$tc" "$cls"
    continue
  fi

  if [ -z "$cd" ]; then
    unpinned=$((unpinned+1))
    printf 'UNPINNED\t%s\tgrant records no content_digest, so it does not say what was approved\n' "$rel"
    continue
  fi

  # Excluding the grant block is what makes the pin possible at all: see node-digest.sh.
  now=$(bash "$DIGEST" --exclude audience_grant "$file" 2>/dev/null | awk '{print $1}')
  if [ -z "$now" ]; then
    invalid=$((invalid+1))
    printf 'INVALID\t%s\tthe node could not be digested, so its grant cannot be checked\n' "$rel"
  elif [ "$now" != "$cd" ]; then
    stale=$((stale+1))
    printf 'STALE\t%s\tthe node changed after it was granted (granted %s, now %s)\n' "$rel" "${cd:0:12}" "${now:0:12}"
  else
    valid=$((valid+1))
    printf 'VALID\t%s\t%s -> %s, granted by %s on %s\n' "$rel" "$fc" "$tc" "$gb" "$go"
  fi
done < <(grep -rl '^audience_grant:\|^export_class:' "$ROOT" --include='*.md' 2>/dev/null | LC_ALL=C sort)

printf '\ngrants\t%s\n' "$total"
printf 'valid\t%s\n' "$valid"
printf 'unpinned\t%s\n' "$unpinned"
printf 'invalid\t%s\n' "$invalid"
printf 'mismatched\t%s\n' "$mismatched"
printf 'stale\t%s\n' "$stale"
printf 'widenings_without_a_grant\t%s\n' "$missing"

if [ $((invalid + mismatched + stale)) -gt 0 ]; then
  printf 'verdict\tFAIL (%s invalid, %s mismatched, %s stale)\n' "$invalid" "$mismatched" "$stale"
  exit 1
fi
if [ "$unpinned" -gt 0 ] || [ "$missing" -gt 0 ]; then
  printf 'verdict\tCLEAN WITH FINDINGS (%s unpinned grant(s), %s widening(s) with no grant)\n' "$unpinned" "$missing"
  exit 0
fi
printf 'verdict\tCLEAN\n'
exit 0
