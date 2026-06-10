# playbooks/

This folder holds repeatable procedures for the content-strategy namespace.

This is a reduced-base scaffold. In a real content-strategy namespace, this folder would
include at minimum:

- `brief-a-piece.md`: how to take an approved angle and produce a content brief from it.
- `audit-angles.md`: how to review all active angles and retire those that are stale.
- `promote-angle.md`: how to move an angle from `research` to `candidate` and what
  checks are required.

## Scaffold note

This folder is intentionally empty in the example namespace. When building a real
content-strategy namespace, add the procedures relevant to how content is produced and
reviewed in your specific program. Each playbook is a knowledge node with full frontmatter
and `type: "Knowledge"`, `retrieval_class: "domain"`.
