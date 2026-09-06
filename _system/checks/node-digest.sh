#!/usr/bin/env bash
# The content digest a node is addressed by when something binds to it.
#
# Two different bindings in this system need the same primitive. An audience grant says "this
# content, widened to that class, approved by this person"; a rule approval says "this definition may
# act automatically". Both are made false by an edit, and both were expressed as a version number
# that a human had to remember to increment. That is the failure mode that never announces itself:
# the counter stays at 3, the content changed, and the approval still reads as current.
#
# So the version IS the content. A digest cannot be forgotten.
#
# CANONICAL FORM, and the reasons for each choice:
#   - line endings normalised: a CRLF checkout must not produce a different version from an LF one.
#   - trailing whitespace per line removed, and trailing blank lines at end of file collapsed: an
#     editor stripping whitespace on save is not an edit to the definition.
#   - frontmatter top-level key blocks sorted by key name, each block keeping its own internal order:
#     reordering keys is not a change; reordering the items inside an edges list is.
#   - everything else is significant. A body change, a value change, a key added or removed, all
#     change the digest. That includes lifecycle_state, because an approval that survived a node
#     being promoted from research to canon would be an approval of something else.
#
# Usage:
#   node-digest.sh <file>...              one digest per file:  <sha256>  <path>
#   node-digest.sh --set <file>...        one digest over the sorted (id, digest) pairs, for a set
#   node-digest.sh --canonical <file>     print the canonical form itself, to see what is hashed
#   node-digest.sh --exclude <key> ...    omit one top-level frontmatter key block from the digest
#
# WHY --exclude EXISTS, and it is not a convenience. A record that pins a digest cannot live inside
# the thing it pins: writing the pin changes the content, which changes the digest, which changes the
# pin. That is not a fixed point to iterate towards, it is a hash of itself, and the first version of
# this check tried to converge on one and could not. So a binding record names itself as excluded.
# `audience-grant-check.sh` passes `--exclude audience_grant` for exactly this reason, and the
# consequence is deliberate: editing the grant (a re-approval, a corrected date) does not invalidate
# it, while editing anything the grant was approving does.
#
# Exit 0 on success, 2 on usage or a missing dependency. A file with no frontmatter is an error
# rather than a silent zero: an unparseable node must not receive a stable-looking version.
#
# CAP03 / B01.
set -uo pipefail

command -v python3 >/dev/null 2>&1 || {
  printf 'node-digest: python3 is required. A digest that degrades to a different algorithm when a\n' >&2
  printf 'node-digest: dependency is missing would produce two versions of one node, so this refuses.\n' >&2
  exit 2
}

MODE="each"
EXCLUDES=""
while [ "$#" -gt 0 ]; do
  case "$1" in
    --set)       MODE="set"; shift ;;
    --canonical) MODE="canonical"; shift ;;
    --exclude)   [ -n "${2:-}" ] || { printf 'node-digest: --exclude needs a key name\n' >&2; exit 2; }
                 EXCLUDES="$EXCLUDES$2,"; shift 2 ;;
    -h|--help)   printf 'usage: node-digest.sh [--set|--canonical] [--exclude <key>]... <file>...\n' >&2; exit 2 ;;
    *)           break ;;
  esac
done
[ "$#" -gt 0 ] || { printf 'usage: node-digest.sh [--set|--canonical] [--exclude <key>]... <file>...\n' >&2; exit 2; }

python3 - "$MODE" "$EXCLUDES" "$@" <<'PY'
import hashlib, sys

mode = sys.argv[1]
excluded = set(k for k in sys.argv[2].split(",") if k)
paths = sys.argv[3:]

def canonical(text):
    text = text.replace("\r\n", "\n").replace("\r", "\n")
    lines = [ln.rstrip() for ln in text.split("\n")]
    if not lines or lines[0] != "---":
        return None, None
    try:
        end = lines.index("---", 1)
    except ValueError:
        return None, None
    fm, body = lines[1:end], lines[end + 1:]

    # Group each top-level key with the indented lines that belong to it, so sorting by key name
    # cannot disturb the order of a list's items.
    blocks, current = [], None
    for ln in fm:
        if ln[:1] not in (" ", "\t", "") and ":" in ln:
            current = [ln]
            blocks.append(current)
        elif current is not None:
            current.append(ln)
        else:
            blocks.append([ln])
    blocks = [b for b in blocks if b[0].split(":", 1)[0] not in excluded]
    blocks.sort(key=lambda b: b[0].split(":", 1)[0])

    while body and body[-1] == "":
        body.pop()

    node_id = ""
    for b in blocks:
        if b[0].startswith("id:"):
            node_id = b[0].split(":", 1)[1].strip().strip('"').strip("'")
            break
    canon = "\n".join(["\n".join(b) for b in blocks]) + "\n--\n" + "\n".join(body) + "\n"
    return canon, node_id

rows, failed = [], 0
for p in paths:
    try:
        raw = open(p, "r", encoding="utf-8", errors="replace").read()
    except OSError as e:
        sys.stderr.write("node-digest: cannot read %s: %s\n" % (p, e))
        failed = 1
        continue
    canon, node_id = canonical(raw)
    if canon is None:
        sys.stderr.write("node-digest: no frontmatter block in %s; refusing to emit a version for it\n" % p)
        failed = 1
        continue
    if mode == "canonical":
        sys.stdout.write(canon)
        continue
    rows.append((node_id or p, hashlib.sha256(canon.encode("utf-8")).hexdigest(), p))

if mode == "each":
    for _, digest, p in rows:
        print("%s  %s" % (digest, p))
elif mode == "set":
    pairs = "".join("%s %s\n" % (i, d) for i, d, _ in sorted(rows))
    print("%s  (%d node(s))" % (hashlib.sha256(pairs.encode("utf-8")).hexdigest(), len(rows)))

sys.exit(failed)
PY
