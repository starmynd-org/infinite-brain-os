---
id: "cmd-promote"
aliases: ["cmd-promote", "promote"]
type: "Command"
namespace: "personal-operator"
lifecycle_state: "research"
summary: "Command that prepares a personal node for promotion into canon repos."
confidence: 0.85
retrieval_class: "identity"
export_class: "internal"
description: "Promote a node from this personal repo to a department or company-canon repo. Rewrites frontmatter, resolves wikilinks, copies the file across repos, and opens a PR against the target repo."
edges:
  - target: "[[skill-cross-repo-move]]"
    relation: "delegates_to"
    confidence: 0.95
  - target: "[[agent-brain-curator]]"
    relation: "produces_input_for"
    confidence: 0.6
created: "2026-05-20"
---

# /promote

Promote a node from this personal repo to a department or company-canon repo. The command rewrites the frontmatter to match the target repo's conventions, scans wikilinks for cross-repo references, copies the file into a working branch in the target repo's clone, and opens a pull request for the canonization gate to review.

## Usage

```
/promote path/to/node.md target=department
/promote path/to/node.md target=company-canon
```

The first argument is the path to the node file in this repo (for example, `knowledge/personal-operator/playbooks/attribution-standard.md`). The `target` argument names which canon repo to promote into.

## What this command does

1. Reads the source node file and verifies it has `lifecycle_state: research`. Any other state is a refusal. `scratch` is too early. `candidate` and `canon` are already promoted. `archive` should be reopened first.
2. Looks up the target repo path. Convention: the target repo is cloned as a sibling directory next to this personal repo (for example, `../acme-marketing/` for `target=department` or `../acme-company-canon/` for `target=company-canon`). If the sibling is not present, the command fails with a clear message ("clone the target repo as a sibling before running /promote").
3. Delegates to `[[skill-cross-repo-move]]` for the file-move, frontmatter-rewrite, and wikilink-resolution mechanics.
4. Opens a pull request against the target repo via `gh pr create`. PR title: `promote: {node-id}`. PR body: a summary of what is being promoted, the source node id, the source repo, and a checklist for the reviewer.

## Frontmatter rewrite rules

The command applies these rewrites to the moved file:

| Field | Source value | Target value |
|-------|--------------|--------------|
| `lifecycle_state` | `research` | `candidate` |
| `namespace` | `personal-operator` | depends on target: `canon-department` or `canon-company` |
| `local_path` | path in personal repo | path in target repo |

For nodes that already have richer frontmatter (`visibility`, `owner_type`, `export_class`), the command preserves those fields but normalizes them to the target repo's defaults (for example, `visibility: workspace`, `owner_type: team` for department, `owner_type: company` for company-canon).

## Wikilink resolution

The command scans the body of the file for in-body `[[wikilinks]]`. For each:

1. If the wikilink points to a node that exists in this personal repo only and is not being promoted in this PR, the link is flagged in the PR description: "this promotion references a personal-repo-only node; the reviewer should decide whether to inline the reference, exclude the dependency, or open a follow-up promote for that node."
2. If the wikilink points to a node that already exists in the target repo, the link is preserved as-is.
3. If the wikilink points to a node in the other canon repo (for example, promoting to department but the link points at company-canon), the link is preserved. Cross-canon references are valid.

## PR description template

The command generates a PR description using this template:

```markdown
## Promotion of {node-id}

**Source:** {source-repo}@{branch} `{source-path}`
**Target:** {target-repo} `{target-path}`
**Lifecycle:** research to candidate

### Body summary

{first paragraph of the node body}

### Wikilink notes

(any cross-repo or personal-only references the reviewer should know about)

### Canonization checklist

- [ ] Frontmatter complete and valid (run `bash _system/validate.sh` from the target repo root if available)
- [ ] Node-type is appropriate for the target repo's conventions
- [ ] Body content adheres to voice-and-style rule
- [ ] All wikilinks resolve in the target repo
- [ ] Reviewer accepts the promotion and merges, moving lifecycle to `canon`
```

## Edge cases

- **Target repo is not cloned as a sibling**: fail with a clear message listing the expected path and a suggested `git clone` command.
- **Source node has `lifecycle_state` other than `research`**: refuse with a message stating the required prerequisite and the lifecycle progression rules.
- **Source node has missing required frontmatter fields**: refuse and list the missing fields. Suggest running `bash _system/validate.sh` if installed, or fixing by hand.
- **Existing file with the same id in the target repo**: refuse and propose either renaming the source node or opening an UPDATE PR against the existing canonical file instead.
- **Network or `gh` CLI unavailable**: complete the file copy and frontmatter rewrite locally, then emit instructions for opening the PR by hand.

## Notes

- This command does not delete the source file from the personal repo. The reviewer or the operator may delete it after the candidate is merged to canon, or may keep it as a working copy.
- The command always operates on a fresh git branch in the target repo (auto-named `promote/{node-id}`), never against the default branch.
