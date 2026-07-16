---
id: "decision-ai-architecture-asset-reference-model"
aliases: ["decision-ai-architecture-asset-reference-model", "ai-architecture-asset-reference-model", "asset-reference-model"]
type: "Knowledge"
namespace: "ai-architecture"
lifecycle_state: "research"
summary: "Large and binary files (images, brand style assets, design files, video) never enter git as blobs. Git stores a small asset_ref pointer per file, mirroring secret_ref; the bytes live in an external object store chosen per scope, and a single shared upload tool is the only path that writes a new pointer back."
confidence: 0.87
retrieval_class: "domain"
export_class: "internal"
edges:
  - target: "[[ai-architecture-secret-reference-model]]"
    relation: "derived_from"
    confidence: 0.92
  - target: "[[knowledge-ai-architecture-surface-boundary]]"
    relation: "implements"
    confidence: 0.85
  - target: "[[knowledge-ai-architecture-namespace-profiles]]"
    relation: "supersedes"
    confidence: 0.8
created: "2026-07-13"
---

# AI Architecture Asset Reference Model

## Summary

The brain stays a plain git repo synced through GitHub, so large and binary files (images,
brand style assets, design files, video) never enter it as blobs. Instead, git stores a small
`asset_ref` pointer node per file, applying the same reference-not-value discipline the
`secret_ref` pattern already proves out for credentials. The real bytes live in an external
object store chosen per scope, not one fixed vendor. A single shared upload tool is the only
path that writes a new pointer back, so every surface (cockpit, composer, chat) is a thin
caller instead of reinventing upload logic.

## Content

### Why binary blobs and git do not compose

git history only grows; every clone re-downloads every past revision of every binary forever.
Binary diffs do not merge, so two people or agents touching the same image produce a real
conflict, unlike two markdown pointer files which merge as independent lines. GitHub hard-blocks
files over 100MB. None of this is compatible with the operating constraint that many surfaces
add new images constantly and multiple people work the same department brain at once.

### The pattern: asset_ref mirrors secret_ref

The repo stores references and policy metadata only. A trusted upload path resolves the real
object at the point of use. The operative shape is `_system/asset-reference-schema.md`; the
registry contract is `_system/asset-registry-rules.md`. Minimum fields: `id`, `status`, `kind`,
`owner_department`, `backend`, `locator`, `content_hash`, `scope_class`, `brand_slug`,
`client_slug`, `party_slugs`, `consumer_departments`, `consumer_surfaces`.

### One file per asset, not one shared manifest

`assets/<asset-id>.md`, one file per stable reference, exactly like `secrets/` and `parties/`.
This is a concurrency decision, not a style preference: N people or agents adding N assets in
parallel produce N independent new files and N independent commits. A single shared
`assets/registry.yaml` would recreate the exact write-contention problem the pattern exists to
avoid.

### Multi-backend by design, routed by scope

`asset_ref.backend` is not fixed repo-wide, the same way `secret_ref.backend` already varies
by runtime (1Password for human and browser use, Google Secret Manager for machine-runtime
secrets). Different scopes route to the backend that fits:

- `client-scoped` (CRM, client work) defaults to Google Cloud Storage, matching the existing
  GCP-native posture already wired for Secret Manager, BigQuery, and Firestore.
- `brand-scoped` (marketing and style libraries needing transforms and a browsable UI) may
  route to a dedicated asset host such as Cloudinary.
- `app-embedded` (assets consumed by a Vercel-deployed surface) may route to Vercel Blob.

The routing defaults live in `_system/asset-registry-rules.md`, not hardcoded into any one
surface, so backend choice can evolve per department without rewriting callers.

### One upload tool, many caller surfaces

Upload logic is built once as a repo-native Tool (`tools/asset-intake.md` plus its
implementation folder, following the three-layer tool standard). It takes a file, resolves the
backend by scope, uploads it, computes a content hash, writes or updates `assets/<id>.md`, and
returns the stable id and URL. Every surface (an S2 cockpit drop zone, an S3 composer, an S4
chat agent) calls this one tool rather than owning its own storage integration. This maps
directly onto the existing surface-contract vocabulary: the in-progress upload is runtime-plane
state owned by the calling surface; the moment the tool writes the pointer into git is the
promotion event. No new surface concept is required.

### Brand assets attach through the party layer

`parties/brands/<brand>.md` already exists as the stable identity for a brand. A brand's style
assets attach through an `asset_refs` linkage list on the party record, the same way
`tool_slugs` and `repo_slugs` already work, so a brand's logo and style files are one hop from
its party record without duplicating relationship data into the asset registry.

## Evidence

Primary sources:

- `_system/secret-reference-schema.md` and `_system/secret-registry-rules.md` (the precedent
  pattern this decision applies to binary assets)
- `_system/party-registry-schema.md` and `parties/brands/drift.md` (the existing brand party
  record this decision attaches to)
- `knowledge/ai-architecture/concepts/surface-classes.md` and `_system/surface-contract-rules.md`
  (the promotion-event and runtime-plane framing the upload tool follows)
- `_system/namespace-profiles.md` and `knowledge/ai-architecture/concepts/namespace-profiles.md`
  (the deferred Image / Multimodal gap this decision closes)

## Edges

- `derived_from` the secret-reference model, because the reference-not-value discipline and
  the repo-stores-metadata-only rule are the same pattern applied to a different payload type.
- `implements` the surface boundary, because asset upload is one concrete instance of the
  runtime-state-write versus promotion-event distinction every surface already declares.
- `supersedes` the namespace-profiles concept node and the profile-comparison synthesis node
  on this one point: both previously said an image storage and embedding strategy did not
  exist yet. This decision is that strategy landing.

## Notes

This decision states the registry pattern, the concurrency reasoning, and the routing
discipline. It does not itself provision any cloud bucket, Cloudinary account, or Vercel Blob
store. Standing up a live backend, creating `tools/asset-intake/`, and registering the first
real `assets/<id>.md` entries are implementation steps that follow this decision, each still
gated by ordinary approval where they touch shared infrastructure or spend.

An embedding or retrieval strategy for image *content* (as opposed to image *reference*) is
explicitly out of scope here. This decision closes the storage and reference half of the
deferred Image / Multimodal gap; a real multimodal retrieval profile remains future work if a
namespace later needs to reason over image content itself rather than over an asset's
description.

## Changelog

- 2026-07-13: Initial decision. Establishes the `asset_ref` pattern mirroring `secret_ref`,
  one-file-per-asset registry discipline, multi-backend routing by `scope_class`, and the
  single shared upload tool as the only path that writes a new pointer into git.
  Candidate; promotion to canon is your call as operator.
