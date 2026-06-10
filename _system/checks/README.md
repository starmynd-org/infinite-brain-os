# Shared Check Scripts

This folder holds shared, repo-local check scripts callable by Claude Code hooks
(`.claude/hooks/`) and by `_system/validate.sh`. Each script is self-contained, resolves
the repo root relative to its own location, and prints its findings to stdout or stderr.
The hook wrappers stay thin and delegate here, so Codex and the validator can run the
same logic (harness portability).

All checks here are warn-only: with one deliberate exception they always exit 0 and emit
findings for curator or operator review. The exception is `node-lint.sh`, which exits 2
on findings so the PostToolUse hook can feed them back to the model as warn-only feedback
without undoing the write. Promoting any check to blocking (a nonzero exit consumed as a
failure by the validator or a hook) is an operator decision per
`_system/enforcement-tiers.md` and `projects/harness-hardening-program/PLAN.md`.

Like the rest of `_system/`, these files are operative contract surface, not knowledge
nodes; they carry no node frontmatter.

## Checks

- `canon-obligation-language.sh`: greps every `knowledge/*/canon/` folder for obligation
  phrases ("still lacks", "does not yet", "will need", "the biggest gap", "not yet built")
  that signal future-spec content leaking into canon. Canon describes the system as it runs;
  requirements and gaps belong in `synthesis/`. Always exits 0.
- `node-lint.sh <file.md>`: per-file lint for node-bearing markdown. Checks frontmatter
  presence, the eight required node keys (`id`, `type`, `namespace`, `lifecycle_state`,
  `summary`, `confidence`, `retrieval_class`, `export_class`), the em and en dash ban,
  and placeholder text above `lifecycle_state: scratch`. Mirrors the path exemptions in
  `validate.sh` (plumbing patterns, walk prunes, generated trees, the dash-check
  exclusion globs), so a file the validator would skip is skipped here too. Exits 2 on
  findings, 0 on a clean or exempt file. Run at write time by
  `.claude/hooks/post-write-lint.sh`.
- `session-ledger-status.sh`: short ledger report: count of session records in
  `sessions/active/` and a listing of any older than 3 days by their `YYYY-MM-DD`
  filename prefix (Rule SESSION-6 wants those closed out). Always exits 0. Run at session
  start by `.claude/hooks/session-start.sh` and warn-only by `validate.sh`.
- `adapter-sync-check.sh`: drift report for the runtime adapter pattern. Compares every
  file in `entities/{agents,commands,skills,rules}` against its copy in `.claude/` (and
  `.codex/` for agents, commands, and skills; rules have no Codex adapter by design),
  reports missing counterparts, content drift, and orphan adapter files, and warns when
  `CLAUDE.md` or `AGENTS.md` is modified in the git working tree without the other.
  Always exits 0. Run at Stop by `.claude/hooks/stop-check.sh` and warn-only by
  `validate.sh`.
- `uncommitted-work-check.sh`: one-line summary of the git working tree (modified and
  untracked counts) as a Stop-time reminder. Always exits 0. Run at Stop by
  `.claude/hooks/stop-check.sh`.

## Relationship to the enforcement tiers

`_system/enforcement-tiers.md` declares which numbered rule each check (shipped or
planned) enforces and lists the planned cadence audit scripts that do not exist yet
(`session-ledger-audit.sh`, `namespace-health-audit.sh`, `intake-hygiene-audit.sh`).
Adding a script here without a registry row, or a registry row without an honest
shipped-versus-planned mark, breaks that contract.
