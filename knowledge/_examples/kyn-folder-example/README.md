# kyn-folder-example

A complete, valid `kyn-files/v1` folder for an invented business, Pebble Press
(Synthetic). It is the worked example for `entities/skills/store-kyn-files.md` and the
pointer node `data/kyn-synthetic-example.md` names it. It is not a namespace: no nodes,
no INDEX.md, only the folder a person copies to rehearse the format.

- `kyn/catalog.json`: the catalog with real descriptors (bytes, rows, SHA-256).
- `kyn/dimensions/channel.jsonl`: two members.
- `kyn/facts/sales.jsonl`: 14 prepared cells over three days, with an observed zero, an
  unknown member (`"channel":null`) and an unknown value (`"value":null`).

Check it with the engine's validator (see the skill for how to get it):

```bash
node <engine checkout>/scripts/validate-kyn.mjs knowledge/_examples/kyn-folder-example/kyn --workspace pebble-press
```

The root `.gitattributes` marks `knowledge/_examples/kyn-folder-example/kyn/**` as
`-text` so checkout never rewrites the hashed bytes. Every number here is invented.
