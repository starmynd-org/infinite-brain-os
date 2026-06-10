# entities/ , Canonical Entity Definitions

This folder holds the single source of truth for every executable entity in your
personal working repo:

- `commands/` , Command entity (Claude Code slash commands, Codex commands)
- `agents/` , Agent entity (subagents)
- `skills/` , Skill entity (reusable techniques)
- `rules/` , Rule entity (behavioral constraints)

This personal repo is your build-and-test sandbox. You author entities here, refine
them through `scratch` and `research`, and propose the strong ones for promotion into
the department or company-canon repo.

## The adapter pattern

Per-runtime adapter folders (`.claude/`, `.codex/`) load these files. The adapter folder
contains shims, by default symbolic links pointing at the canonical files in `entities/`.
Each shim is a one-file redirect to a canonical file here.

This honors v3.1 Principle 3 (ports and adapters): the canonical entity model is the
core; each runtime is an adapter at the edge.

## Why symlinks

Symlinks are the lightest possible "include": one inode references another. Edit the
canonical file in `entities/` and every runtime sees the update immediately. No
duplication, no drift.

## Windows portability

Symlinks require either (a) macOS / Linux / WSL, or (b) Windows with developer mode
enabled and `core.symlinks = true` in git config. If you cannot use symlinks on your
system, run:

    bash sync-adapters.sh

This copies the canonical files into `.claude/` and `.codex/` as plain files. After
running, the runtime sees adapter files as concrete files; the trade-off is that you
must rerun the script after editing any canonical entity in `entities/`.

The personal template ships the script at the repo root (not under `_system/`) so
the repo stays self-contained.

## Adding a new entity

1. Create the canonical file at `entities/{type}/{name}.md` with full frontmatter and body.
2. Create the runtime shims:

       cd .claude/{type} && ln -sf ../../entities/{type}/{name}.md {name}.md && cd ../..
       cd .codex/{type} && ln -sf ../../entities/{type}/{name}.md {name}.md && cd ../..

   Or rerun `bash sync-adapters.sh`.

3. As the entity matures, edit only the canonical file under `entities/`. Both
   runtimes pick up the change without any further sync.

## Adding a new runtime

Add a new adapter folder (for example, `.othertool/`) with the same `{type}/`
subfolders. Create shims pointing at `entities/`. Never duplicate entity content;
the adapter folder is a loader, not a definition.

## Notes

- `entities/hooks/` does not exist. Hooks (in `.claude/hooks/`) are runtime-specific
  scripts, not entity definitions. They stay in `.claude/hooks/`.
- Codex does not have a `rules/` subfolder. Rules live in `entities/rules/` for the
  canonical definition; Claude Code reads them via the `.claude/rules/` adapter; Codex
  consumes the same content through `AGENTS.md`.
- Workflows, tools, knowledge, data, memory, outputs, projects all keep their existing
  locations (`workflows/`, `tools/`, etc.). Only the executable-via-runtime entities
  (Command, Agent, Skill, Rule) participate in the adapter pattern.
