# decision-trees/

This folder holds decision tree nodes. A decision tree takes a situation as input and
routes the operator to the right procedure, diagnostic, or escalation path.

## What goes here

One `.md` file per decision tree. The file is a knowledge node with full frontmatter.
The body presents branching logic, usually as a series of yes/no questions that lead to
a specific SOP link, diagnostic link, or escalation instruction.

Decision trees are useful when:

- The correct procedure depends on a condition that must be checked first.
- Multiple procedures could apply to the same trigger but lead to different outcomes.
- A new team member needs explicit routing guidance to avoid choosing the wrong path.

## Format

A minimal decision tree body:

1. State the situation the tree covers.
2. Ask the first branching question.
3. For each branch, either resolve to a procedure or diagnostic node link, or ask the
   next question.
4. Each terminal branch ends with a concrete action or link. "Use judgment" is not a
   terminal branch.

## What does not go here

Do not put procedure steps or diagnostic investigation logic here. The decision tree
routes to those nodes; it does not replace them.
