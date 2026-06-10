# .claude/ , Claude Code Adapter

This folder is the Claude Code runtime adapter for the canonical entities in `entities/`.

Files in `.claude/commands/`, `.claude/agents/`, `.claude/skills/`, `.claude/rules/` are
shims, by default symbolic links pointing at the canonical entity files in `../entities/`.

Claude Code loads these shims through its native loader; it does not know it is reading
a symlink. The shim is transparent.

`.claude/hooks/` is different: it contains runtime-specific shell scripts (and the
`README.md` that documents them) that enforce rules during a session. Hooks are not
entities and do not participate in the adapter pattern. They stay in `.claude/hooks/`
and they have no Codex equivalent.

See `entities/README.md` for the canonical/adapter pattern and `sync-adapters.sh` at
the repo root for the Windows-portable fallback.
