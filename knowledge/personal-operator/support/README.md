# personal-operator support

This folder holds provenance and migration receipts only, never derived thinking (that is `synthesis/`)
and never canon (that is `canon/`).

## Graduation receipt: reduced-base sandbox to serious namespace (2026-06-03)

On 2026-06-03, an internal buildout, `personal-operator` graduated from a
reduced-base starter and sandbox namespace to a serious namespace, because the chief-of-staff department
names it as its Core Knowledge (the durable operator model). The change:

- added the serious base surfaces `canon/` and `support/` alongside the existing `INDEX.md`,
  `playbooks/`, and `synthesis/`; `pillars/`, `concepts/`, and `decisions/` (the doctrine-profile
  folders) were already present
- authored `canon/core-doctrine.md`, `canon/README.md`, and `canon/agent-load-order.md` at
  `verified_by: operator-pending`
- created the real `pillars/operator-profile.md` skeleton (deep-work windows, communication style, risk
  and reversibility posture, default approve/want/ignore item classes), with operator-specific values
  marked operator-input-required
- moved the fictional teaching templates off the load-bearing path: `about-this-company.md` (was
  `pillars/`) and `example-concept.md` (was `concepts/`) now live in `_examples/`. Their ids and edges
  are unchanged, so every inbound `[[wikilink]]` still resolves (migration Rule 1)
- updated the registry entry `_system/namespaces/personal-operator.md`: `canon_posture: none` to `full`,
  `lifecycle_state: scratch` to `research`, `expected_folders` to the full serious base, `v2_status`
  stays `upgraded`
- removed `personal-operator` from the `REDUCED_BASE_NAMESPACES` list in `_system/validate.sh` so the
  serious base is enforced (migration Rule 6: the validator evolves with the doctrine in the same wave)

Edge preservation (migration Rule 3): no pre-existing edge or alias was dropped. The relocated templates
keep their ids `knowledge-about-this-company` and `knowledge-example-concept` and all their edges.

## Provenance of the namespace itself

`personal-operator` was created in the 2026-05-30 namespace-first reorganization to keep existing
personal-repo example nodes and operator-local doctrine registry-backed. Its full lifecycle history is
in the registry entry `_system/namespaces/personal-operator.md`.
