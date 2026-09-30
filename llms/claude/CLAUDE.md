# User Preferences

## File Output

- Default to Markdown for written content and CSV for tabular data. They diff, version, and render inline. Create Office documents (docx, pptx, xlsx) only when explicitly asked, such as Umano sprint reviews through the `umano-pptx` skills.
- Don't hard-wrap Markdown prose at a fixed column. Write full-length lines and rely on the editor's soft wrap.

## Task Management

For any multi-step task, track progress with the built-in task tools (`TaskCreate`, `TaskUpdate`, `TaskList`). Don't create a Markdown todo file.

- Write the full plan upfront, one item per step. Mark each item completed as soon as it's done, never in a batch at the end.
- If the plan changes mid-task, update the list instead of leaving stale items.

## Subagents

- Scope each subagent to one clear responsibility.
- For cross-cutting work (e.g., embedded + web + infra), run subagents in parallel. Run them sequentially when they would edit the same files.

## Compaction

- When compacting, always preserve: modified files, current test status, active tasks, and key architectural decisions made this session.
- Summarize what was attempted and what failed, not just the final state.

## Code Style

- Prefer early returns over deep nesting.
- Prefer functional patterns where the language idiom supports it (e.g., Enum pipelines in `Elixir`, LINQ in `C#`, list comprehensions in `Python`).
- If project conventions are still ambiguous after reading existing code, ask.

## CLI Invocations

- Default to one CLI invocation per shell call instead of wrapping several in a loop or shell function. Single calls are easier to review and keep a continuous stream of thought during pairing.
- Exception: a script that applies the same mechanical operation N times (e.g., a `gh api` mutation on each of N PR review threads) is fine in one call. N near-identical approvals add noise, not review value.
- When unsure which case applies, ask.
- `gh` only runs outside the sandbox when it is the whole command. Never pipe it or chain it with `|`, `&&`, or `;`. Redirects like `2>&1` are fine. A sandboxed `gh` fails on `~/.config/gh` and on TLS, and retrying it unsandboxed is not the fix.

## Loops

- Start a recurring workflow explicitly with `/loop [interval] /<skill>`. Don't put task-specific behavior in `loop.md`, since a bare `/loop` would then apply it in every repo.
- The skill owns the per-tick behavior in a `## Watch mode` section: what one tick checks, what counts as "nothing new" (report it in one line), and when to end the loop.
- A tick is read-only plus drafting. Approval gates still apply, and commit, push, post, resolve, and merge need explicit approval in the transcript, never a scheduled run.
- Dynamic `/loop /<skill>` fits waits on external state (CI, reviews). A fixed interval fits steady polling. Use `/schedule` routines or desktop tasks for unattended work that must outlive the session (loops are session-scoped and expire after 7 days).

## Testing

- Don't default to TDD. Follow the project's CLAUDE.md. If it says nothing, propose a testing approach and confirm before writing tests.

## Languages & Stack

When the language or framework is open (greenfield, scripts, examples, prototypes) and no existing code dictates otherwise, propose these first:

- Personal projects: `Elixir` (BEAM + OTP) for web, `TypeScript` for SPA frontends, `Python` for scripts and tooling, `Node.js` when the tooling is JS-native.
- Umano Medical work: `.NET` (C#) backend, `Vue.js` + `Quasar` frontend, `Python` for proofs of concept.

Per-domain work stack detail (messaging, embedded, IaC, identity) belongs in that repo's CLAUDE.md.

### Tooling

- Runtimes: `mise` for version switching, never system-level installs. In project repos, rely on `mise` to load environment variables from `.env` (12-Factor).
- Shell: `zsh`. Write and test shell commands for zsh, not bash.
- Editor: VS Code with Claude Code in the terminal, plus Neovim (Lua config).
- Terminal: Ghostty with `tmux`.

## Git

- Commits are signed through the 1Password SSH agent. If signing fails, stop and tell me. Never bypass it.
- Rebase local branches instead of merging.
- Commit subject: imperative mood, concise, states what changed. Commit body: explains why, when the subject doesn't make it obvious.
  - "Add payment webhook endpoint"
  - "Fix off-by-one error in pagination"
  - "Extract authentication logic into middleware"
- Never amend or force-push shared branches without asking.

## Security

- Proactively flag potential security issues (OWASP Top 10, secrets in code, insecure defaults).
- `~/.gitignore_global` already excludes common secret patterns (.env, keys, credentials).
- When a project has sensitive paths beyond those, propose adding them to its `.gitignore`.

## Environment

- macOS with Homebrew.
- Docker runs on Colima, not Docker Desktop.
- 1Password holds passwords, secrets, SSH keys, and the commit signing key.

## Jira

- For work Jira, read the `umano-medical:jira` skill before any Atlassian tool call.
