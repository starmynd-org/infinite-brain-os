---
id: "playbook-ai-architecture-secret-reference-model"
aliases: ["playbook-ai-architecture-secret-reference-model", "ai-architecture-secret-reference-model"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Provider-neutral secret-reference pattern: repo stores references, trusted runtime binds them, and the model receives redacted results rather than raw values."
confidence: 0.9
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[knowledge-ai-architecture-deterministic-workflow-boundary]]"
    relation: "depends_on"
    confidence: 0.81
  - target: "[[knowledge-ai-architecture-surface-boundary]]"
    relation: "implements"
    confidence: 0.84
created: "2026-05-29"
---

# AI Architecture Secret Reference Model

## Summary

Infinite Brain repos should store structured secret references and policy metadata,
not secret values. Resolution happens inside a trusted runtime at the point of tool
use.

## Content

Canonical rule:

- repo stores `secret_ref` metadata
- runtime authorizes and binds the secret
- executor receives the bound value
- model sees references, policy, and redacted tool results

Recommended posture:

- 1Password as default v1 backend for human and browser-centric use
- possible later hybrid routing to Google Secret Manager for machine-runtime secrets
- stable repo-facing `secret_ref.id` even if provider routing changes later
- root `secrets/` registry in git for references and policy metadata only

Recommended durable home:

- `secrets/` stores one entry per stable `secret_ref.id`
- `tools/`, `_system/surface-registry/`, and deterministic workflow companion nodes point at those
  ids
- namespaces may mention protected external systems, but they usually point at the tool or surface
  that binds the secret rather than acting as the credential record
- secret entries may carry `scope_class`, `consumer_departments`, `consumer_systems`, and stable
  `client_slug` or `brand_slug` metadata before any dedicated client or brand namespace exists
- real `client_namespace` or `brand_namespace` links are optional overlays, not mandatory
  prerequisites for capturing the secret inventory

Cross-entity rule:

- tools declare the auth boundary and may list `secret_refs`
- surfaces declare which identity and runtime may resolve the reference
- deterministic workflows reference secrets in their companion markdown, never inline them in JSON
- future design-system or brand namespaces may describe protected design-tool, email-platform, or asset-store
  dependencies, but the secret still resolves through the runtime tool or surface, not the
  namespace itself
- future AI agents should register metadata in `secrets/` before or alongside any approved backend
  upload, and should never autonomously commit raw credential material into git

This matters for AI architecture because it keeps the model out of raw credential
possession while still allowing bounded runtime execution.

## Evidence

Primary sources:

- an internal build record (not shipped)
- an internal build record (not shipped)
- an internal build record (not shipped)

## Edges

- `depends_on` the deterministic-workflow boundary because secret binding rules are
  most relevant at runtime surfaces.
- `implements` the surface boundary because secrets are one of the clearest tests of
  whether a surface is respecting its contract.

## Notes

This node captures the architecture pattern, not a full provider implementation API. The cited
2026-05-28 sprint evidence path is not currently present at the expected location in this repo;
the durable architecture contract for the pattern is therefore this playbook plus the operative
`_system/secret-registry-rules.md` file.
