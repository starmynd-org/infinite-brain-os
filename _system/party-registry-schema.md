# Party Registry Schema

This file defines the operative shape of a party record. A party is a durable external or
business actor (client, brand, vendor, partner, influencer) that many parts of the OS need to
reference by a stable identity. The layer rationale lives in `parties/README.md`; this file
states the contract the validator enforces.

## Where records live

The root registry home is:

```text
parties/
  README.md
  _template.md
  clients/
  brands/
  vendors/
  influencers/
  partners/
```

One Markdown file per party, filed under the folder matching its `party_type`. The filename is
the party slug (`parties/clients/acme.md` for `party_slug: acme`).

## "Party" as a record type

`Party` is a root-layer record type alongside the eleven executable entity types. Precedent:
sprint READMEs already use the root-layer type `Sprint`. A party record is not Knowledge (it
carries relationship identity, not doctrine), not Data (it points at no analytical store), and
not a namespace (most parties never justify one). It therefore declares `type: "Party"`.

## Required node frontmatter

Every party record is a node-bearing file and must carry the keys `validate.sh` requires of all
nodes:

```yaml
id: "party-clients-acme"        # path-derived: party-<folder>-<slug>
aliases: ["party-clients-acme"] # include the id so wikilinks resolve by filename or id
type: "Party"
namespace: "personal-operator"       # parties are operator relationship records by default
lifecycle_state: "research"          # scratch | research | candidate | canon
summary: "One honest line on who this party is and the current relationship posture."
confidence: 0.9
retrieval_class: "identity"          # a party record is identity, not domain doctrine
export_class: "internal"
created: "YYYY-MM-DD"
```

## Required party-specific fields

These fields predate this schema and remain required; the validator may grow checks for them:

```yaml
party_slug: "acme"              # stable repo-facing key; never change casually
party_type: "client"                 # client | brand | vendor | partner | influencer
display_name: "Acme"
status: "active"                     # free-form but honest, e.g. active, prospective,
                                     # active-trial, active-at-risk, former-fired
parent_party_slug: null              # parent linkage, e.g. a brand under a client
client_slug: null                    # stable scope keys shared with the secret-reference
brand_slug: null                     # schema and namespace registry overlays
namespace_slugs: []                  # related knowledge namespaces, if any
department_slugs: []                 # departments that materially work this party
tool_slugs: []
repo_slugs: []
notes: "Short operator note."
```

Required meaning:

- `party_slug`: the stable identity key other layers reference (`party_slugs` in secret
  references, project PLANs, and namespace registry overlays).
- `party_type`: the classification that decides the folder. One value; a party that behaves as
  several types gets one primary record plus child records, as the Acme tree shows.
- `status`: the current relationship posture, kept honest (a fired client says so).
- `parent_party_slug`: models trees such as client -> child engagement -> brand without
  duplicating the relationship into namespaces.
- linkage lists (`namespace_slugs`, `department_slugs`, `tool_slugs`, `repo_slugs`): pointers
  only. The pointed-at layer owns its own truth.

## Body shape

The template `parties/_template.md` carries the expected sections: Summary, Type and scope,
related namespaces and departments, commercial posture, and operator notes. Keep the body short;
doctrine about a party's domain belongs in a namespace, not here.

## What this schema is not

- not a CRM: live pipeline state, task queues, and approvals stay in runtime systems
- not a credential store: secrets are referenced via `secrets/` entries that point back here
  through `party_slugs`
- not a namespace substitute: create a namespace only when a party accumulates real doctrine
