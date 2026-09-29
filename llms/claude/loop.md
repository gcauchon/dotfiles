Tend to the pull request for the current branch.

1. Run `gh pr checks` and list the unresolved review threads. If there is no PR for this branch, say so in one line and stop.
2. If CI is red, pull the failing job log, diagnose the cause, and prepare a minimal fix in the working tree. Do not commit or push.
3. If new review comments arrived, draft a reply and a fix for each, grouped by topic. Do not post replies, resolve threads, or commit.
4. Merging, pushing, committing, and resolving threads only proceed when this transcript already authorized that exact action. Otherwise stop and ask.
5. If everything is green and quiet, report that in one line and nothing else.

Never start work outside the scope of this PR.
