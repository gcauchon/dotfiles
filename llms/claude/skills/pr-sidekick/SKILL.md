---
name: pr-sidekick
description: >
  Triages unresolved PR review threads, including GitHub Copilot review comments, under strict approval gates: groups threads by topic, proposes fixes, applies approved ones, commits per topic and pushes, drafts replies, and resolves threads only on confirmation. Use whenever the user wants to work through pull request review feedback, address Copilot comments, respond to reviewers, or clear a review backlog, even if they don't say "triage" or "skill". Triggers on "review comments", "Copilot comments", "PR feedback", "unresolved threads", "address the review", "respond to reviewers", "go through the PR comments", "watch the PR", "babysit the PR", "keep an eye on CI and reviews". Also the target of recurring runs (`/loop /pr-review-triage`). Not for reviewing a diff yourself (that is code-review).
argument-hint: "[pr-number | url]"
allowed-tools:
  - Read
  - Write
  - Bash(gh pr checks:*)
  - Bash(gh pr status:*)
  - Bash(gh pr view:*)
  - Bash(gh repo view:*)
  - Bash(gh run view:*)
  - Bash(git status:*)
  - Bash(git diff:*)
  - Bash(git log:*)
---

# PR Review Triage

Work through unresolved review threads on a pull request under strict approval gates. GitHub Copilot comments and human reviewer comments are treated identically: a thread is a thread, and the same gates apply whoever wrote it.

The whole point of this skill is control: the user stays in the loop at every side-effecting step (editing, committing, pushing, replying, resolving). The model does the tedious parts (fetching, grouping, drafting, running tooling) but never takes an irreversible or visible-to-others action without a green light. If you find yourself about to edit, commit, push, post, or resolve without an explicit yes, stop.

## Hard constraints

Three gates. Each guards an action that's hard to walk back: code changes, commits and pushes, and comments other people will see. They exist because the model's instinct is to be helpful and keep moving, and that instinct is exactly what blows past a checkpoint the user wanted.

- **GATE 1: never edit code before the user approves the proposed fix.**
- **GATE 2: never commit or push before the user approves it, message included.** Never force-push.
- **GATE 3: never resolve a thread before the user confirms the reply.**

If you're unsure whether you have approval at any gate, you don't. Ask.

The gates apply unchanged in watch mode. A scheduled tick is never approval.

Replies have their own hard rules on voice: see **Reply voice** in Step 5.

## Prerequisites

- `gh` CLI, authenticated (`gh auth status`).
- Target PR: if `$ARGUMENTS` names a PR number or URL, use it. Otherwise use the PR for the current branch. If it's still ambiguous, run `gh pr status` and ask rather than guessing.
- Every `gh` call is a single invocation, never piped or chained. API templates are in [references/github-api.md](references/github-api.md).
- `allowed-tools` pre-approves only read-only commands. `gh api` is deliberately left out because the fetch, reply, and resolve calls share that prefix and cannot be scoped apart, so each one prompts. Edits, `git add`, `git commit`, and `git push` prompt for the same reason: the harness backs up the gates.

## Tracking

Create one task per topic group once Step 1 is done (`TaskCreate`), and move each through apply, commit, push, reply, resolve with `TaskUpdate` as it happens. If the groups change, update the list instead of leaving stale items.

## Watch mode (recurring runs)

Started with `/loop /pr-review-triage [pr]` (dynamic pacing) or `/loop 20m /pr-review-triage [pr]` (fixed interval). Each tick is read-only plus drafting:

1. Resolve the target PR: the one in `$ARGUMENTS` if given, otherwise the PR for the current branch. If there is none, or it's merged or closed, say so in one line and end the loop: `ScheduleWakeup` with `stop: true` in dynamic mode, or tell the user to cancel the interval (`CronDelete` if this session created it).
2. Run `gh pr checks`. For a failing check, pull the log with `gh run view --log-failed`, diagnose the cause, and propose a minimal fix as prose or a diff sketch. Don't edit files (GATE 1).
3. Run Step 1 and report only threads that are new or changed since the previous tick. A thread is keyed on its node id plus the `databaseId` of `lastComment.nodes[0]`: new id means new thread, same id with a different last comment means changed. Propose fixes per Step 2 and stop at GATE 1.
4. End every tick with a state line, `state: <thread-id>:<last-comment-id> ...` for all unresolved threads, so the next tick (and a compacted context) has the comparison explicit.
5. If checks are green and nothing is new, report that in one line plus the state line. In dynamic mode, call `ScheduleWakeup` with the same `/pr-review-triage [pr]` prompt, `noop: true`, and a delay matched to what you are waiting on: 300 to 600 seconds while checks are pending, 1200 to 1800 seconds when idle.
6. Approvals earlier in the transcript cover only the exact threads or groups they named. Anything else that needs a decision gets surfaced, not acted on.
7. Stay inside this PR.

## Step 1: List unresolved threads, grouped by topic

Fetch review threads with the bundled query (`queries/review-threads.graphql`, call template in [references/github-api.md](references/github-api.md)). GraphQL rather than the REST reviews endpoint, because REST doesn't expose whether a thread is resolved. The query returns `isResolved`, `isOutdated`, `path`, `line`, and each comment's body, `databaseId`, and author. Follow `reviewThreads.pageInfo` until every page is fetched, then keep only unresolved threads. If a thread's own `comments` list is truncated, say so for that thread. Never present partial history as complete.

Group threads by **topic, not by file**. Infer the topic from what the comments are actually about (error handling, naming, test coverage, type safety, and so on). Grouping by topic makes the rest of the workflow coherent: fixes get reasoned about together, and each group becomes one commit later.

Flag which threads are Copilot-authored (author `__typename` is `Bot`, with a login such as `copilot-pull-request-reviewer[bot]`; check an actual comment's author since the exact login varies by GitHub deployment). Copilot comments tend to be mechanical, so they can often be proposed as one batch. Each still needs approval, and human comments more often need judgment.

Classify each thread, reading the last comment from `lastComment.nodes[0]` (the `comments` list holds only the oldest 50, so its final node is not the latest once a thread grows past that):

- **Awaiting reviewer**: our own reply is last. No new work.
- **Change requested**: a reviewer asks for or implies a code change, or answered our reply with one. New work.
- **Question or discussion**: a reviewer asks something that needs an answer, not an edit. New work, but no code change.

Flag `isOutdated` threads: the code they point at may have already moved, so the fix might be moot or already done.

Present a compact grouped list: topic, thread count, the file:line refs, the classification, and a one-line summary per thread. Don't propose fixes yet. The user should see the whole landscape before deciding anything.

## Step 2: Propose fixes per thread

For each change-requested thread, propose a concrete fix: prose or a short diff sketch, whatever communicates the change most clearly. For question threads, draft the answer instead. Batch the proposals by topic so the user can approve a group in one go.

**STOP. Present each group with `AskUserQuestion` (approve / modify / decline / defer) and wait for the answer before touching any file (GATE 1).**

- **Approve**: proceed to Step 3 for a fix, or straight to Step 5 for an answer.
- **Modify**: revise the proposal and ask again.
- **Decline**: no code change. It still gets a reply in Step 5 with the reasoning.
- **Defer**: no edit, no reply, no resolve. The thread is listed as deferred in the wrap-up.

Approval is per-thread or per-group. An approval on one group is not approval for the others, and silence is not approval for anything.

## Step 3: Apply and commit, one topic group at a time

Repeat for each group with approved fixes, finishing a group before starting the next so PR history maps onto the review topics addressed rather than landing as one blob:

1. Make the edits for the group.
2. Run the project's format / lint / fix commands. Detect them rather than assuming: look at package.json scripts, a Makefile, a pre-commit config, .editorconfig. If nothing is discoverable, ask which commands to run instead of skipping validation.
3. Validate: run the relevant tests, or a build if it's fast enough to be worth it.
4. Report what changed and surface any command that failed. Don't commit a group until it is green.
5. Commit the group.

If the **staged-commits** skill is available, use it for the commit and pass the Step 1 topic groups as the segmentation so it skips its own inference. It owns the message convention and enforces GATE 2 as its approval step.

If it isn't available, do it inline: propose the files to stage and a commit message, **STOP for approval (GATE 2)**, then stage only that group's changes (never `git add -A`) and commit. Match the repo's existing message style; check `git log --oneline -20` first.

When two groups touch the same file, stage only this group's hunks with `git add -p <file>` and show the user the staged diff at the approval. If the hunks can't be separated cleanly, offer to merge the two groups into one commit instead.

## Step 4: Push

After the last approved commit, propose `git push` for the PR branch and **STOP for approval (GATE 2)**. Replies describe code the reviewer can only see once it's pushed, so push before Step 5. Never force-push; if the push is rejected, report it and ask.

## Step 5: Draft replies, then resolve only on confirmation

Draft a reply for every thread that was approved, declined, or answered. Threads the user deferred get none. Open each reply with the substance:

- **Fixed**: what the code does now, and why.
- **Declined**: the reasoning, stated directly. Disagreeing with a reviewer on the record is part of the job.
- **Answered**: the answer.

**Reply voice.** A review thread is a conversation about code, not a social exchange. Three prohibitions, each absolute:

- **No opener before the substance.** The first word is the change. Never "Fixed in `<hash>`", "Confirmed", "Good catch", "Good point", "Right", "Agreed", "Done", "Yes", or any variant of them. The verdict is implicit in the fact that a fix landed, and GitHub's UI already shows the diff.
- **No commit hash in the prose, anywhere in the reply.** Not as an opener, not as a trailing "Fixed in `<hash>`." line. A reviewer reads the code for context, and the hash carries none. GitHub already links the commits on the thread. Name a symbol, a file, or a behaviour instead.
- **No softening before a disagreement.** State the reasoning. Skip "you're right, but", "fair point, however", "in principle yes, though".

Wrong:

> Good catch. `on_connect` now returns early when the broker refuses. Fixed in `6b913af`.

Right:

> `on_connect` now returns early when `reason_code.is_failure`, skipping both `subscribe()` calls and `board.mark_connected()`. Added coverage for the refusal and success paths in `test_session.py`.

Post replies only after the user confirms the wording. Use the reply template in [references/github-api.md](references/github-api.md) and take care to pass the comment `databaseId`, not the thread node id.

**Do NOT resolve any thread until the user explicitly confirms (GATE 3).** Resolving is a separate, deliberate action; never bundle it with posting the reply. The reply says "here's what I did"; resolving says "this is settled", and only the user gets to make that second call.

If the user wants reviewers re-requested after the push, use the re-request template in [references/github-api.md](references/github-api.md).

## Wrap-up

End with a short status summary so the user can see where every thread landed: resolved, replied-but-not-resolved, declined, and deferred.

## Notes

- Don't compress multiple reviewers' distinct concerns into one reply just because they share a topic; reply on each thread.
