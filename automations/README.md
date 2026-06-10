# Automations

Deterministic workflows live here, one runtime subfolder per engine. `n8n/` holds n8n workflow
exports: each workflow is a JSON file paired with a companion `.md` node carrying the brain
record (what it does, what it reads and writes, where it runs). The JSON runs in the engine;
the Markdown is the durable brain-side contract. The validator enforces the pairing.

Use deterministic automations where determinism is cheap (scheduled pulls, format conversions,
notifications) and agentic workflows in `workflows/` where judgment is required.
