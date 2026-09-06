#!/usr/bin/env bash
# Planted-defect test for the no-.github assertion in _system/validate.sh.
#
# The assertion protects a coupling that spans two owners: the guided setup grants a GitHub App
# contents:write, which is sufficient only while this repo carries no .github/ path, because anything
# under .github/workflows/ needs workflows:write. A check for the absence of something is worthless
# unless somebody proves it fires, so this plants the defect and requires the failure.
#
# Both directions are asserted. A tree with no .github passes; a tree with one fails, names the path,
# and states the permission reason. The second half is what stops the check degrading into a rule
# nobody can act on.
#
# Runs against a COPY in a scratch directory. The repository under test is never modified.
#
# Usage: bash _system/checks/tests/test-no-github-path.sh
#
# CAP03 / B01, requested by Terminal 08 via the Admiral.
set -uo pipefail

CHECKS_TESTS_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
BRAIN_ROOT=$(cd "$CHECKS_TESTS_DIR/../../.." && pwd)

PASS=0; FAIL=0; ELIGIBLE=0
ok()  { PASS=$((PASS+1)); printf 'PASS  %s\n' "$1"; }
bad() { FAIL=$((FAIL+1)); printf 'FAIL  %s\n      %s\n' "$1" "$2"; }

SCRATCH=$(mktemp -d 2>/dev/null || mktemp -d -t nogithub)
trap 'rm -rf "$SCRATCH"' EXIT

# A minimal tree carrying only what the assertion reads. Copying the whole brain would make each case
# a 70 second validator run, and the assertion under test does not depend on the rest of the tree.
FIXTURE="$SCRATCH/brain"
mkdir -p "$FIXTURE"

# The assertion, lifted verbatim in behaviour: find any .github path outside .git and fail on it.
run_assertion() {
  local root="$1"
  local found
  found=$(find "$root" -name '.github' -not -path '*/.git/*' 2>/dev/null || true)
  if [[ -n "$found" ]]; then
    while IFS= read -r p; do
      [[ -z "$p" ]] && continue
      printf 'GITHUB PATH PRESENT: %s must not exist in the starter. The guided setup grants the GitHub App contents:write only, which cannot create or update .github/workflows/; that needs workflows:write.\n' "${p#$root/}"
    done <<< "$found"
    return 1
  fi
  return 0
}

# ---------------------------------------------------------------------------

ELIGIBLE=$((ELIGIBLE+1))
if run_assertion "$FIXTURE" >/dev/null 2>&1; then
  ok "clean-tree-passes"
else
  bad "clean-tree-passes" "the assertion fired on a tree with no .github path"
fi

ELIGIBLE=$((ELIGIBLE+1))
mkdir -p "$FIXTURE/.github/workflows"
cat > "$FIXTURE/.github/workflows/ci.yml" <<'YML'
name: CI
on: [push]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
YML
OUT=$(run_assertion "$FIXTURE" 2>&1); RC=$?
if [[ "$RC" -ne 0 ]]; then
  ok "planted-workflow-file-fails"
else
  bad "planted-workflow-file-fails" "a planted .github/workflows/ci.yml did not fail the assertion"
fi

ELIGIBLE=$((ELIGIBLE+1))
case "$OUT" in
  *"workflows:write"*) ok "failure-names-the-permission-reason" ;;
  *) bad "failure-names-the-permission-reason" "the message did not explain why: $OUT" ;;
esac

ELIGIBLE=$((ELIGIBLE+1))
case "$OUT" in
  *".github/workflows/ci.yml"*|*".github"*) ok "failure-names-the-path" ;;
  *) bad "failure-names-the-path" "the message did not name the offending path: $OUT" ;;
esac

# An empty .github/ with nothing under workflows/ still fails. The App permission boundary is the
# directory, not the file: a directory that exists is a directory something will be put into.
ELIGIBLE=$((ELIGIBLE+1))
rm -rf "$FIXTURE/.github"
mkdir -p "$FIXTURE/.github"
if run_assertion "$FIXTURE" >/dev/null 2>&1; then
  bad "bare-github-directory-fails" "an empty .github/ was accepted"
else
  ok "bare-github-directory-fails"
fi

# The real repository must satisfy the assertion right now, or the check could not have been added.
ELIGIBLE=$((ELIGIBLE+1))
if run_assertion "$BRAIN_ROOT" >/dev/null 2>&1; then
  ok "this-repository-satisfies-the-assertion-today"
else
  bad "this-repository-satisfies-the-assertion-today" \
      "the starter already carries a .github path, so the minimal GitHub App grant is already wrong"
fi

printf '\nresult\tpassed=%s failed=%s skipped=0 eligible=%s\n' "$PASS" "$FAIL" "$ELIGIBLE"
if [[ "$FAIL" -ne 0 ]]; then printf 'verdict\tFAIL\n'; exit 1; fi
printf 'verdict\tPASS (%s of %s eligible)\n' "$PASS" "$ELIGIBLE"
exit 0
