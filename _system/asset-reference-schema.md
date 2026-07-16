# Asset Reference Schema

This file defines the operative shape of a durable asset-reference entry. It covers
references and policy metadata only. Asset bytes never live in git.

The root registry home is:

```text
assets/
```

Minimum expected entry shape:

```yaml
asset_ref:
  id: "stable-asset-id"
  status: "planned | live | deprecated"
  kind: "image | brand-style | video | design-file | document | other"
  owner_department: "example-marketing"
  backend: "gcs | cloudinary | vercel-blob | github-release | other"
  locator: "provider-specific-pointer"
  content_hash: "sha256:<hex> or unknown"
  mime_type: "image/png"
  dimensions: "1024x1024 or null"
  variants: []
  scope_class: "shared-platform | department-local | client-scoped | brand-scoped | app-embedded | personal-operator"
  consumer_departments:
    - "department-slug"
  consumer_surfaces:
    - "surface-slug"
  party_slugs:
    - "stable-party-key"
  client_slug: "stable-client-key or null"
  brand_slug: "stable-brand-key or null"
  uploaded_by: "the-operator | agent-slug"
  last_updated: "YYYY-MM-DD"
  license_or_usage_note: "internal only | licensed stock | client-owned or unknown"
  notes: "Short operational note."
```

Required meaning:

- `id`: the stable repo-facing identifier. Never change this casually. A backend migration
  should normally update `backend` or `locator`, not the `id`.
- `status`: whether the asset reference currently resolves to a live object.
- `kind`: the coarse content type. Drives no validation on its own; it exists so a registry
  scan can answer "how many brand-style assets do we have" without opening every entry.
- `owner_department`: the department that owns the posture, most often the department whose
  brief the asset serves (`example-marketing` for brand style assets, a client department for
  client-scoped assets).
- `backend`: the current resolution backend. Not fixed repo-wide; different scopes may route to
  different backends. See `_system/asset-registry-rules.md` for the routing defaults.
- `locator`: the provider-specific pointer (an object path, a CDN id, a bucket key). This may be
  redacted at the operator's discretion if the locator itself is sensitive, but the entry should
  still point at the owning system clearly enough for operators.
- `content_hash`: a hash of the current object, used to detect drift or duplicate uploads
  without re-fetching or storing the bytes. `unknown` is acceptable for a `planned` entry.
- `mime_type`, `dimensions`: descriptive metadata for images and similar media. Omit or set
  `null` fields that do not apply to the asset's `kind`.
- `variants`: optional list of derived-size or derived-format pointers (thumbnail, web, print),
  when the backend produces them. Empty by default.
- `scope_class`: the main blast-radius and ownership posture for the asset reference.
- `consumer_departments`, `consumer_surfaces`: which departments and surfaces materially depend
  on this asset at runtime.
- `party_slugs`, `client_slug`, `brand_slug`: stable scope keys shared with the secret-reference
  and party-registry schemas, so an asset can be found from the party or client it belongs to
  before any dedicated namespace exists.
- `uploaded_by`: who or what added this reference, for audit against a shared, frequently
  edited registry.
- `license_or_usage_note`: whether the asset is safe to reuse externally, client-owned, or
  licensed stock with restrictions. Conservative default is `unknown` until confirmed.

Recommended body sections:

- what this asset is and where it is used
- a plain-language description of the visual content, so an agent can reason about the asset
  without fetching the bytes
- which departments, tools, or surfaces depend on it
- what must never happen with it (for example, redistribution of licensed stock)

What this schema is not:

- not a place for the asset's actual bytes
- not an image-embedding or content-retrieval index
- not the live upload queue or in-progress draft state
- not a substitute for the object store, CDN, or DAM backend that actually holds the file
