# Obsidian Vault Config

This folder contains the Obsidian vault configuration for your personal Infinite Brain
working repo. Open the repo root as an Obsidian vault to get the full experience.

Open `../START-HERE.md` first, then `../OBSIDIAN-DASHBOARD.md`.

---

## What is pre-configured

### app.json

Core Obsidian settings:
- Live preview mode is on (WYSIWYG editing).
- New links use the shortest path format (`[[concept-name]]` not full paths).
- Wikilinks are used (not Markdown links), so the graph view shows all cross-references.
- Frontmatter is hidden in reading view to keep notes visually clean.

### graph.json

The graph view is pre-configured with color coding by `lifecycle_state` using Obsidian property-search groups:

| Color | Lifecycle state | Meaning |
|-------|-----------------|---------|
| Grey | `scratch` | Just created, possibly wrong |
| Green | `research` | Working and worth refining |
| Amber | `candidate` | Nominated for canonization |
| Blue-green | `canon` | Promoted to a department or company-canon repo |
| Light grey | `intake/` folder | Transient; will be triaged |

As you add nodes and set lifecycle states, the graph updates to show the health of
your knowledge base at a glance: too much grey means you have lots of scratch work
that has not been refined; green nodes that are heavily connected are probably
canonization candidates.

---

## Recommended plugins

Install these through the Obsidian Community Plugins panel:

### obsidian-git

Syncs this vault to its git repo automatically. Configure it to:
- Auto-pull every 5 minutes.
- Auto-commit and push on a 10-minute timer.
- Use the commit message format: `vault auto-sync {timestamp}`.

This means your personal working repo is always up to date in GitHub. Agents read git
directly, so keeping the repo synced is what makes your fresh content discoverable to
teammates and to your own future sessions without any manual index rebuild.

### dataview

Lets you write queries inside notes. Useful for:
- Listing all nodes at `lifecycle_state: candidate` so you can see what is pending review.
- Listing all open tasks across `projects/`.
- Listing all memory nodes by date, newest first.

Example query for all candidate nodes:
```dataview
TABLE namespace, type, file.mtime
FROM ""
WHERE lifecycle_state = "candidate"
SORT file.mtime DESC
```

---

## Daily workflow in Obsidian

1. **Start of day:** open `intake/` and check for new stubs. If there are any,
   triage them with Claude Code or handle manually.
2. **During the day:** use the search (Cmd+O or Ctrl+O) to find existing knowledge
   before creating new nodes. If a node exists, link to it; do not duplicate.
3. **End of week:** open the graph view. Look for isolated nodes (no links). Either
   link them to related nodes or decide they are noise and delete them.

---

## Linking convention

Use `[[wikilink]]` format for all in-body cross-references. The link target should
normally be the file's name without the `.md` extension. If the canonical `id`
differs from the filename, add the `id` to `aliases:` so both forms resolve.

Examples:
- `[[example-concept]]` links to the attribution window concept.
- `[[research-assistant]]` links to the research assistant agent.
- `[[example-learning]]` links to the platform ROAS learning.

These links appear as edges in the Obsidian graph view. They also appear in the
Infinite Brain's typed edge graph (frontmatter `edges:` field) for machine traversal.

---

## What Obsidian is and is not

Obsidian is a **surface**: a human viewing and editing interface over the git repository.
It is not a source of truth. The files on disk (in git) are the source of truth.

If you delete or rename a file in Obsidian, you are deleting or renaming it in git.
That is fine for personal work. Be more careful in canon repos: branch-and-PR for
any deletion in a canon repo.

Obsidian's graph, links, and search are views over the files. They update as files
change. They are never authoritative on their own.

## Formatting boundary

Obsidian is a viewing and editing surface, not the schema authority. Do not let plugins rewrite YAML frontmatter keys, array shape, or wikilinks. See `../docs/runtime-format-contract.md` before enabling plugins that modify files.
