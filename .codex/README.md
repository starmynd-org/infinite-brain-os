# .codex/ , Codex Adapter

This folder is the Codex runtime adapter for the canonical entities in `entities/`.

Files in `.codex/commands/`, `.codex/agents/`, `.codex/skills/` are shims, by default
symbolic links pointing at the canonical entity files in `../entities/`.

Codex loads these shims through its native loader. The shim is transparent.

Codex does not have a `rules/` subfolder; rules live in `AGENTS.md` (at the repo root)
and in `entities/rules/` for the canonical definition.

See `entities/README.md` for the canonical/adapter pattern and `sync-adapters.sh` at
the repo root for the Windows-portable fallback.
