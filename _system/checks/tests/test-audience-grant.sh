#!/usr/bin/env bash
# Planted-defect tests for the content digest and the audience grant record.
#
# Every case here is a mistake somebody would actually make, not an impossible input. The digest
# cases matter most: a version that changed when it should not have would make every grant stale and
# the check would be turned off within a day, and a version that did not change when it should have
# is the silent failure the whole design exists to prevent.
#
# Usage: bash _system/checks/tests/test-audience-grant.sh
# Exit 0 when every case behaves, 1 otherwise. Works in a scratch directory; the repo is not touched.
#
# CAP03 / B01.
set -uo pipefail

TESTS_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
CHECKS="$TESTS_DIR/.."
DIGEST="$CHECKS/node-digest.sh"
GRANT="$CHECKS/audience-grant-check.sh"

PASS=0; FAIL=0; ELIGIBLE=0
ok()  { PASS=$((PASS+1)); printf 'PASS  %s\n' "$1"; }
bad() { FAIL=$((FAIL+1)); printf 'FAIL  %s\n      %s\n' "$1" "$2"; }

SCRATCH=$(mktemp -d 2>/dev/null || mktemp -d -t grantcheck)
trap 'rm -rf "$SCRATCH"' EXIT

digest_of() { bash "$DIGEST" "$1" 2>/dev/null | awk '{print $1}'; }

node() {
  # node <file> <export_class> <body> [grant block]
  local file="$1" cls="$2" body="$3" grant="${4:-}"
  mkdir -p "$(dirname "$file")"
  {
    printf -- '---\n'
    printf 'id: "test-node"\n'
    printf 'type: "Concept"\n'
    printf 'namespace: "fixture"\n'
    printf 'lifecycle_state: "research"\n'
    printf 'summary: "A fixture node."\n'
    printf 'confidence: 0.8\n'
    printf 'retrieval_class: "domain"\n'
    printf 'export_class: "%s"\n' "$cls"
    [ -n "$grant" ] && printf '%s\n' "$grant"
    printf 'created: "2026-09-06"\n'
    printf -- '---\n\n'
    printf '%s\n' "$body"
  } > "$file"
}

# ---------------------------------------------------------------------------
# Digest properties.
# ---------------------------------------------------------------------------
A="$SCRATCH/a.md"; B="$SCRATCH/b.md"
node "$A" "internal" "The body."
cp "$A" "$B"

ELIGIBLE=$((ELIGIBLE+1))
[ "$(digest_of "$A")" = "$(digest_of "$B")" ] \
  && ok "digest-is-stable-for-identical-content" \
  || bad "digest-is-stable-for-identical-content" "two identical files digested differently"

ELIGIBLE=$((ELIGIBLE+1))
python3 - "$B" <<'PY'
import sys
p = sys.argv[1]
lines = open(p).read().split("\n")
# Reorder two frontmatter keys and add trailing whitespace: neither is an edit to the definition.
i, j = lines.index('type: "Concept"'), lines.index('namespace: "fixture"')
lines[i], lines[j] = lines[j], lines[i]
open(p, "w").write("\n".join(l + "   " if l.startswith("summary") else l for l in lines))
PY
[ "$(digest_of "$A")" = "$(digest_of "$B")" ] \
  && ok "digest-ignores-key-order-and-trailing-whitespace" \
  || bad "digest-ignores-key-order-and-trailing-whitespace" "a reorder or a stripped space changed the version"

ELIGIBLE=$((ELIGIBLE+1))
python3 - "$B" <<'PY'
import sys
p = sys.argv[1]
# Read fully before opening for write. open(p, "wb") truncates as soon as it is evaluated, and
# Python evaluates it before the argument, so the one-liner form silently produced an empty file.
data = open(p, "rb").read()
open(p, "wb").write(data.replace(b"\n", b"\r\n"))
PY
[ "$(digest_of "$A")" = "$(digest_of "$B")" ] \
  && ok "digest-ignores-line-endings" \
  || bad "digest-ignores-line-endings" "a CRLF checkout produced a different version from an LF one"

ELIGIBLE=$((ELIGIBLE+1))
node "$B" "internal" "The body, with one word changed."
[ "$(digest_of "$A")" != "$(digest_of "$B")" ] \
  && ok "digest-changes-on-a-body-edit" \
  || bad "digest-changes-on-a-body-edit" "the version survived a content change, which is the failure this exists to prevent"

ELIGIBLE=$((ELIGIBLE+1))
node "$B" "internal" "The body."
node "$SCRATCH/c.md" "public" "The body."
[ "$(digest_of "$B")" != "$(digest_of "$SCRATCH/c.md")" ] \
  && ok "digest-changes-on-a-marker-edit" \
  || bad "digest-changes-on-a-marker-edit" "changing export_class did not change the version"

ELIGIBLE=$((ELIGIBLE+1))
printf 'no frontmatter here\n' > "$SCRATCH/d.md"
if bash "$DIGEST" "$SCRATCH/d.md" >/dev/null 2>&1; then
  bad "digest-refuses-a-node-with-no-frontmatter" "it emitted a version for an unparseable file"
else
  ok "digest-refuses-a-node-with-no-frontmatter"
fi

# ---------------------------------------------------------------------------
# Grant record cases. Each runs the real check over a scratch root holding one node.
# ---------------------------------------------------------------------------
case_root() { rm -rf "$SCRATCH/root"; mkdir -p "$SCRATCH/root"; printf '%s' "$SCRATCH/root"; }
run_grant() { bash "$GRANT" "$1" 2>&1; }

R=$(case_root); N="$R/node.md"
node "$N" "public" "Published copy."
BEFORE_GRANT=$(bash "$DIGEST" --exclude audience_grant "$N" | awk '{print $1}')
node "$N" "public" "Published copy." 'audience_grant:
  granted_by: "operator"
  granted_on: "2026-09-06"
  from_class: "internal"
  to_class: "public"'
AFTER_GRANT=$(bash "$DIGEST" --exclude audience_grant "$N" | awk '{print $1}')
node "$N" "public" "Published copy, one word changed." 'audience_grant:
  granted_by: "operator"
  granted_on: "2026-09-07"
  from_class: "internal"
  to_class: "public"'
AFTER_EDIT=$(bash "$DIGEST" --exclude audience_grant "$N" | awk '{print $1}')

ELIGIBLE=$((ELIGIBLE+1))
if [ "$BEFORE_GRANT" = "$AFTER_GRANT" ] && [ "$AFTER_EDIT" != "$AFTER_GRANT" ]; then
  ok "digest-excludes-the-grant-block (writing or re-dating a grant does not change the version; editing what it approved does)"
else
  bad "digest-excludes-the-grant-block" "before=$BEFORE_GRANT after_grant=$AFTER_GRANT after_edit=$AFTER_EDIT"
fi

# Pinning is one pass, not a search for a fixed point, because the digest excludes the grant block.
pin_grant() {
  local file="$1" want now
  want=$(bash "$DIGEST" --exclude audience_grant "$file" | awk '{print $1}')
  [ -n "$want" ] || return 1
  python3 - "$file" "$want" <<'PY'
import re, sys
p, d = sys.argv[1], sys.argv[2]
s = open(p).read()
if "content_digest:" in s:
    s = re.sub(r'  content_digest: ".*"', '  content_digest: "sha256:%s"' % d, s)
else:
    s = s.replace('  to_class:', '  content_digest: "sha256:%s"\n  to_class:' % d, 1)
open(p, "w").write(s)
PY
  now=$(bash "$DIGEST" --exclude audience_grant "$file" | awk '{print $1}')
  [ "$now" = "$want" ] || return 1
  grep -q "sha256:$want" "$file"
}

R=$(case_root); N="$R/node.md"
node "$N" "public" "Published copy." 'audience_grant:
  granted_by: "operator"
  granted_on: "2026-09-06"
  from_class: "internal"
  to_class: "public"'
ELIGIBLE=$((ELIGIBLE+1))
if pin_grant "$N"; then
  OUT=$(run_grant "$R"); RC=$?
  if printf '%s' "$OUT" | grep -q '^VALID' && [ "$RC" -eq 0 ]; then
    ok "a-correctly-pinned-grant-is-valid (one pass, and writing the pin does not change the digest)"
  else
    bad "a-correctly-pinned-grant-is-valid" "exit $RC, output: $(printf '%s' "$OUT" | head -3 | tr '\n' ' ')"
  fi
else
  bad "a-correctly-pinned-grant-is-valid" "pinning changed the digest it was pinning"
fi

ELIGIBLE=$((ELIGIBLE+1))
printf 'One sentence added after the approval.\n' >> "$N"
OUT=$(run_grant "$R"); RC=$?
if printf '%s' "$OUT" | grep -q '^STALE' && [ "$RC" -eq 1 ]; then
  ok "an-edit-after-the-grant-makes-it-stale (the widening stops being covered by the approval)"
else
  bad "an-edit-after-the-grant-makes-it-stale" "exit $RC, expected STALE"
fi

R=$(case_root); N="$R/node.md"
node "$N" "department" "Scoped copy." 'audience_grant:
  granted_by: "operator"
  granted_on: "2026-09-06"
  from_class: "internal"
  to_class: "public"'
ELIGIBLE=$((ELIGIBLE+1))
OUT=$(run_grant "$R"); RC=$?
if printf '%s' "$OUT" | grep -q '^MISMATCH' && [ "$RC" -eq 1 ]; then
  ok "a-grant-for-a-different-class-is-a-mismatch (approved for public, node is department)"
else
  bad "a-grant-for-a-different-class-is-a-mismatch" "exit $RC, expected MISMATCH"
fi

R=$(case_root); N="$R/node.md"
node "$N" "public" "Published copy." 'audience_grant:
  granted_on: "2026-09-06"
  from_class: "internal"
  to_class: "public"'
ELIGIBLE=$((ELIGIBLE+1))
OUT=$(run_grant "$R"); RC=$?
if printf '%s' "$OUT" | grep -q '^INVALID.*granted_by' && [ "$RC" -eq 1 ]; then
  ok "a-grant-with-no-granter-is-invalid (an approval nobody made is not an approval)"
else
  bad "a-grant-with-no-granter-is-invalid" "exit $RC, expected INVALID naming granted_by"
fi

R=$(case_root); N="$R/node.md"
node "$N" "internal" "Body." 'audience_grant:
  granted_by: "operator"
  granted_on: "2026-09-06"
  from_class: "internal"
  to_class: "private"'
ELIGIBLE=$((ELIGIBLE+1))
OUT=$(run_grant "$R"); RC=$?
if printf '%s' "$OUT" | grep -q '^INVALID.*to_class=private' && [ "$RC" -eq 1 ]; then
  ok "a-grant-into-private-is-refused (private is a stop, so it can be granted from and never to)"
else
  bad "a-grant-into-private-is-refused" "exit $RC, expected INVALID naming to_class=private"
fi

R=$(case_root); N="$R/node.md"
node "$N" "public" "Body." 'audience_grant:
  granted_by: "operator"
  granted_on: "2026-09-06"
  from_class: "internal"
  to_class: "public"'
ELIGIBLE=$((ELIGIBLE+1))
OUT=$(run_grant "$R"); RC=$?
if printf '%s' "$OUT" | grep -q '^UNPINNED' && [ "$RC" -eq 0 ]; then
  ok "an-unpinned-grant-is-a-finding-not-a-failure (it is well formed, it just does not say what was approved)"
else
  bad "an-unpinned-grant-is-a-finding-not-a-failure" "exit $RC, expected UNPINNED and exit 0"
fi

R=$(case_root)
node "$R/node.md" "public" "Body."
ELIGIBLE=$((ELIGIBLE+1))
OUT=$(run_grant "$R"); RC=$?
if printf '%s' "$OUT" | grep -q '^NO-GRANT' && [ "$RC" -eq 0 ]; then
  ok "a-widening-with-no-grant-at-all-is-reported"
else
  bad "a-widening-with-no-grant-at-all-is-reported" "exit $RC, expected NO-GRANT"
fi

printf '\n'
printf 'receipt_kind\taudience-grant-tests\n'
printf 'packet\tB01\n'
printf 'eligible\t%s\n' "$ELIGIBLE"
printf 'passed\t%s\n' "$PASS"
printf 'failed\t%s\n' "$FAIL"
[ "$FAIL" -gt 0 ] && { printf 'verdict\tFAIL\n'; exit 1; }
printf 'verdict\tPASS\n'
exit 0
