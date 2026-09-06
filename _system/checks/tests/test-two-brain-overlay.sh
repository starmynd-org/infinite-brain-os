#!/usr/bin/env bash
# B01 acceptance evidence: one base, two brains, and what actually crosses between them.
#
# The packet's acceptance sentence is "a fresh private Brain and a clean company Brain can consume
# the same base without private transcript leakage". Until now that sentence had no demonstration
# behind it, and the three words that make it hard are "the same base": if each brain gets its own
# copy that drifts, the shared base is a story rather than a fact, and nothing detects the drift.
#
# So this builds both brains from one base in a scratch directory, runs the SHIPPED
# _system/checks/audience-export-check.sh unmodified against each, and asserts the properties one at
# a time. Every private node is planted by name, so an assertion that the private set stayed home is
# checked against a list rather than against a count that could be zero for the wrong reason.
#
# WHAT THIS PROVES. Given what the nodes declare, the base is byte-identical in both brains, no
# private node enters any export set, a widening without a recorded grant is reported, an unmarked
# node is held, and the promoted node keeps a resolvable line back to its private source.
#
# WHAT THIS DOES NOT PROVE, stated here because the sentence above is easy to over-read. It is a
# computation over declared markers. It does not read prose, so a private sentence pasted into a node
# marked `internal` is exported and this test says nothing about it. The export pipeline's real
# control is the ship list in tools/brain-export, and the checker of last resort is the independent
# sweep in the release checklist, never this file.
#
# The last section demonstrates the limitation that matters most: re-marking a node `private` does
# not retract the copy already in the shared brain's git history. That is asserted against a real git
# fixture rather than described, because it is the failure most likely to be assumed away.
#
# Usage: bash _system/checks/tests/test-two-brain-overlay.sh
# Exit 0 when every assertion holds. Exit 1 on any failure. Modifies nothing outside its scratch dir.
#
# CAP03 / B01, Terminal 10.
set -uo pipefail

TESTS_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
BRAIN_ROOT=$(cd "$TESTS_DIR/../../.." && pwd)
EXPORT_CHECK="$BRAIN_ROOT/_system/checks/audience-export-check.sh"

if [ ! -f "$EXPORT_CHECK" ]; then
  printf 'two-brain-overlay: cannot find %s\n' "$EXPORT_CHECK" >&2
  exit 2
fi

PASS=0; FAIL=0; ELIGIBLE=0; DEMOS=0
ok()   { PASS=$((PASS+1)); printf 'PASS  %s\n' "$1"; }
bad()  { FAIL=$((FAIL+1)); printf 'FAIL  %s\n      %s\n' "$1" "$2"; }
demo() { DEMOS=$((DEMOS+1)); printf 'DEMONSTRATED  %s\n              %s\n' "$1" "$2"; }

SCRATCH=$(mktemp -d 2>/dev/null || mktemp -d -t twobrain)
trap 'rm -rf "$SCRATCH"' EXIT

# ---------------------------------------------------------------------------
# Node writer. Full frontmatter, because a fixture that omits required keys is not a fixture of this
# system. Arguments: file, id, lifecycle, export_class, summary, extra frontmatter lines, body.
# ---------------------------------------------------------------------------
write_node() {
  local file="$1" id="$2" life="$3" cls="$4" summary="$5" extra="$6" body="$7"
  mkdir -p "$(dirname "$file")"
  {
    printf -- '---\n'
    printf 'id: "%s"\n' "$id"
    printf 'aliases: ["%s"]\n' "$id"
    printf 'type: "Concept"\n'
    printf 'namespace: "emberline-studio"\n'
    printf 'lifecycle_state: "%s"\n' "$life"
    printf 'summary: "%s"\n' "$summary"
    printf 'confidence: 0.8\n'
    printf 'retrieval_class: "domain"\n'
    if [ -n "$cls" ]; then printf 'export_class: "%s"\n' "$cls"; fi
    printf 'description: "Fixture node for the B01 two-brain overlay demonstration."\n'
    [ -n "$extra" ] && printf '%s\n' "$extra"
    printf 'created: "2026-09-06"\n'
    printf -- '---\n\n'
    printf '%s\n' "$body"
  } > "$file"
}

# ---------------------------------------------------------------------------
# The base. This is the sanitized, reusable layer: doctrine with no capture in it. Both brains get a
# byte-identical copy, which is the property asserted first.
# ---------------------------------------------------------------------------
BASE="$SCRATCH/base"
write_node "$BASE/knowledge/base/canon-means-approved.md" "base-canon-means-approved" "canon" "internal" \
  "Canon is operator-approved material, not whatever the agent was most recently confident about." "" \
  "A node reaches canon because a person approved it. Confidence is an input to that decision, never a substitute for it."
write_node "$BASE/knowledge/base/promotion-is-two-axes.md" "base-promotion-two-axes" "canon" "internal" \
  "Lifecycle promotion and audience promotion are different acts; only one is about confidence." "" \
  "Moving scratch to canon says how settled the content is. Moving private to internal says who may see it. Conflating them is how a private brain leaks one confident node at a time."
write_node "$BASE/knowledge/base/what-a-brain-is.md" "base-what-a-brain-is" "canon" "public" \
  "A brain is the knowledge your agents read before acting, plus the record of what they did." \
  'audience_grant:
  granted_by: "operator"
  granted_on: "2026-09-06"
  from_class: "internal"
  to_class: "public"' \
  "Published doctrine. It carries a recorded widening because it crossed from internal to public, and a widening without a record is a finding rather than a preference."

BASE_FILES=$(cd "$BASE" && find . -name '*.md' | sort)

# ---------------------------------------------------------------------------
# Brain one: a fresh private brain. Base plus personal capture, including the raw transcript material
# that the acceptance sentence is about.
# ---------------------------------------------------------------------------
PERSONAL="$SCRATCH/personal"
cp -r "$BASE" "$PERSONAL"

PRIVATE_IDS="personal-call-transcript-2026-09-02 personal-doubt-about-the-pivot personal-salary-note"

write_node "$PERSONAL/knowledge/personal/call-transcript-2026-09-02.md" "personal-call-transcript-2026-09-02" "scratch" "private" \
  "Raw transcript capture from the 2026-09-02 studio call." "" \
  "Rosa said she would rather close the wholesale line than carry it another quarter, then took it back ten minutes later. Verbatim capture, not a conclusion."
write_node "$PERSONAL/knowledge/personal/doubt-about-the-pivot.md" "personal-doubt-about-the-pivot" "research" "private" \
  "Private thinking-in-progress about whether the wholesale pivot is a mistake." "" \
  "Written to think, not to publish. The reasoning is half-formed and names a person's position before they have stated it publicly."
write_node "$PERSONAL/knowledge/personal/salary-note.md" "personal-salary-note" "canon" "private" \
  "Settled personal position on compensation. Canon and private at the same time, forever." "" \
  "This node is canon: it is settled and the operator approved it. It is also private and always will be, which is the pair the audience axis has to be able to express."
write_node "$PERSONAL/knowledge/personal/wholesale-margin-reading.md" "personal-wholesale-margin-reading" "research" "internal" \
  "A derived reading about wholesale margin that contains no capture and no third-party position." "" \
  "The wholesale line carries a lower margin than retail at current volumes. Derived from the studio's own figures; no transcript material and nobody's unstated position."
write_node "$PERSONAL/knowledge/personal/unmarked-scratch.md" "personal-unmarked-scratch" "scratch" "" \
  "A node whose author never set export_class, which is what a real first-day node looks like." "" \
  "The author was thinking, not classifying. Nothing about this node says who may see it."

# ---------------------------------------------------------------------------
# Brain two: a clean company brain. Same base, company overlay, and one node promoted out of the
# private brain with its lineage recorded.
# ---------------------------------------------------------------------------
COMPANY="$SCRATCH/company"
cp -r "$BASE" "$COMPANY"

write_node "$COMPANY/knowledge/company/wholesale-margin-position.md" "company-wholesale-margin-position" "research" "internal" \
  "The company's working position on wholesale margin, derived from the operator's private reading." \
  'edges:
  - target: "[[personal-wholesale-margin-reading]]"
    relation: "derived_from"
    confidence: 0.9
audience_grant:
  granted_by: "operator"
  granted_on: "2026-09-06"
  from_class: "private"
  to_class: "internal"' \
  "At current volumes the wholesale line runs below retail margin. Derived from the operator brain node named in the edges, which stays where it was written."
write_node "$COMPANY/knowledge/company/pricing-page-copy.md" "company-pricing-page-copy" "canon" "public" \
  "Copy cleared for the published pricing page." "" \
  "Published surface text. This node is deliberately widened to public with no grant recorded, so the ungranted-widening path is exercised by a real node rather than described."
write_node "$COMPANY/knowledge/company/supplier-terms.md" "company-supplier-terms" "research" "department" \
  "Supplier terms scoped to the operations department." "" \
  "Scoped narrower than internal. It is here so that an audience request wider than the node is shown holding it back."

# ---------------------------------------------------------------------------
# A1. One base, both brains, byte-identical.
# ---------------------------------------------------------------------------
ELIGIBLE=$((ELIGIBLE+1))
base_digest() {
  local root="$1" f
  ( cd "$root" && for f in $BASE_FILES; do printf '%s  ' "$f"; sha256sum "$f" | cut -d' ' -f1; done )
}
D_BASE=$(base_digest "$BASE"); D_PERS=$(base_digest "$PERSONAL"); D_COMP=$(base_digest "$COMPANY")
if [ "$D_BASE" = "$D_PERS" ] && [ "$D_BASE" = "$D_COMP" ]; then
  ok "one-base-consumed-by-both (3 base nodes, identical digests in both brains)"
else
  bad "one-base-consumed-by-both" "the base differs between the two brains; they are not consuming one base"
fi

# ---------------------------------------------------------------------------
# A2. No private node enters any export set of the private brain, at any audience.
# ---------------------------------------------------------------------------
for audience in public department internal; do
  ELIGIBLE=$((ELIGIBLE+1))
  OUT=$(bash "$EXPORT_CHECK" "$audience" "$PERSONAL" 2>&1); RC=$?
  LEAKED=""
  for id in $PRIVATE_IDS; do
    file=$(printf '%s' "$id" | sed 's/^personal-//')
    if printf '%s' "$OUT" | grep -q "^EXPORT.*knowledge/personal/${file}.md"; then
      LEAKED="$LEAKED $id"
    fi
  done
  HELD_PRIVATE=$(printf '%s' "$OUT" | grep -c '^HELD.*	private$')
  if [ -z "$LEAKED" ] && [ "$HELD_PRIVATE" -eq 3 ] && [ "$RC" -eq 0 ]; then
    ok "private-set-held-at-audience-$audience (3 of 3 private nodes held by name, exit $RC)"
  else
    bad "private-set-held-at-audience-$audience" "leaked:${LEAKED:- none} held_private=$HELD_PRIVATE exit=$RC"
  fi
done

# ---------------------------------------------------------------------------
# A3. The planted defect. Flip one private node to internal and require the set to change, so that A2
# is a property of the check rather than of a fixture with nothing to find.
# ---------------------------------------------------------------------------
ELIGIBLE=$((ELIGIBLE+1))
BEFORE=$(bash "$EXPORT_CHECK" internal "$PERSONAL" 2>&1 | sed -n 's/^exported	//p')
sed -i 's/^export_class: "private"$/export_class: "internal"/' "$PERSONAL/knowledge/personal/salary-note.md"
AFTER_OUT=$(bash "$EXPORT_CHECK" internal "$PERSONAL" 2>&1)
AFTER=$(printf '%s' "$AFTER_OUT" | sed -n 's/^exported	//p')
NAMED=$(printf '%s' "$AFTER_OUT" | grep -c '^EXPORT.*salary-note.md')
sed -i 's/^export_class: "internal"$/export_class: "private"/' "$PERSONAL/knowledge/personal/salary-note.md"
RESTORED=$(bash "$EXPORT_CHECK" internal "$PERSONAL" 2>&1 | sed -n 's/^exported	//p')
if [ "$AFTER" -eq $((BEFORE + 1)) ] && [ "$NAMED" -eq 1 ] && [ "$RESTORED" -eq "$BEFORE" ]; then
  ok "planted-widening-is-observed (exported $BEFORE -> $AFTER -> $RESTORED, the node named)"
else
  bad "planted-widening-is-observed" "before=$BEFORE after=$AFTER named=$NAMED restored=$RESTORED"
fi

# ---------------------------------------------------------------------------
# A4. The company brain carries no node from the private set, by id and by marker.
# ---------------------------------------------------------------------------
ELIGIBLE=$((ELIGIBLE+1))
FOUND=""
for id in $PRIVATE_IDS; do
  grep -rql "id: \"$id\"" "$COMPANY" 2>/dev/null && FOUND="$FOUND $id"
done
COMPANY_PRIVATE=$(grep -rl 'export_class: "private"' "$COMPANY" 2>/dev/null | wc -l)
if [ -z "$FOUND" ] && [ "$COMPANY_PRIVATE" -eq 0 ]; then
  ok "company-brain-carries-no-private-node (0 of 3 private ids present, 0 private markers)"
else
  bad "company-brain-carries-no-private-node" "ids present:${FOUND:- none} private markers=$COMPANY_PRIVATE"
fi

# ---------------------------------------------------------------------------
# A5. Lineage. The promoted company node names its private source, the source resolves in the private
# brain, and the source is still private there. Promotion moved a derivation, not the capture.
# ---------------------------------------------------------------------------
ELIGIBLE=$((ELIGIBLE+1))
PROMOTED="$COMPANY/knowledge/company/wholesale-margin-position.md"
SOURCE_ID=$(sed -n 's/.*target: "\[\[\(.*\)\]\]".*/\1/p' "$PROMOTED" | head -1)
SOURCE_FILE=$(grep -rl "id: \"$SOURCE_ID\"" "$PERSONAL" 2>/dev/null | head -1)
GRANT_FROM=$(sed -n 's/^  from_class: "\(.*\)"$/\1/p' "$PROMOTED" | head -1)
if [ -n "$SOURCE_ID" ] && [ -n "$SOURCE_FILE" ] && [ "$GRANT_FROM" = "private" ]; then
  ok "lineage-resolves-to-the-private-brain ($SOURCE_ID found, grant records private -> internal)"
else
  bad "lineage-resolves-to-the-private-brain" "source_id=${SOURCE_ID:-none} resolved=${SOURCE_FILE:-no} grant_from=${GRANT_FROM:-none}"
fi

# ---------------------------------------------------------------------------
# A6. A widening without a recorded grant is reported, and the same shape with a grant is not.
# ---------------------------------------------------------------------------
ELIGIBLE=$((ELIGIBLE+1))
COMP_OUT=$(bash "$EXPORT_CHECK" public "$COMPANY" 2>&1)
UNGRANTED=$(printf '%s' "$COMP_OUT" | grep -c '^EXPORT-UNGRANTED.*pricing-page-copy.md')
GRANTED_OK=$(printf '%s' "$COMP_OUT" | grep -c '^EXPORT	knowledge/base/what-a-brain-is.md')
if [ "$UNGRANTED" -eq 1 ] && [ "$GRANTED_OK" -eq 1 ]; then
  ok "widening-requires-a-recorded-grant (ungranted node reported, granted node clean)"
else
  bad "widening-requires-a-recorded-grant" "ungranted_hits=$UNGRANTED granted_clean=$GRANTED_OK"
fi

# ---------------------------------------------------------------------------
# A7. An unmarked node is held. The default has to point at holding: defaulting an unmarked node into
# an export is how an unreviewed file ships.
# ---------------------------------------------------------------------------
ELIGIBLE=$((ELIGIBLE+1))
PERS_OUT=$(bash "$EXPORT_CHECK" internal "$PERSONAL" 2>&1)
UNMARKED=$(printf '%s' "$PERS_OUT" | grep -c '^HELD.*unmarked-scratch.md.*no export_class')
if [ "$UNMARKED" -eq 1 ]; then
  ok "unmarked-node-is-held (1 unmarked node, held with the reason named)"
else
  bad "unmarked-node-is-held" "expected 1 held-unmarked line, got $UNMARKED"
fi

# ---------------------------------------------------------------------------
# A8. A narrower node is held from a wider audience. department stays inside department.
# ---------------------------------------------------------------------------
ELIGIBLE=$((ELIGIBLE+1))
PUB_HELD=$(bash "$EXPORT_CHECK" public "$COMPANY" 2>&1 | grep -c '^HELD.*supplier-terms.md.*department is narrower')
DEPT_OUT=$(bash "$EXPORT_CHECK" department "$COMPANY" 2>&1 | grep -c '^EXPORT.*supplier-terms.md')
if [ "$PUB_HELD" -eq 1 ] && [ "$DEPT_OUT" -eq 1 ]; then
  ok "narrower-class-held-from-wider-audience (department node held at public, exported at department)"
else
  bad "narrower-class-held-from-wider-audience" "held_at_public=$PUB_HELD exported_at_department=$DEPT_OUT"
fi

# ---------------------------------------------------------------------------
# The limitation, demonstrated rather than described.
#
# Re-marking a node private does not retract the copy already in the shared brain's history. This is
# the single most likely thing for a reader of the schema to assume away, so it is asserted against a
# real git fixture: commit the node as internal, re-mark it private, and then read the original body
# back out of history at HEAD.
# ---------------------------------------------------------------------------
HIST="$SCRATCH/history"
mkdir -p "$HIST"
git -C "$HIST" init -q 2>/dev/null
git -C "$HIST" config user.email "fixture@example.invalid"
git -C "$HIST" config user.name "B01 fixture"
write_node "$HIST/knowledge/company/rosa-position.md" "company-rosa-position" "research" "internal" \
  "A note that was shared before anyone decided it should not have been." "" \
  "Rosa would rather close the wholesale line than carry it another quarter."
git -C "$HIST" add -A >/dev/null 2>&1
git -C "$HIST" commit -q -m "shared as internal" >/dev/null 2>&1
sed -i 's/^export_class: "internal"$/export_class: "private"/' "$HIST/knowledge/company/rosa-position.md"
git -C "$HIST" add -A >/dev/null 2>&1
git -C "$HIST" commit -q -m "re-marked private" >/dev/null 2>&1

ELIGIBLE=$((ELIGIBLE+1))
HEAD_CLS=$(sed -n 's/^export_class: "\(.*\)"$/\1/p' "$HIST/knowledge/company/rosa-position.md")
HELD_NOW=$(bash "$EXPORT_CHECK" internal "$HIST" 2>&1 | grep -c '^HELD.*rosa-position.md	private')
RECOVERABLE=$(git -C "$HIST" log -p --all -- knowledge/company/rosa-position.md 2>/dev/null | grep -c 'rather close the wholesale line')
if [ "$HEAD_CLS" = "private" ] && [ "$HELD_NOW" -eq 1 ] && [ "$RECOVERABLE" -ge 1 ]; then
  demo "re-marking-does-not-retract" "the node is private at HEAD and correctly held, and its original body is still readable from git history. An audience marker governs what leaves next, never what already left."
else
  bad "re-marking-does-not-retract" "head_class=$HEAD_CLS held_now=$HELD_NOW recoverable_from_history=$RECOVERABLE (expected private/1/>=1)"
fi

# ---------------------------------------------------------------------------

printf '\n'
printf 'receipt_kind\ttwo-brain-overlay\n'
printf 'packet\tB01\n'
printf 'brains\tpersonal (fresh private), company (clean), from one base\n'
printf 'base_nodes\t3\n'
printf 'private_nodes_planted\t3\n'
printf 'export_check\t%s\n' "${EXPORT_CHECK#$BRAIN_ROOT/}"
printf 'mutations_outside_scratch\tnone\n'
printf 'eligible\t%s\n' "$ELIGIBLE"
printf 'passed\t%s\n' "$PASS"
printf 'failed\t%s\n' "$FAIL"
printf 'demonstrated_limitations\t%s\n' "$DEMOS"

if [ "$FAIL" -gt 0 ]; then
  printf 'verdict\tFAIL\n'
  exit 1
fi
printf 'verdict\tPASS (marker-level only; content and ship list are not checked here)\n'
exit 0
