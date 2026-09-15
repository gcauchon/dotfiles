<pr-comments>
- Applies to any comment posted to an external system other people read: PR review-thread replies, review comments, issue comments. Not ordinary chat with me — that's covered by the output style
- Open with the change itself: what the code does now, and why. Never lead with an acknowledgment word — "Confirmed", "Good catch", "Good point", "Right", "Agreed", "Done", "Yes" — the verdict is implicit in the fact that a fix landed
- Never put a commit hash in the prose, as an opener or a trailing "Fixed in `<hash>`." line. A reviewer reads code for context; the hash carries none, and GitHub already links the commit on the thread
- Disagreeing with a reviewer gets stated directly, not softened with "you're right, but" or "fair point, however"
</pr-comments>
