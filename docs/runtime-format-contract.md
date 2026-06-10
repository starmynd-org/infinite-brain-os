---
id: doc-runtime-format-contract
title: "Runtime Formatting Contract"
type: doc
namespace: personal
summary: "Formatting rules that keep Paperclip, Obsidian, n8n, Claude Code, and Codex reading the same starter repo without corrupting each other's files."
auto_inject: false
applicable_when: "Use before adding runtime-specific files, workflow exports, or adapter mappings."
confidence: 0.9
verified_at: 2026-05-21
verified_by: ai-architect
staleness_signal: "Review when Paperclip, Obsidian, n8n, Claude Code, or Codex changes its file format expectations."
lifecycle_state: canon
owner_type: user
visibility: private
export_class: internal
retrieval_class: normal
tags: [runtime, formatting, paperclip, obsidian, n8n]
edges: []
related: []
source_url: null
local_path: docs/runtime-format-contract.md
---

# Runtime Formatting Contract

This repository is a git-native knowledge system first. Runtime tools are adapters. They may read or generate files, but they do not define the canonical shape of node files.

## Canonical Markdown nodes

- Node-bearing Markdown files start with YAML frontmatter between `---` lines.
- Body text uses normal Markdown headings, tables, lists, fenced code blocks, and `[[wikilinks]]`.
- Do not hide canonical data in HTML comments, Obsidian-only embeds, or runtime-private JSON blobs.
- When promoting to a department or company-canon repo, preserve frontmatter and let the reviewer request any richer fields required upstream.

## Paperclip

- `paperclip-mapping.json` in the company-canon repo is the Infinite Brain ClientRepoMap contract consumed by the repo adapter and surfaced to Paperclip.
- `paperclip-mapping.json` is strict JSON: no comments, no trailing commas, no secrets.
- Paperclip operational state lives in Postgres, not in Markdown files.
- Department runtime projections should read from `departments/<department-slug>/INDEX.md`
  and any derived runtime mapping defined by `_system/department-runtime-contract.md`.
- Project task checklists in `PLAN.md` are T1/T2 scaffolding only. At T3 they migrate to Paperclip Postgres, with BigQuery receiving historical events.
- Paperclip must preserve YAML frontmatter and `[[wikilinks]]` when surfacing or proposing governance-class edits.

## Obsidian

- Obsidian is a local reading and graphing surface.
- `.obsidian/` is plumbing and does not carry Infinite Brain frontmatter.
- Obsidian plugins must not rewrite YAML frontmatter key names, quote style, or array structure.
- Prefer `[[filename-without-extension]]` links. If the canonical `id` differs from the filename, add that `id` to `aliases:` so Obsidian can resolve both forms. Avoid Obsidian embeds for canonical cross-references.
- Obsidian daily notes, canvas files, and plugin state are not canonical unless promoted into a node-bearing folder with valid frontmatter.

## n8n

- Each production n8n workflow has exactly two committed files under `automations/n8n/`:
  - `{workflow-slug}.json`: the raw n8n export.
  - `{workflow-slug}.md`: the Infinite Brain companion node.
- Workflow JSON is runtime-native and must stay valid JSON. Do not add comments or hand-written notes to the JSON file.
- The companion Markdown file carries frontmatter, purpose, trigger, credentials by name, deployment notes, and ownership.
- Secrets live in n8n credentials or VPS secrets, never in workflow JSON or companion Markdown.
- n8n execution history is operational telemetry. Distilled lessons become `memory` nodes only after review.
- Webhook workflows are not treated as valid after import plus activation alone. They need a post-activation endpoint probe and any unresolved parity issue should be tracked as runtime follow-up work, not guessed away in docs.
- The shared public proof pack for that webhook check lives at `../n8n-live-proof/README.md` when bundled at the repo root.
