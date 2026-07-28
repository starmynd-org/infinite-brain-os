#!/usr/bin/env bash
# operations-register-reconcile-check.sh
#
# Warn-only reconciliation check for the unified operations register
# (knowledge/ai-architecture/playbooks/unified-operations-register.md). The
# register at departments/operations-register.md is an aggregate VIEW over each
# department's departments/<slug>/OPERATIONS.md (the authoring owner). This check
# reports drift between the two surfaces:
#
#   - the register file is missing;
#   - a department has an OPERATIONS.md but its slug is absent from the register.
#
# v1 is roster-level (every department with a cadence appears in the register).
# Row-level reconciliation (every OPERATIONS task row projected into the register)
# is a follow-on. _template and fleet-coordinator are excluded by design (a template and the
# fleet-rollup emitter, not registrable departments).
#
# Always exits 0 in the current warn-only posture (_system/enforcement-tiers.md).

set -u

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
REGISTER="$ROOT/departments/operations-register.md"

drift=0
note() {
  echo "operations-register: $1"
  drift=$((drift + 1))
}

# Count registrable departments (an OPERATIONS.md outside _template and fleet-coordinator).
# A repo with none, such as a fresh starter clone, has nothing to reconcile, so
# a missing register file is expected state there, not drift.
registrable=0
for ops in "$ROOT"/departments/*/OPERATIONS.md; do
  [ -e "$ops" ] || continue
  slug="$(basename "$(dirname "$ops")")"
  case "$slug" in
    _template|fleet-coordinator) continue ;;
  esac
  registrable=$((registrable + 1))
done

if [ ! -f "$REGISTER" ]; then
  if [ "$registrable" -eq 0 ]; then
    echo "operations-register: no department carries an OPERATIONS.md yet; no register view is required."
    exit 0
  fi
  note "departments/operations-register.md is missing; the unified operations register has no view file."
  echo "operations-register: 1 drift finding (warn-only)."
  exit 0
fi

for ops in "$ROOT"/departments/*/OPERATIONS.md; do
  [ -e "$ops" ] || continue
  slug="$(basename "$(dirname "$ops")")"
  case "$slug" in
    _template|fleet-coordinator) continue ;;
  esac
  if ! grep -q "$slug" "$REGISTER"; then
    note "department '$slug' has an OPERATIONS.md but is not listed in operations-register.md (register it per the unified-operations-register playbook)."
  fi
done

if [ "$drift" -eq 0 ]; then
  echo "operations-register: every department with an OPERATIONS.md is listed in the register."
else
  echo "operations-register: $drift drift finding(s) (warn-only)."
fi

exit 0
