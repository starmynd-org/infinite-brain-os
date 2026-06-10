# Getting Started

A thirty-minute walkthrough that touches every part of the OS once, using only files inside
this repo. Do it with your AI agent open (Claude Code or Codex) in the repo root.

## 1. Prove the contract (two minutes)

```bash
bash _system/validate.sh
```

Exit 0, zero errors. This is the baseline: every change you make from now on keeps it
that way. The validator checks frontmatter, namespace base surfaces, registry entries,
session surfaces, deterministic-workflow pairing, links, and the style rule.

## 2. Read the doctrine the way an agent does (five minutes)

Read `knowledge/ai-architecture/canon/doctrine-card.md`. It is the one-page projection
agents load at session start. Note the pattern: the card points down into core-doctrine and
the contract layer instead of repeating them. That is retrieval doctrine in action: the
minimal sufficient set, query-class-driven.

## 3. Tour the example world (ten minutes)

Follow the eight-step tour in `README.md`. The fictional candle studio threads one example
of every entity type, cross-linked through frontmatter edges. Two things to notice:

- `knowledge/emberline-studio/canon/brand-essentials.md` carries `verified_at`,
  `verified_by`, and a changelog. Canon is operator-approved, always.
- `data/orders-ledger.md` points at where order numbers live; no numbers are in the repo.

## 4. Run a command (three minutes)

Ask your agent:

```
Run the studio-brief command as if you were the studio's assistant. The orders ledger is
fictional, so improvise plausible numbers and mark them as such.
```

The agent reads `entities/commands/studio-brief.md` (through its `.claude/commands/` shim),
follows its reading list, and produces a brief into `outputs/` with lineage frontmatter.
That round trip (command, reads, output with lineage) is the execution pattern for
everything here.

## 5. Create and promote a note (five minutes)

Ask your agent:

```
Create a scratch Knowledge node in knowledge/emberline-studio/concepts/ called
wholesale-channel.md: two paragraphs on what a wholesale channel would mean for the studio,
full frontmatter, lifecycle_state scratch, one edge to brand-essentials.
```

Run the validator again (still exit 0), read the node, sharpen one sentence, then:

```
Promote wholesale-channel.md to research and note why in one line.
```

That is the lifecycle: scratch (new, possibly wrong) to research (validated, worth
refining). The next states, candidate and canon, require your sign-off, never the agent's.

## 6. Close the loop (five minutes)

If your agent registered a session at the start (the forced startup in CLAUDE.md makes it),
ask it to close out: a review in `sessions/reviews/`, the record moved to
`sessions/closed/`. Read the closeout. That audit trail is what makes agent work in this
repo recoverable and reviewable.

## Where to go from here

- Map your real business onto the OS: `docs/onboard-business.md` runs an interview and
  recommends an architecture.
- Build your first real namespace: `entities/skills/build-namespace.md`.
- Assemble your first department: `entities/skills/build-department.md` plus
  `departments/_template/`.
- Fill in your profile: `knowledge/personal-operator/pillars/operator-profile.md`.
- When the candle studio has taught you what it can, delete it: the namespace, its registry
  entry and INDEX row, and the example entities. The validator will confirm nothing dangles.
