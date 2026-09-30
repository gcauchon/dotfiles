---
name: pr-review-triage
description: >
  Triages unresolved PR review threads, including GitHub Copilot review
  comments, under strict approval gates: groups threads by topic, proposes
  fixes, applies approved ones, commits and pushes per topic, drafts replies,
  and resolves threads only on confirmation. Also the target of recurring
  runs (`/loop /pr-review-triage`).
when_to_use: >
  Use whenever the user wants to work through pull request review feedback,
  address Copilot comments, respond to reviewers, or clear a review backlog,
  even if they don't say "triage" or "skill". Triggers on "review comments",
  "Copilot comments", "PR feedback", "unresolved threads", "address the
  review", "respond to reviewers", "go through the PR comments", "watch the
  PR", "babysit the PR", "keep an eye on CI and reviews". Not for reviewing a
  diff yourself (that is code-review).
argument-hint: "[pr-number | url]"
allowed-tools: Bash(gh pr checks *) Bash(gh pr status *)
---

# PR Review Triage

Work through unresolved review threads on a pull request under strict approval gates. GitHub Copilot comments and human reviewer comments are treated identically: a thread is a thread.

The whole point of this skill is control: the user stays in the loop at every side-effecting step (editing, committing, pushing, replying, resolving). The model does the tedious parts (fetching, grouping, drafting, running tooling) but never takes an irreversible or visible-to-others action without a green light. If you find yourself about to edit, commit, push, post, or resolve without an explicit yes, stop.

## Hard constraints

Three gates. Each guards an action that's hard to walk back: code changes, commits and pushes, and comments other people will see. They exist because the model's instinct is to be helpful and keep moving, and that instinct is exactly what blows past a checkpoint the user wanted.

- **GATE 1: never edit code before the user approves the proposed fix.**
- **GATE 2: never commit or push before the user approves it, message included.** Never force-push.
- **GATE 3: never resolve a thread before the user confirms the reply.**

If you're unsure whether you have approval at any gate, you don't. Ask.

The gates apply unchanged in watch mode. A scheduled tick is never approval.

Replies are also governed by a hard rule on voice, not just on timing: see **Reply voice** in Step 5. No acknowledgment openers, no commit hashes.

## Prerequisites

- `gh` CLI, authenticated (`gh auth status`).
- Target PR: if `$ARGUMENTS` names a PR number or URL, use it. Otherwise use the PR for the current branch. If it's still ambiguous, run `gh pr status` and ask rather than guessing.
- Every `gh` call is a single invocation, never piped or chained. API templates are in [reference.md](reference.md).

## Tracking

Create one task per topic group once Step 1 is done (`TaskCreate`), and move each through apply, commit, push, reply, resolve with `TaskUpdate` as it happens. If the groups change, update the list instead of leaving stale items.

## Watch mode (recurring runs)

Started with `/loop /pr-review-triage` (dynamic pacing) or `/loop 20m /pr-review-triage` (fixed interval). Each tick is read-only plus drafting:

1. Resolve the PR for the current branch. If there is none, or it's merged or closed, say so in one line and end the loop: `ScheduleWakeup` with `stop: true` in dynamic mode, or tell the user to cancel the interval (`CronDelete` if this session created it).
2. Run `gh pr checks`. For a failing check, pull the log with `gh run view --log-failed`, diagnose the cause, and propose a minimal fix as prose or a diff sketch. Don't edit files (GATE 1).
3. Run Step 1 and report only threads that are new or changed since the previous tick. A thread is keyed on its node id plus the `databaseId` of its last comment: new id means new thread, same id with a different last comment means changed. Propose fixes per Step 2 and stop at GATE 1.
4. End every tick with a state line, `state: <thread-id>:<last-comment-id> ...` for all unresolved threads, so the next tick (and a compacted context) has the comparison explicit.
5. If checks are green and nothing is new, report that in one line plus the state line. In dynamic mode, wait 20 to 30 minutes, or less while CI is still running.
6. Approvals earlier in the transcript cover only the exact threads or groups they named. Anything else that needs a decision gets surfaced, not acted on.
7. Stay inside this PR.

## Step 1: List unresolved threads, grouped by topic

Fetch review threads with the bundled query (`queries/review-threads.graphql`, call template in [reference.md](reference.md)). GraphQL rather than the REST reviews endpoint, because REST doesn't expose whether a thread is resolved. The query returns `isResolved`, `isOutdated`, `path`, `line`, and each comment's body, `databaseId`, and author. Keep only unresolved threads.

If the response reports `hasNextPage` on threads or on a thread's comments, say the list is truncated. Never present it as complete.

Group threads by **topic, not by file**. Infer the topic from what the comments are actually about (error handling, naming, test coverage, type safety, and so on). Grouping by topic makes the rest of the workflow coherent: fixes get reasoned about together, and each group becomes one commit later.

Flag which threads are Copilot-authored (author `__typename` is `Bot`, with a login such as `copilot-pull-request-reviewer[bot]`; check an actual comment's author since the exact login varies by GitHub deployment). Copilot comments tend to be mechanical and safe to batch; human comments more often need judgment.

For each thread, note who wrote the last comment. If our own reply is last, the thread is awaiting the reviewer and needs no new work. If a reviewer answered our reply, it is new work.

Present a compact grouped list: topic, thread count, the file:line refs, and a one-line summary per thread. Don't propose fixes yet. The user should see the whole landscape before deciding anything.

## Step 2: Propose fixes per thread

For each thread, propose a concrete fix: prose or a short diff sketch, whatever communicates the change most clearly. Batch the proposals by topic so the user can approve a group in one go.

**STOP. Present each group with `AskUserQuestion` (approve / modify / decline / defer) and wait for the answer before touching any file (GATE 1).**

Approval is per-thread or per-group. An approval on one group is not approval for the others, and silence is not approval for anything.

## Step 3: Apply approved fixes

Only for approved threads, and work **one topic group at a time** so each group can be committed on its own in Step 4 before you move on:

1. Make the edits for the group.
2. Run the project's format / lint / fix commands. Detect them rather than assuming: look at package.json scripts, a Makefile, a pre-commit config, .editorconfig. If nothing is discoverable, ask which commands to run instead of skipping validation.
3. Validate: run the relevant tests, or a build if it's fast enough to be worth it.
4. Report what changed and surface any command that failed.

Don't advance to the commit for a group until that group is green.

## Step 4: Commit per topic group, then push

Commit the approved fixes one topic group at a time, so PR history maps onto the review topics addressed rather than landing as one blob.

If the **staged-commits** skill is available, use it and pass the Step 1 topic groups as the segmentation so it skips its own inference. It owns the message convention and enforces GATE 2 as its approval step.

If it isn't available, do it inline: for each group, propose the files to stage and a commit message, **STOP for approval (GATE 2)**, then stage only that group's files (never `git add -A`) and commit. Match the repo's existing message style; check `git log --oneline -20` first.

After the last approved commit, propose `git push` for the PR branch and **STOP for approval (GATE 2)**. Replies describe code the reviewer can only see once it's pushed, so push before Step 5. Never force-push; if the push is rejected, report it and ask.

## Step 5: Draft replies, then resolve only on confirmation

For each addressed thread, draft a reply that opens with the change itself: what the code does now, and why. A declined suggestion still gets a reply, stating the reasoning directly; disagreeing with a reviewer on the record is part of the job.

**Reply voice.** A review thread is a conversation about code, not a social exchange. Three prohibitions, each absolute:

- **No opener before the substance.** The first word is the change. Never "Fixed in `<hash>`", "Confirmed", "Good catch", "Good point", "Right", "Agreed", "Done", "Yes", or any variant of them. The verdict is implicit in the fact that a fix landed, and GitHub's UI already shows the diff.
- **No commit hash in the prose, anywhere in the reply.** Not as an opener, not as a trailing "Fixed in `<hash>`." line. A reviewer reads the code for context, and the hash carries none. GitHub already links the commits on the thread. Name a symbol, a file, or a behaviour instead.
- **No softening before a disagreement.** State the reasoning. Skip "you're right, but", "fair point, however", "in principle yes, though".

Wrong:

> Good catch. `on_connect` now returns early when the broker refuses. Fixed in `6b913af`.

Right:

> `on_connect` now returns early when `reason_code.is_failure`, skipping both `subscribe()` calls and `board.mark_connected()`. Added coverage for the refusal and success paths in `test_session.py`.

Post replies only after the user confirms the wording. Use the reply template in [reference.md](reference.md) and take care to pass the comment `databaseId`, not the thread node id.

**Do NOT resolve any thread until the user explicitly confirms (GATE 3).** Resolving is a separate, deliberate action; never bundle it with posting the reply. The reply says "here's what I did"; resolving says "this is settled", and only the user gets to make that second call.

If the user wants reviewers re-requested after the push, use the re-request template in [reference.md](reference.md).

## Wrap-up

End with a short status summary so the user can see where every thread landed: resolved, replied-but-not-resolved, declined, and deferred.

## Notes

- If a thread is `isOutdated`, flag it: the code it points at may have already moved, and the fix might be moot or already done.
- Don't compress multiple reviewers' distinct concerns into one reply just because they share a topic; reply on each thread.
