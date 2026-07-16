---
id: "rule-tool-three-layer-standard"
aliases: ["rule-tool-three-layer-standard", "tool-three-layer-standard"]
type: "Rule"
namespace: "ai-architecture"
lifecycle_state: "scratch"
summary: "Every registered tool carries a root pointer, a deep tool-contract namespace unless explicitly classified pointer-only, and a repo implementation folder if and only if the tool is repo-native."
confidence: 0.83
retrieval_class: "domain"
export_class: "internal"
description: "Apply this rule when registering, backfilling, or validating any tool entry in the Infinite Brain OS."
verified_by: "operator-pending"
edges:
  - target: "[[_system/tool-registry-rules.md]]"
    relation: "depends_on"
    confidence: 0.84
created: "2026-06-17"
---

# Rule: Tool Three-Layer Standard

Every Tool in the Infinite Brain OS is measured against one three-layer standard.

## The three layers

1. Pointer node: `tools/<name>.md`
2. Knowledge graph: `knowledge/<name>-tool-contract/`
3. Implementation folder: `tools/<name>/`

The pointer node is always required. The knowledge graph is required unless the pointer declares
`contract_status: pointer-only` with a one-line reason. The implementation folder exists if and
only if the tool is repo-native.

## What each layer owns

### Pointer node

The pointer is the shallow registry surface. It states what the tool is, who owns it, what depends
on it, what its runtime boundary is, and where the deeper contract lives.

### Knowledge graph

The tool-contract namespace is the deep contract surface. It holds the call contract, operating
notes, coverage ledger, hardening evidence, harness, decisions, and synthesis for the tool.

### Implementation folder

The implementation folder is code, scripts, fixtures, or packaged runtime owned by this repo. A
repo-native tool has one. An external SaaS, API, CLI, or MCP pointer does not.

## Invariants

1. Every registered tool namespace has a root pointer node.
2. Every root pointer either links an existing `*-tool-contract` namespace or declares
   `contract_status: pointer-only` with a reason.
3. Every repo-native tool has an implementation folder under `tools/`.
4. No non-repo-native tool invents a fake implementation folder just to satisfy structure.

## Pointer-only classification

`contract_status: pointer-only` is an explicit exemption, not a default. Use it only when the tool
entry is intentionally a thin registry or wrapper surface and the real contract belongs somewhere
else or would add no separate trust surface. The pointer must state the reason in one line.

Examples:

- registry surfaces such as `port-registry`
- scaffolds such as `example-mcp`
- local transport wrappers whose external API contract is already documented in another tool
  namespace

## Enforcement posture

This standard is ENFORCED as of 2026-06-17 (the close of the tool knowledge-graph completion
program in the deployment this starter derives from). The shared check
`_system/checks/tool-three-layer-standard-check.sh` exits non-zero, and `_system/validate.sh`
counts that non-zero exit as a validation error, when any root pointer lacks both a linked
`*-tool-contract` namespace and a `contract_status: pointer-only` classification, or when any
`*-tool-contract` namespace has no root pointer.

During the preceding backfill the same check was warn-only so the gap stayed visible without
blocking unrelated work. The backfill closed every gap, so program close promoted the check
from warning to error. A new tool
cannot now be added without either its knowledge graph or an explicit `pointer-only` exemption.

## Build rule

When adding or revising a tool:

1. Create or update the pointer in `tools/`.
2. Decide whether the tool is pointer-only or graph-backed.
3. If graph-backed, create or maintain the `knowledge/<name>-tool-contract/` namespace and link it
   from the pointer.
4. If repo-native, keep the implementation under `tools/<name>/` or the tool's established repo
   folder and make that location explicit in the pointer.

If any step is missing, the tool is incomplete.
