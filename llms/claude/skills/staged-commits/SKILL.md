---
name: staged-commits
description: >
  Segment an unstructured working tree into a sequence of meaningful,
  intent-based commits — one logical change per commit, not one per file
  and not one giant mixed commit. Use this skill whenever the user wants
  to commit a pile of changes cleanly, split work into sensible commits,
  clean up their working tree before pushing, or turn a messy diff into
  reviewable history — even if they don't say "segment" or "skill".
  Triggers on "commit these changes", "split this into commits", "clean
  up my commits", "make sensible commits", "group these changes", "commit
  my work". Other skills should defer to this one for commit mechanics.
---

# Staged Commits

Turn an unstructured working tree — mixed staged, unstaged, and untracked
changes — into a sequence of meaningful commits. The value of this skill
is a single judgment call, made well and consistently: what counts as one
commit. Get that right and everything else is routine git.

## The grouping principle

Group changes by **intent** — the answer to "why did this change?" — not
by file and not by hunk. A bug fix, a rename, a new feature, a refactor,
a dependency bump: each is one intent, so each is one commit.

Two corollaries follow, and they cut in opposite directions:

- Files that change for the **same reason** belong in the **same commit**,
  even when they live in different directories. A feature that touches a
  route, a component, and a test is one commit, not three.
- Changes that exist for **different reasons** belong in **different
  commits**, even when they sit in the **same file**. That's what
  `git add -p` is for — stage the relevant hunks, leave the rest.

A quick test for right-sizing: each commit's message should fit in one
sentence with no "and". If the message wants an "and", a comma-splice, or
a bullet list, the commit is probably two commits. Conversely, if you
can't say anything more specific than "misc changes", you've split too
fine or grouped things that don't belong together.

Don't over-granulate. One commit per logical change, not per file touched.
A three-line helper and the function that calls it, added together for the
same purpose, are one commit — splitting them just makes history noisier
to read.

## Message convention

Match the repo's existing style rather than imposing one. Read recent
history first:

    git log --oneline -20

Infer the prevailing convention — Conventional Commits
(`feat(scope): …`, `fix: …`), a ticket prefix (`PROJ-123: …`), plain
imperative subjects — and follow it. Consistency with what's already
there matters more than any particular format. If history is empty or has
no discernible pattern, default to a concise imperative-mood subject
("Add retry logic to the upload client", not "Added" or "Adds"), body
only when the *why* isn't obvious from the subject.

## Workflow

### Step 1 — Survey the working tree

See everything before deciding anything:

    git status
    git diff            # unstaged
    git diff --cached   # already staged

Note what's already staged — the user may have staged deliberately, and
that's a signal about how they intend to group. Don't discard it without
reason.

### Step 2 — Propose the segmentation

Lay out the planned commits: for each, the one-line message and the files
(or hunks, when a file splits across commits) it will contain. Order them
so the history reads sensibly and, where it matters, so each commit builds
on its own — foundational changes before the code that depends on them.

**STOP. Wait for explicit approval before committing.**

Committing is the visible, hard-to-cleanly-undo step (rewriting pushed
history is a headache), so the user signs off on the plan first. They may
merge groups, split one further, or reorder — adjust and re-propose rather
than committing over their objection.

### Step 3 — Commit each group

For each approved group, stage explicitly and commit:

- Stage only that group's files (or hunks via `git add -p`). **Never
  `git add -A`** or `git add .` — a catch-all defeats the entire point
  and lets unrelated changes ride along in the wrong commit.
- Verify the staged set matches the plan (`git diff --cached --stat`)
  before committing.
- Commit with the agreed message.

Work through the groups in the proposed order. Report each commit as it
lands.

## Edge cases

- **Whitespace / formatting-only churn**: isolate it into its own commit.
  Format noise mixed into a logic commit buries the real diff and makes
  review painful. A lone "Reformat with prettier" commit is a feature,
  not a failure.
- **Interdependent changes**: if splitting two intents would leave a
  commit that doesn't build or breaks tests, keep them together even
  though they're arguably separate. A commit that compiles and passes is
  worth more than a puristically minimal one — bisectability depends on
  every commit being sound.
- **Pre-staged changes**: treat what's already staged as the user's
  intended grouping unless it clearly mixes intents. If it does, say so
  and propose a re-split rather than silently restaging.
- **Untracked files**: include them where they belong to a group; flag any
  that look accidental (build artifacts, editor files, secrets) instead of
  committing them blindly.

## Reuse by other skills

Other skills that need to commit — PR review triage, for one — should
defer here for commit mechanics instead of restating them. When a caller
already has a grouping (e.g. triage's per-topic groups), take that
grouping as the segmentation and skip Step 1's inference; still honor the
approval gate in Step 2 and the explicit-staging rule in Step 3.