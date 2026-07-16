# Asset Registry Rules

This file is the operative contract for the root asset-reference registry.

Doctrine lives in:

- `knowledge/ai-architecture/decisions/asset-reference-model.md`
- `knowledge/ai-architecture/playbooks/secret-reference-model.md` (the precedent pattern)
- `knowledge/ai-architecture/concepts/surface-boundary.md`

## Purpose

Use this rule file to answer:

- where durable asset references live
- what may be stored in git about an image, brand asset, design file, or other large binary
- which object-store backend a given asset should route to
- how tools, surfaces, and departments point at stored assets safely
- how multiple people or agents can add new asset references concurrently without conflict

## Canonical home

Durable asset references live at:

```text
assets/
```

Minimum root shape:

```text
assets/
  README.md
  _template.md
  <asset-id>.md
```

This registry is for references and policy metadata only. Image bytes, video files, design
source files, and other binary payloads do not belong here.

## Core rule

The repo stores references, policy, and scope. A trusted upload path binds the object at the
point of use. The baseline sequence is:

1. a surface or agent has a file to store: an upload, a generated image, a brand asset
2. it calls the shared upload tool (`tools/asset-intake.md`) rather than writing to git or to a
   backend directly
3. the tool resolves the backend from the asset's declared `scope_class` (see Routing below)
4. the tool uploads the object, computes a content hash, and writes or updates
   `assets/<asset-id>.md`
5. the caller and any later reader receive the stable `asset_ref.id` and resolved URL; the model
   sees the reference and its description, not raw binary data by default

## Why one file per asset

Every asset reference is its own file, `assets/<asset-id>.md`, never an entry appended to a
shared manifest. This is a concurrency rule, not a style choice: when several people or agents
add new images to the same department brain at the same time, one file per asset means each
addition is an independent new file and an independent commit. A shared `assets/registry.yaml`
would force every concurrent addition through the same file and reintroduce the merge-conflict
problem this registry exists to avoid.

## Routing: backend is chosen by scope, not fixed repo-wide

`asset_ref.backend` varies by `scope_class`, the same way `secret_ref.backend` already varies
by runtime. Default routing:

- `client-scoped`: Google Cloud Storage. Matches the existing GCP-native posture already wired
  for Secret Manager, BigQuery, and Firestore, and keeps client asset access inside the same
  IAM boundary as other client-scoped infrastructure.
- `brand-scoped`: a dedicated asset host such as Cloudinary, when the use case needs image
  transforms, responsive delivery, or a browsable upload library rather than plain storage.
- `app-embedded`: Vercel Blob, when the asset is consumed by a surface already deployed on
  Vercel.
- `shared-platform` or `department-local`: default to Google Cloud Storage unless a department
  has a documented reason to route elsewhere.

A domain department may declare a different default for its own `scope_class` bucket only when
the asset's use case (transforms, delivery, embedding target) materially requires a different
backend. Record the reason in the asset entry's `notes`, not only in a department conversation.

## Ownership

Shared platform assets (icons, shared templates, cross-department style tokens) default to
`devops-platform` or the namespace that owns the design-system doctrine.

A domain department may own an asset reference when the asset is materially department-local,
for example a marketing department owning its own brand campaign images. Even then, the durable
entry still lives in the root `assets/` registry, mirroring how a department-owned secret still
lives in the root `secrets/` registry.

## Allowed callers

The following durable surfaces may point at `asset_ref.id` values:

- tool registry entries in `tools/`, most centrally `tools/asset-intake.md`
- surface declarations under `_system/surface-registry/`
- party records in `parties/` (a brand or client party may list `asset_refs`)
- department assembly notes and knowledge namespace bodies, by reference

Knowledge namespaces, especially a design-system profile, may describe what an asset is and
show it in use, but the durable reference and its backend metadata should resolve through the
`assets/` registry entry rather than being restated inline.

## Scope attachment

Every durable asset reference should carry:

- a required `owner_department`
- at least one concrete consumer anchor through `consumer_departments` or `consumer_surfaces`

Optional scope overlays:

- `scope_class` for blast-radius posture and backend routing
- `party_slugs` for broad party attachment
- `client_slug` and `brand_slug` for stable scope keys shared with the secret-reference and
  party-registry schemas

Do not create a namespace solely to hold asset classification. Use stable party, client, and
brand slug metadata first.

## Agent guardrails

Future AI agents operating in this repo should follow this default sequence:

1. never write raw binary content into git as part of a commit
2. call `tools/asset-intake.md` (or the surface's declared equivalent) to store a new file and
   obtain a stable `asset_ref.id`
3. register or update the durable `assets/<asset-id>.md` metadata entry as the only durable git
   record of the upload
4. write a plain-language description of the asset's visual content into the entry body, so the
   asset is legible to an agent that never fetches the bytes

Default ingestion posture:

- metadata registration is expected by default whenever a new asset is stored
- backend upload is allowed only through the approved shared tool, never an ad hoc script per
  surface
- bulk import of a large existing image library without explicit operator direction is not
  allowed

## Not allowed in git

- image, video, or design-file bytes of any size
- direct commits of binary content to `assets/` or anywhere else in the repo
- live upload queues or in-progress draft state
- content-embedding vectors (a future multimodal retrieval profile, if built, owns that
  concern; this registry does not)

## Related contracts

- `_system/asset-reference-schema.md`
- `_system/secret-registry-rules.md` (the precedent pattern)
- `_system/party-registry-schema.md`
- `_system/tool-registry-rules.md`
- `_system/surface-contract-rules.md`
- `knowledge/ai-architecture/decisions/asset-reference-model.md`
