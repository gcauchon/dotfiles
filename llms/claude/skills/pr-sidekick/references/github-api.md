# GitHub API reference for PR review triage

Loaded whenever a step calls the GitHub API: the Step 1 fetch, the Step 5 reply and resolve, and the review re-request. Every call is a single `gh` invocation, never piped or chained.

## Two identifiers, two endpoints

| Identifier                                           | Looks like     | Used by                                |
| ---------------------------------------------------- | -------------- | -------------------------------------- |
| Thread node id (`reviewThreads.nodes[].id`)          | `PRRT_kwDO...` | `resolveReviewThread` GraphQL mutation |
| Comment `databaseId` (`comments.nodes[].databaseId`) | numeric        | REST reply endpoint                    |

Reply to the **first** comment of a thread (`comments.nodes[0].databaseId`). Passing the thread node id to the REST endpoint, or a comment id to the mutation, fails with a not-found error.

## Fetch unresolved threads

Query lives in `queries/review-threads.graphql`. Owner and repo come from `gh repo view --json owner,name`.

```zsh
gh api graphql -F owner=<owner> -F repo=<repo> -F number=<n> -F query=@${CLAUDE_SKILL_DIR}/queries/review-threads.graphql
```

Each thread carries `comments` (the oldest 50, for context) and `lastComment` (the newest one, for who spoke last and watch-mode state). Filter client-side to `isResolved == false`.

The query returns 100 threads per page. While `reviewThreads.pageInfo.hasNextPage` is true, repeat the call with the previous page's `endCursor`, then merge the pages before grouping. Omit `after` on the first call.

```zsh
gh api graphql -F owner=<owner> -F repo=<repo> -F number=<n> -F after=<endCursor> -F query=@${CLAUDE_SKILL_DIR}/queries/review-threads.graphql
```

If a thread's `comments.pageInfo.hasNextPage` is true, its earliest-50 context is incomplete (the verdict still comes from `lastComment`). Say so in the report rather than presenting that thread's history as complete.

## Post a reply (after the user confirms the wording)

Write the confirmed reply verbatim to a file with the Write tool, then let `gh` read the field from that file. Inlining the text in single quotes breaks on apostrophes and lets shell metacharacters run as commands.

Use one absolute path, in the session scratchpad directory, and put that same literal path in both the Write call and the `gh` command. Don't use `$TMPDIR` in the `gh` command: `gh` runs outside the sandbox, where `TMPDIR` can resolve to a different directory than the one the file was written to.

```zsh
gh api repos/<owner>/<repo>/pulls/<n>/comments/<comment-databaseId>/replies -F body=@<absolute-path-to-reply.md>
```

## Resolve a thread (only after GATE 3)

```zsh
gh api graphql -f query='mutation($id: ID!) { resolveReviewThread(input: {threadId: $id}) { thread { isResolved } } }' -F id=<thread-node-id>
```

Confirm `isResolved` is `true` in the response.

## Re-request review (only when the user asks, after the push)

```zsh
gh pr edit <n> --add-reviewer '<login>'
```

Quote the login: bot logins can contain `[bot]`, and zsh treats unquoted brackets as a glob (`no matches found`). For Copilot, check the reviewer login the PR already shows in `gh pr view <n> --json reviewRequests,reviews` before using it. The handle differs across GitHub deployments.
