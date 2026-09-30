# GitHub API reference for PR review triage

Loaded at Step 5 and when posting or resolving. Every call is a single `gh` invocation, never piped or chained.

## Two identifiers, two endpoints

| Identifier | Looks like | Used by |
| --- | --- | --- |
| Thread node id (`reviewThreads.nodes[].id`) | `PRRT_kwDO...` | `resolveReviewThread` GraphQL mutation |
| Comment `databaseId` (`comments.nodes[].databaseId`) | numeric | REST reply endpoint |

Reply to the **first** comment of a thread (`comments.nodes[0].databaseId`). Passing the thread node id to the REST endpoint, or a comment id to the mutation, fails with a not-found error.

## Fetch unresolved threads

Query lives in `queries/review-threads.graphql`. Owner and repo come from `gh repo view --json owner,name`.

```zsh
gh api graphql -F owner=<owner> -F repo=<repo> -F number=<n> -F query=@${CLAUDE_SKILL_DIR}/queries/review-threads.graphql
```

Filter client-side to `isResolved == false`. If `reviewThreads.pageInfo.hasNextPage` or any thread's `comments.pageInfo.hasNextPage` is true, say so in the report. Never present a truncated list as complete.

## Post a reply (after the user confirms the wording)

```zsh
gh api repos/<owner>/<repo>/pulls/<n>/comments/<comment-databaseId>/replies -f body='<reply text>'
```

## Resolve a thread (only after GATE 3)

```zsh
gh api graphql -f query='mutation($id: ID!) { resolveReviewThread(input: {threadId: $id}) { thread { isResolved } } }' -F id=<thread-node-id>
```

Confirm `isResolved` is `true` in the response.

## Re-request review (only when the user asks, after the push)

```zsh
gh pr edit <n> --add-reviewer <login>
```

For Copilot, check the reviewer login the PR already shows in `gh pr view <n> --json reviewRequests,reviews` before using it. The handle differs across GitHub deployments.
