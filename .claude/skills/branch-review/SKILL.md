# .claude/skills/branch-review/SKILL.md
---
name: branch-review
description: Thorough branch-vs-master review across nine lenses
---
Dispatch parallel reviewer subagents against `git diff master...HEAD`, one per lens:
1. Correctness & edge cases
2. Concurrency / crash-safety protocol
3. Reuse & duplication (flag ANY logic that exists in two paths)
4. Test coverage & fixture isolation
5. Performance regressions
6. Complexity & maintainability (invoke the `complexity-analyzer` skill over the diff; use its findings table verbatim)
7. Docs/spec drift
8. Design: mechanism vs policy ("if a second user appeared, would I have to refactor?"), separation of concerns and dependency direction, encapsulation, one representation per piece of knowledge, seams with a single user (YAGNI), illegal states / fail fast, outward-facing extension-point changes, vocabulary (one word, one meaning), and conformance to the approved spec and plan (deviations recorded?)
9. Deletion: what the diff can lose. Invoke the `ponytail-review` skill over the
   diff for the code side (its lines verbatim, with its `net:` line). Then add,
   per the "Deletion first" rules in CLAUDE.md: dead code and functions the change
   stopped calling; a fact said in two places, in code or prose (name the place
   that keeps it); comments that tell history; docstrings holding more than
   the objective and the reasoning behind decisions (how the code works only
   when the logic is complex), or restating the code, while a why found
   nowhere else stays; tests that cannot fail when the business logic changes.
   Each finding: lines to cut, what keeps the fact (or nothing). End with the
   net line count possible.

Rules:
- Every finding MUST cite file:line and include a repro or measurement. No unverified root causes.
- Classify Critical / Important / Nit.
- Emit a status line to the user after each agent returns.
- Finish with a single consolidated table, then STOP and ask before fixing.
- Be pragmatic. A finding needs a concrete failure (input or state, then wrong
  result), a measured cost, or a broken rule from CLAUDE.md or the spec.
  "Could be cleaner" alone is not a finding.
- Zero findings is a normal result for a clean diff. The number of findings
  does not measure review quality.
- Critical or Important only if a senior engineer would block the merge on it.
- At most 3 Nits per lens, and only if they change meaning or mislead a reader.
  Code that follows the codebase convention is not a Nit.
- Don't reopen a decision recorded in the spec or an ADR without new evidence.
- After fixing: send each reviewer agent (SendMessage, same agent, so it keeps
  its context) its own findings plus where the fixes are. It re-checks
  read-only: resolved / partly / not with file:line, and any new defect the
  fixes added. Every lens re-checks, including ones that had only Nits: a fix
  can regress their ground. Fix what the re-check finds before committing.
