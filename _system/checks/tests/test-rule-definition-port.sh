#!/usr/bin/env bash
# Planted-defect tests for the RuleDefinitionPort.
#
# The port exists so a rule engine can bind an approval to an exact definition. The two properties
# that matter are therefore: an edit must change the version (or an approval outlives the thing it
# approved), and the port must never write to the brain (or the read-only guarantee is a comment).
# Both are asserted here against a fixture brain, not against the shipped one.
#
# Usage: bash _system/checks/tests/test-rule-definition-port.sh
#
# CAP03 / B01.
set -uo pipefail

TESTS_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
CHECKS="$TESTS_DIR/.."

PASS=0; FAIL=0; ELIGIBLE=0
ok()  { PASS=$((PASS+1)); printf 'PASS  %s\n' "$1"; }
bad() { FAIL=$((FAIL+1)); printf 'FAIL  %s\n      %s\n' "$1" "$2"; }

SCRATCH=$(mktemp -d 2>/dev/null || mktemp -d -t ruleport)
trap 'rm -rf "$SCRATCH"' EXIT

BRAIN="$SCRATCH/brain"
mkdir -p "$BRAIN/_system/checks" "$BRAIN/entities/rules"
cp "$CHECKS/rule-definition-port.sh" "$CHECKS/node-digest.sh" "$BRAIN/_system/checks/"
PORT="$BRAIN/_system/checks/rule-definition-port.sh"

rule() {
  # rule <slug> <lifecycle> <export_class> <body> [extra frontmatter line]
  local slug="$1" life="$2" cls="$3" body="$4" extra="${5:-}"
  {
    printf -- '---\n'
    printf 'id: "rule-%s"\n' "$slug"
    printf 'aliases: ["rule-%s"]\n' "$slug"
    printf 'type: "Rule"\n'
    printf 'namespace: "fixture"\n'
    printf 'lifecycle_state: "%s"\n' "$life"
    printf 'summary: "A fixture rule."\n'
    printf 'confidence: 0.8\n'
    printf 'retrieval_class: "domain"\n'
    printf 'export_class: "%s"\n' "$cls"
    [ -n "$extra" ] && printf '%s\n' "$extra"
    printf 'edges:\n  - target: "[[rule-other]]"\n    relation: "depends_on"\n'
    printf 'created: "2026-09-06"\n'
    printf -- '---\n\n'
    printf '%s\n' "$body"
  } > "$BRAIN/entities/rules/$slug.md"
}

rule "alpha"   "research" "internal" "Alpha does a thing."
rule "beta"    "canon"    "internal" "Beta is settled."
rule "gamma"   "scratch"  "private"  "Gamma is half an idea."

tree_digest() { ( cd "$BRAIN/entities/rules" && cat *.md | sha256sum | cut -d' ' -f1 ); }
BEFORE_TREE=$(tree_digest)

# ---------------------------------------------------------------------------
ELIGIBLE=$((ELIGIBLE+1))
LIST=$(bash "$PORT" list 2>/dev/null)
BOUND=$(printf '%s\n' "$LIST" | tail -n +2 | wc -l)
HAS_SCRATCH=$(printf '%s\n' "$LIST" | grep -c 'rule-gamma')
if [ "$BOUND" -eq 2 ] && [ "$HAS_SCRATCH" -eq 0 ]; then
  ok "gate-binds-research-and-above (2 of 3 bound, the scratch rule excluded)"
else
  bad "gate-binds-research-and-above" "bound=$BOUND scratch_present=$HAS_SCRATCH"
fi

ELIGIBLE=$((ELIGIBLE+1))
LOW=$(bash "$PORT" list --threshold scratch 2>/dev/null | tail -n +2 | wc -l)
if [ "$LOW" -eq 3 ]; then
  ok "threshold-is-configuration-not-a-constant (all 3 bind at threshold scratch)"
else
  bad "threshold-is-configuration-not-a-constant" "expected 3 at threshold scratch, got $LOW"
fi

# ---------------------------------------------------------------------------
ELIGIBLE=$((ELIGIBLE+1))
V1=$(bash "$PORT" version rule-alpha 2>/dev/null)
S1=$(bash "$PORT" set-version 2>/dev/null | awk '{print $1}')
rule "alpha" "research" "internal" "Alpha does a thing, described differently."
V2=$(bash "$PORT" version rule-alpha 2>/dev/null)
S2=$(bash "$PORT" set-version 2>/dev/null | awk '{print $1}')
if [ -n "$V1" ] && [ "$V1" != "$V2" ] && [ "$S1" != "$S2" ]; then
  ok "an-edit-changes-the-rule-version-and-the-set-version (the binding an approval holds is broken by the edit)"
else
  bad "an-edit-changes-the-rule-version-and-the-set-version" "v1=$V1 v2=$V2 s1=$S1 s2=$S2"
fi

ELIGIBLE=$((ELIGIBLE+1))
S_BEFORE=$(bash "$PORT" set-version 2>/dev/null | awk '{print $1}')
rule "delta" "research" "internal" "A rule that did not exist a moment ago."
S_AFTER=$(bash "$PORT" set-version 2>/dev/null | awk '{print $1}')
COUNT_AFTER=$(bash "$PORT" set-version 2>/dev/null | grep -o '([0-9]* rule' | grep -o '[0-9]*')
rm -f "$BRAIN/entities/rules/delta.md"
if [ "$S_BEFORE" != "$S_AFTER" ] && [ "$COUNT_AFTER" -eq 3 ]; then
  ok "membership-changes-the-set-version (adding a rule changes what an evaluation was evaluated against)"
else
  bad "membership-changes-the-set-version" "before=$S_BEFORE after=$S_AFTER count=$COUNT_AFTER"
fi

# ---------------------------------------------------------------------------
ELIGIBLE=$((ELIGIBLE+1))
DEFAULTED=$(bash "$PORT" get rule-alpha 2>/dev/null | tail -1 | cut -f5)
if [ "$DEFAULTED" = "unknown" ]; then
  ok "authority-defaults-to-unknown (an unset field is blocking, never permissive)"
else
  bad "authority-defaults-to-unknown" "expected unknown, got '$DEFAULTED'"
fi

ELIGIBLE=$((ELIGIBLE+1))
rule "epsilon" "research" "internal" "Body." 'authority_required: "sudo"'
TYPO=$(bash "$PORT" get rule-epsilon 2>/dev/null | tail -1 | cut -f5)
WARNED=$(bash "$PORT" get rule-epsilon 2>&1 >/dev/null | grep -c 'read as unknown')
rule "epsilon" "research" "internal" "Body." 'authority_required: "none"'
VALID=$(bash "$PORT" get rule-epsilon 2>/dev/null | tail -1 | cut -f5)
rm -f "$BRAIN/entities/rules/epsilon.md"
if [ "$TYPO" = "unknown" ] && [ "$WARNED" -eq 1 ] && [ "$VALID" = "none" ]; then
  ok "an-unrecognised-authority-value-reads-as-unknown-and-is-reported (a typo must not become a permission)"
else
  bad "an-unrecognised-authority-value-reads-as-unknown-and-is-reported" "typo=$TYPO warned=$WARNED valid=$VALID"
fi

# ---------------------------------------------------------------------------
ELIGIBLE=$((ELIGIBLE+1))
if bash "$PORT" get rule-does-not-exist >/dev/null 2>&1; then
  bad "an-unknown-rule-id-fails" "the port answered for a rule that does not exist"
else
  ok "an-unknown-rule-id-fails (exit 1, no empty projection that reads as an answer)"
fi

ELIGIBLE=$((ELIGIBLE+1))
AUD=$(bash "$PORT" list --threshold scratch 2>/dev/null | grep 'rule-gamma' | cut -f4)
if [ "$AUD" = "private" ]; then
  ok "audience-is-projected-from-export_class (the consumer is told what it is holding)"
else
  bad "audience-is-projected-from-export_class" "expected private for the scratch rule, got '$AUD'"
fi

# ---------------------------------------------------------------------------
# The read-only guarantee. Everything above ran; the rules the test itself rewrote are accounted for
# by re-writing alpha to its post-edit content and comparing against a digest taken after that edit.
ELIGIBLE=$((ELIGIBLE+1))
AFTER_ALL=$(tree_digest)
bash "$PORT" list >/dev/null 2>&1
bash "$PORT" set-version >/dev/null 2>&1
bash "$PORT" get rule-beta >/dev/null 2>&1
bash "$PORT" version rule-beta >/dev/null 2>&1
AFTER_CALLS=$(tree_digest)
if [ "$AFTER_ALL" = "$AFTER_CALLS" ] && [ "$BEFORE_TREE" != "$AFTER_ALL" ]; then
  ok "the-port-never-writes (four calls leave the rules byte-identical; the control shows the digest does move when the test edits)"
else
  bad "the-port-never-writes" "before_test=$BEFORE_TREE after_edits=$AFTER_ALL after_calls=$AFTER_CALLS"
fi

printf '\n'
printf 'receipt_kind\trule-definition-port-tests\n'
printf 'packet\tB01\n'
printf 'eligible\t%s\n' "$ELIGIBLE"
printf 'passed\t%s\n' "$PASS"
printf 'failed\t%s\n' "$FAIL"
[ "$FAIL" -gt 0 ] && { printf 'verdict\tFAIL\n'; exit 1; }
printf 'verdict\tPASS\n'
exit 0
