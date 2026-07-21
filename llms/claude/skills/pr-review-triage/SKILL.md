---
name: pr-review-triage
description: >
  Triage unresolved PR review threads, including GitHub Copilot review
  comments, under strict approval gates. Use this skill whenever the user
  wants to work through pull request review feedback, address Copilot
  comments, respond to reviewers, or clear a review backlog — even if they
  don't say "triage" or "skill". Triggers on "review comments", "Copilot
  comments", "PR feedback", "unresolved threads", "address the review",
  "respond to reviewers", "go through the PR comments".
---

# PR Review Triage

Work through unresolved review threads on a pull request under strict
approval gates. GitHub Copilot comments and human reviewer comments are
treated identically — a thread is a thread.

The whole point of this skill is control: the user stays in the loop at
every side-effecting step (editing, committing, replying, resolving).
The model does the tedious parts — fetching, grouping, drafting, running
tooling — but never takes an irreversible or visible-to-others action
without a green light. If you find yourself about to edit, commit, post,
or resolve without an explicit yes, stop.

## Hard constraints

Three gates. Each guards an action that's hard to walk back — code
changes, commits, and comments other people will see. They exist because
the model's instinct is to be helpful and keep moving, and that instinct
is exactly what causes it to blow past a checkpoint the user wanted.

- **GATE 1 — never edit code before the user approves the proposed fix.**
- **GATE 2 — never commit before the user approves the commit, message included.**
- **GATE 3 — never resolve a thread before the user confirms the reply.**

If you're unsure whether you have approval at any gate, you don't. Ask.

## Prerequisites

- `gh` CLI, authenticated (`gh auth status`).
- The working directory is a repo with an open PR, or the user names a PR
  number / URL. If it's ambiguous which PR, run `gh pr status` and ask
  rather than guessing.

## Step 1 — List unresolved threads, grouped by topic

Fetch review threads with `gh api graphql`. Reach for GraphQL rather than
the REST reviews endpoint because REST doesn't expose whether a thread is
resolved — you need the `reviewThreads` connection on the pull request,
which carries `isResolved`, `isOutdated`, `path`, `line`, the comment
bodies, and each comment's author login. Keep only the threads that are
unresolved.

Group them by **topic, not by file**. Infer the topic from what the
comments are actually about (error handling, naming, test coverage, type
safety, and so on). Grouping by topic is what makes the rest of the
workflow coherent: fixes get reasoned about together, and each group
becomes one commit later.

Flag which threads are Copilot-authored (a bot login such as
`copilot-pull-request-reviewer[bot]` — check an actual comment's author
since the exact login varies by GitHub deployment). Copilot comments tend
to be mechanical and safe to batch; human comments more often need
judgment.

Present a compact grouped list: topic, thread count, the file:line refs,
and a one-line summary per thread. Don't propose fixes yet — the user
should see the whole landscape before deciding anything.

## Step 2 — Propose fixes per thread

For each thread, propose a concrete fix — prose or a short diff sketch,
whatever communicates the change most clearly. Batch the proposals by
topic so the user can approve a group in one go.

**STOP. Wait for explicit approval before touching any file (GATE 1).**

Approval is per-thread or per-group. A "looks good" on one group is not
approval for the others, and silence is not approval for anything.

## Step 3 — Apply approved fixes

Only for approved threads, and work **one topic group at a time** so each
group can be committed on its own in Step 4 before you move on:

1. Make the edits for the group.
2. Run the project's format / lint / fix commands. Detect them rather
   than assuming — look at package.json scripts, a Makefile, a
   pre-commit config, .editorconfig. If nothing is discoverable, ask
   which commands to run instead of skipping validation.
3. Validate: run the relevant tests, or a build if it's fast enough to
   be worth it.
4. Report what changed and surface any command that failed.

Don't advance to the commit for a group until that group is green.

## Step 4 — Commit per topic group

Commit the approved fixes one topic group at a time, so PR history maps
onto the review topics addressed rather than landing as one blob.

If the **staged-commits** skill is available, use it — pass the Step 1
topic groups as the segmentation so it skips its own inference. It owns
the message convention and enforces GATE 2 as its approval step.

If it isn't available, do it inline: for each group, propose the files to
stage and a commit message, **STOP for approval (GATE 2)**, then stage
only that group's files (never `git add -A`) and commit. Match the repo's
existing message style — check `git log --oneline -20` first.

## Step 5 — Draft replies, then resolve only on confirmation

For each addressed thread, draft a reasoned reply: what changed and why,
or — if the suggestion was declined — why. Keep replies factual and
short, referencing the commit or line where it helps. A declined
suggestion still gets a reply; disagreeing with a reviewer politely and
on the record is part of the job.

Post replies only after the user confirms the wording.

**Do NOT resolve any thread until the user explicitly confirms (GATE 3).**
Resolving is a separate, deliberate action — never bundle it with posting
the reply. The reply says "here's what I did"; resolving says "this is
settled", and only the user gets to make that second call.

## Wrap-up

End with a short status summary so the user can see where every thread
landed: resolved, replied-but-not-resolved, declined, and deferred.

## Notes

- If a thread is `isOutdated`, flag it — the code it points at may have
  already moved, and the fix might be moot or already done.
- Don't compress multiple reviewers' distinct concerns into one reply
  just because they share a topic; reply on each thread.