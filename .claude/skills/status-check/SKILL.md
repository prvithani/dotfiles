---
name: status-check
description: Draws the remaining work as an ASCII dependency graph, with a status emoji and owner on each step, followed by the steps that wait on the user. Use for status replies, "what's next", "what's pending" or "what do you need from me", when the plan has more than two dependent steps.
---

# Status check

The user reads visually and often reads only the last message of a turn.
The graph shows at a glance what is done, what is moving, and which steps
wait on the user.

Draw the graph in a code block. Write each step as
`<emoji> <slug> (<owner>)`, using the slugs from the session board so the
user can match the graph to the board. Arrows point from a step to the step
that waits on it. Keep a finished step while an open step still depends on
it.

Status emojis: 🔲 to do, 🔄 in progress, 👀 in review, ⏳ waiting on
someone, ❓ needs a decision, 💤 parked, ✅ done, ❌ dropped.

```
✅ group-a-review (w2) ─┐
🔄 count-rule (w1) ─────┴─> 🔲 review-fixes (w1) ─> 🔲 browser-checks (w1)
                                                            │
                                                            v
           🔲 local-tests (me) <─ 🔲 rebase (me) <─ 🔲 fold (me)
```

Under the graph, number the steps that wait on the user, in run order. Give
each one line: the exact command or click, where to run it, why it is
needed, and what it unblocks. Pushes and merges are tracked on the board,
so they stay off this list.

Draw a new graph in each status reply, because states change between
replies. Keep the reply to the graph and that list unless the user asked
something else.
