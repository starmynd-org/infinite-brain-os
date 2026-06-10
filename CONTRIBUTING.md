# Contributing

Thanks for considering a contribution. This repo is a starter template: most of your work
on it should happen in your own clone, for your own business. Contributions here improve
the template everyone starts from.

## What makes a good contribution

- Fixes to the contract layer: validator bugs, schema gaps, clearer rules.
- Better teaching material: sharper examples, clearer doctrine wording, walkthrough fixes.
- New profile references in `knowledge/_examples/` that show a namespace pattern the
  current eight do not cover.
- Builder improvements: skills and workflows that scaffold better.

## What we will decline

- Anything that stores live data, secrets, or vendor credentials in the repo.
- Examples tied to a real company, product, or person. The example world is fictional on
  purpose.
- Em dashes. The voice rule (`entities/rules/voice-and-style.md`) bans them, and the
  validator enforces it.

## The bar

1. `bash _system/validate.sh` exits 0 with your change in place.
2. New node-bearing files carry full frontmatter (id, aliases, type, namespace,
   lifecycle_state, summary, confidence, retrieval_class, export_class, edges, created).
3. New entities follow the canonical-plus-shim pattern: the file lives in `entities/`,
   `bash sync-adapters.sh` regenerates the `.claude/` and `.codex/` shims.
4. Voice per `entities/rules/voice-and-style.md`: direct, specific, active, short.

## How

Open a pull request with a one-paragraph description of what the change teaches or fixes.
Small and focused beats large and sweeping.
