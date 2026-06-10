# Surface Registry

This registry lists the surfaces connected to the OS. One file per surface, shaped by
`_template.md` and governed by `_system/surface-contract-rules.md`. Each entry carries the
nine-item declaration and a `class:` of S1 through S5. Each entry should also be linked from
its owning department `INDEX.md`.

This registry mirrors the namespace registry pattern in `_system/namespaces/`: it is the
operative declaration surface, not the running software. The reasoning lives in the doctrine
nodes [[surface-boundary]] and [[surface-classes]].

A surface declaration states what a surface is allowed to read, what it is allowed to change,
and through which gate. The nine items per `_system/surface-contract-rules.md` cover the
surface's identity, class, owning department, truth-plane reads, runtime-local state, promotion
gates, and audit posture. Surfaces are render-plane projections over git canon: read-only truth
reads, local runtime state, and gated promotion events for any durable change.

## Registered surfaces

No surfaces are registered in the starter. The table below is the registry shape; it fills as
you connect surfaces.

| Surface | Class | Department | Status | Declaration |
|---|---|---|---|---|

To register a surface:

1. Copy `_template.md` to `<slug>.md` in this folder and complete all nine declaration items
   plus the class.
2. Add a row to the table above.
3. Link the declaration from the owning department's `INDEX.md`.
4. Run `bash _system/validate.sh`: `check_surface_declarations` enforces that every registered
   declaration has all nine items present.

## Form

- `<surface-slug>.md`: one live surface declaration (validated)
- `_template.md`: the declaration template (not validated)
- `INDEX.md`: this file (not validated)
