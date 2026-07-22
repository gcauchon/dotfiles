---
name: lessons-learned
description: Capture a correction as a reusable rule in tasks/lessons.md so the same mistake doesn't recur. Use after the user corrects your approach mid-task, after you catch and fix your own mistake, or when asked to record/review lessons learned. Do not invoke for routine todo tracking — the harness already handles that natively.
---

# Lessons Learned

After a correction — the user redirects you mid-task, or you catch and fix your own mistake — record the lesson so it doesn't recur.

## When to record

- The user explicitly corrects an approach, assumption, or output.
- You self-catch a mistake after acting on a wrong assumption.
- Not for one-off typos or environment glitches — only patterns likely to recur.

## Where

- `tasks/lessons.md` **in the current repo only**. This is a project-scoped file, not a personal one — never create it in a work repo unless the correction is specific to that repo's conventions. For personal dotfiles/scratch work, still scope it to the repo you're in.
- If the repo already has its own lessons/conventions doc (check `CLAUDE.md` or existing `tasks/` files first), append there instead of creating a duplicate.

## Format

One bullet per lesson, phrased as a rule, not a narrative:

```
- Prefer rebase over merge for local branches — the repo's CLAUDE.md says so explicitly; don't default to merge.
- Read a file before editing it even if the harness reports it as "current" — the Edit tool errors otherwise.
```

Bad: "I made a mistake by using merge instead of rebase, so next time I should rebase." Keep it terse and actionable.

## Consolidation discipline

- Cap `tasks/lessons.md` around 100 bullets. Past that, adherence degrades the same way an overloaded CLAUDE.md does.
- When appending would exceed the cap, or during a natural pause, review the file: merge duplicates, drop lessons superseded by a later one, promote genuinely stable rules into the repo's `CLAUDE.md` if they're not project-specific.
- Prune, don't just append.
