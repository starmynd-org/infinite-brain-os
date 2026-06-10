# Namespace Index

Hand-maintained catalog of the registered namespaces in this repo. New namespaces are created
via the `/create-namespace` slash command or by hand from the conventions in this folder. For
the operative overview of this whole layer, read `_system/README.md`; for the reasoning behind
the operative-versus-doctrine split, read
`knowledge/ai-architecture/concepts/system-vs-doctrine-boundary.md`.

The per-namespace registry file in this folder is the authoritative declaration for each
namespace. This index lists the registered set; the per-namespace file carries the full schema.

## Profile registry

The authoritative home for the eight namespace profiles and their folder schemas is
`_system/namespace-profiles.md`. The reasoning behind the profile model is in
`knowledge/ai-architecture/concepts/namespace-profiles.md` (the "why"). Every namespace
declares its `profile`, `canon_posture`, `freshness_posture`, `archive_posture`, and
`expected_folders` in its own `_system/namespaces/<slug>.md` registry entry. A namespace may
also carry optional `party_slugs`, `client_slug`, and `brand_slug` fields when external-party
scope materially shapes retrieval or delivery. The Profile and canon columns below summarize
those declarations; the per-namespace file is the source of truth.

Profile slugs: `doctrine`, `tool-contract`, `data-system`, `design-system`,
`component-library`, `content-strategy`, `operating-library`, `intake-fabric`.

## Catalog

| Namespace | Group | Profile | Canon posture | Freshness | Lifecycle | Purpose |
|-----------|-------|---------|---------------|-----------|-----------|---------|
| `ai-architecture` | `operations` | `doctrine` | `full` | `review-on-edit` | `research` | The shipped reference doctrine: stable AI-system architecture covering planning, execution routing, namespace and profile design, retrieval doctrine, swarm governance, runtime boundaries, and agent-authority limits. |
| `personal-operator` | `personal` | `doctrine` | `thin` | `review-on-edit` | `scratch` | The operator's own namespace: goals, priorities, review cadence, operating notes, and methodology not yet promoted into a more specific namespace. Graduated from the reduced base to the serious base, so it carries the full base folder set. |
| `emberline-studio` | `examples` | `doctrine` | `thin` | `review-on-edit` | `research` | The worked example domain namespace: a fictional candle studio whose canon, concept, and linked entities show the whole pattern in miniature. Reduced base; study it, then replace it with your own first namespace. |

Canon posture: `full` carries `canon/README.md`, `canon/core-doctrine.md`, and
`canon/agent-load-order.md`; `thin` carries the canon README plus a short core-doctrine and
agent-load-order; `none` carries no `canon/` (reduced-base posture). Archive posture is `none`
for both registered namespaces. Freshness is `review-on-edit` for both: neither carries
decaying live state.

## Unregistered reference scaffolds

`knowledge/_examples/` holds eight reduced-base reference namespaces, one per profile:
`component-library-example`, `content-strategy-example`, `data-system-example`,
`design-system-example`, `doctrine-example`, `intake-fabric-example`,
`operating-library-example`, and `tool-contract-example`. They are intentionally unregistered:
they demonstrate the folder shape and node conventions of each profile, they take no routed
intake, and they never appear in the catalog above. Copy from them when standing up a new
namespace; do not route work into them.

## By group

### personal

- `personal-operator`: operator goals, priorities, review cadence, and sandbox knowledge
- `emberline-studio`: the worked example namespace for the starter walkthrough

### operations

- `ai-architecture`: the AI-system architecture and governance doctrine this OS runs on

## Registering a new namespace

Adopters extend this registry as their deployment grows:

1. Create `knowledge/<slug>/` from the matching profile scaffold in `knowledge/_examples/`.
2. Add a per-namespace registry file `_system/namespaces/<slug>.md` following the conventions
   of the existing entries in this folder (profile, canon posture, freshness, archive posture,
   expected folders).
3. Add a row to the catalog table above and a line to the group listing.
4. Extend `_system/retrieval-routing-map.md` and `intake/routing/namespace-routing-map.md` so
   the new namespace is reachable.
5. Run `bash _system/validate.sh` to confirm the registry and the folder shape agree.

## Promotion flow

In a single-repo deployment, lifecycle moves (`scratch` to `research` to `candidate` to
`canon`) happen inside this repo via frontmatter and review. In a multi-repo deployment, when a
scratch namespace stabilizes:

1. Open a pull request in the appropriate department or shared-canon repo that adds the
   namespace file there.
2. Change `lifecycle_state` to `candidate` in the new file.
3. After approval and merge, remove the file from this repo (it now lives upstream).
