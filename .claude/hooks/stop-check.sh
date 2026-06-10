#!/usr/bin/env bash
# stop-check.sh
# Stop hook wrapper. Thin by design: the logic lives in _system/checks/. Prints
# the uncommitted-work summary and the adapter-drift report as end-of-session
# reminders. Never blocks stop: always exits 0 (warn-only posture, see
# _system/enforcement-tiers.md).

set -u

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"

bash "$ROOT/_system/checks/uncommitted-work-check.sh" || true
bash "$ROOT/_system/checks/adapter-sync-check.sh" || true

exit 0
