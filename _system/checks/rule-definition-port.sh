#!/usr/bin/env bash
# RuleDefinitionPort: the read-only projection of this brain's rules for a rule engine.
#
# Agreed between B01 and the attention packets (T01/T02) and inherited by Terminal 10. The engine
# needs to bind an approval to an exact rule definition; the brain needs to guarantee that rule
# machinery never writes to it. So this is a projection with four calls and no write path at all.
#
#   rule-definition-port.sh list [--threshold <state>] [--json]     ids and versions that bind
#   rule-definition-port.sh get <rule_id> [--json]                  the projection for one rule
#   rule-definition-port.sh version <rule_id>                       just the version, the cheap call
#   rule-definition-port.sh set-version [--threshold <state>]       one version over the bound set
#
# FIELDS, and what each is deliberately not:
#   rule_id            <- id
#   scope              <- namespace
#   state_hint         <- lifecycle_state. A hint: the engine's activation gate is its own.
#   evidence_refs      <- edges, targets only
#   brains_audience    <- export_class
#   version            <- content digest, _system/checks/node-digest.sh
#   authority_required <- enum, default unknown
#   match, proposed_action  ARE NOT HERE. They belong to the engine and are opaque to the brain.
#
# WHY THE VERSION IS A DIGEST. An integer counter makes immutability depend on a person remembering
# to increment it, which is the property that fails silently. A digest cannot be forgotten. An exact
# (rule_id, version) pair is then immutable by construction, and the engine's existing gate, which
# requires approved_hash == definition.version_hash, becomes true or false rather than stale.
#
# WHY BOTH GRANULARITIES. Per rule, because that is the approval binding. Over the set, because that
# is what a triage receipt pins so an evaluation can say what it was evaluated against.
#
# THE GATE. Bind `research` and above; exclude `scratch`. That threshold is configuration rather than
# a constant, and it was corrected once already: binding `canon` and `candidate` was proposed first,
# and measurement killed it. Of the eleven rules shipped here, ten are `research` and one is
# `scratch`, and none is canon or candidate, so that gate would have bound nothing at all while
# looking like a working integration.
#
# AUTHORITY, and the property the independent reviewer is watching. `authority_required` defaults to
# `unknown`, which means "not yet determined, therefore blocked". It must never be read as `none`.
# No rule shipped in this brain carries the field, so today the brain expresses no authority at all
# and a rule cannot widen a permission because it cannot express one. That holds BY CONSTRUCTION, not
# by enforcement, and it becomes conditional the day a rule carries the field. That transition is the
# reviewable moment.
#
# Exit 0 on success, 2 on usage, 1 when a named rule does not exist.
#
# CAP03 / B01.
set -uo pipefail

CHECKS_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
BRAIN_ROOT=$(cd "$CHECKS_DIR/../.." && pwd)
RULES_DIR="$BRAIN_ROOT/entities/rules"

CALL="${1:-}"; shift 2>/dev/null || true
THRESHOLD="research"
FORMAT="tsv"
TARGET=""
while [ "$#" -gt 0 ]; do
  case "$1" in
    --threshold) THRESHOLD="${2:-}"; shift 2 ;;
    --json)      FORMAT="json"; shift ;;
    *)           TARGET="$1"; shift ;;
  esac
done

case "$CALL" in
  list|get|version|set-version) ;;
  *) printf 'usage: rule-definition-port.sh <list|get|version|set-version> [args]\n' >&2; exit 2 ;;
esac
command -v python3 >/dev/null 2>&1 || { printf 'rule-definition-port: python3 is required\n' >&2; exit 2; }

python3 - "$CALL" "$THRESHOLD" "$FORMAT" "$TARGET" "$RULES_DIR" "$CHECKS_DIR/node-digest.sh" <<'PY'
import hashlib, json, os, subprocess, sys

call, threshold, fmt, target, rules_dir, digest_tool = sys.argv[1:7]

ORDER = ["scratch", "research", "candidate", "canon"]
AUTHORITY = ["none", "internal", "external", "financial", "unknown"]

if threshold not in ORDER:
    sys.stderr.write("rule-definition-port: unknown threshold %r; expected one of %s\n" % (threshold, ", ".join(ORDER)))
    sys.exit(2)

def parse(path):
    lines = open(path, "r", encoding="utf-8", errors="replace").read().replace("\r\n", "\n").split("\n")
    if not lines or lines[0] != "---":
        return None
    try:
        end = lines.index("---", 1)
    except ValueError:
        return None
    fm, key = {}, None
    edges = []
    for ln in lines[1:end]:
        if ln[:1] not in (" ", "\t") and ":" in ln:
            key, val = ln.split(":", 1)
            fm[key.strip()] = val.strip().strip('"').strip("'")
        elif key == "edges" and "target:" in ln:
            edges.append(ln.split("target:", 1)[1].strip().strip('"').strip("'").strip("[]"))
    fm["_edges"] = edges
    return fm

files = sorted(os.path.join(rules_dir, f) for f in os.listdir(rules_dir) if f.endswith(".md"))
files = [f for f in files if not os.path.basename(f).startswith("_") and os.path.basename(f) != "README.md"]

# One digest subprocess for the whole set. There is exactly one implementation of the canonical form,
# and it is node-digest.sh: a second implementation here would be a second answer waiting to differ.
digests = {}
if files:
    out = subprocess.run(["bash", digest_tool] + files, capture_output=True, text=True)
    for line in out.stdout.splitlines():
        parts = line.split("  ", 1)
        if len(parts) == 2:
            digests[parts[1]] = parts[0]

rows = []
for path in files:
    fm = parse(path)
    if fm is None:
        sys.stderr.write("rule-definition-port: %s has no frontmatter; it is not projected\n" % path)
        continue
    state = fm.get("lifecycle_state", "scratch")
    if state not in ORDER or ORDER.index(state) < ORDER.index(threshold):
        continue
    authority = fm.get("authority_required", "unknown")
    if authority not in AUTHORITY:
        # An unrecognised value is treated as unknown, never as none. A typo must not become a
        # permission.
        sys.stderr.write("rule-definition-port: %s declares authority_required=%r, read as unknown\n"
                         % (os.path.basename(path), authority))
        authority = "unknown"
    rows.append({
        "rule_id": fm.get("id", ""),
        "scope": fm.get("namespace", ""),
        "state_hint": state,
        "evidence_refs": fm["_edges"],
        "brains_audience": fm.get("export_class", ""),
        "version": digests.get(path, ""),
        "authority_required": authority,
        "source": os.path.relpath(path, os.path.dirname(os.path.dirname(rules_dir))),
    })

def emit(items):
    if fmt == "json":
        print(json.dumps(items, indent=2, sort_keys=True))
        return
    print("rule_id\tscope\tstate_hint\tbrains_audience\tauthority_required\tversion\tevidence_refs")
    for r in items:
        print("\t".join([r["rule_id"], r["scope"], r["state_hint"], r["brains_audience"],
                         r["authority_required"], r["version"], ",".join(r["evidence_refs"])]))

if call == "list":
    emit(rows)
elif call == "get":
    hit = [r for r in rows if r["rule_id"] == target]
    if not hit:
        sys.stderr.write("rule-definition-port: no rule %r binds at threshold %s\n" % (target, threshold))
        sys.exit(1)
    emit(hit)
elif call == "version":
    hit = [r for r in rows if r["rule_id"] == target]
    if not hit:
        sys.stderr.write("rule-definition-port: no rule %r binds at threshold %s\n" % (target, threshold))
        sys.exit(1)
    print(hit[0]["version"])
elif call == "set-version":
    pairs = "".join("%s %s\n" % (r["rule_id"], r["version"]) for r in sorted(rows, key=lambda r: r["rule_id"]))
    print("%s  (%d rule(s) at threshold %s)" % (hashlib.sha256(pairs.encode("utf-8")).hexdigest(), len(rows), threshold))
PY
