# User Preferences

## Task Management

Multi-step work has two layers; they are not interchangeable.

- **Upfront plan** — plan mode's plan file, under `.claude/plans`. Write the full plan there, one item per step, before changing anything.
- **In-flight progress** — the harness's built-in todo/task tool. Mark each item completed immediately after finishing it, never batch at the end. If the plan changes mid-task, update the list rather than leaving stale items.

Never create a markdown to-do file outside `.claude/plans`. If no todo/task tool is exposed, track progress inline in your replies instead — mention it once in passing, and do not treat it as a broken setting.

## Subagents

- Scope each subagent to one clear responsibility
- For cross-cutting work (e.g., embedded + web + infra), prefer parallel subagents over sequential

## Compaction

- When compacting, always preserve: list of modified files, current test status, active tasks, and key architectural decisions made this session
- Summarize what was attempted and what failed, not just final state

## Code Style

- Prefer early returns over deep nesting
- Prefer functional patterns where the language idiom supports it (e.g., Enum pipelines in `Elixir`, LINQ in `C#`, list comprehensions in `Python`)
- If project conventions are ambiguous after reading existing code, ask

## CLI Invocations

- Default to one CLI invocation per shell call rather than wrapping a loop or shell function around several — it's easier to review and keeps a continuous stream of thought during pairing.
- Exception: a script that batches several calls to the same mechanical, repetitive operation (e.g. a `gh api` mutation applied to each of N PR review threads) is fine in one call — spamming N near-identical approvals adds noise, not review value.
- When unsure which case applies, ask before choosing.

## Testing

- Testing strategy depends on context — do not default to TDD unless the project's CLAUDE.md says so
- When adding new functionality, propose a testing approach and confirm before writing tests

## Languages & Stack

When the language or framework is open (greenfield, scripts, examples, prototypes) and no existing code dictates otherwise, propose known tech BEFORE suggesting anything else:

- Personal projects: `Elixir` (BEAM + OTP) for web projects; `Python` or `Node.js` for JS-native tooling; `TypeScript` for SPA frontends.
- Umano Medical work: `.NET Core` (C#) backend, `Vue.js` + `Quasar` frontend, `Python` for proof of concept.

Per-domain work stack detail (messaging, embedded, IaC, identity) belongs in that repo's own `CLAUDE.md`, not here.

### Tooling

- Version manager: `mise` — use it for runtime version switching, not system-level installs; in real project codebases, rely on it to auto-load environment variables via `.env` (12-Factor)
- Shell: `zsh` — always test shell commands in zsh, not bash
- Editor: Visual Studio Code (with Claude Code in terminal mode) + Neovim (`lua` configuration)
- Terminal: Ghostty with `tmux`

## Git

- Signed commits via SSH agent (1Password on macOS, keychain-loaded keys on WSL2)
- Prefer rebase over merge for local branches
- Commit messages: imperative mood, concise subject line, focus on "why" not "what"
  - Feature: "Add payment webhook endpoint"
  - Bug fix: "Fix off-by-one error in pagination"
  - Refactor: "Extract authentication logic into middleware"
- Never amend shared branches without asking

## Security

- Proactively flag potential security issues (OWASP top 10, secrets in code, insecure defaults)
- `~/.gitignore_global` already excludes common secret patterns (.env, keys, credentials)
- When a project has its own sensitive paths beyond that, propose adding them to its `.gitignore`

## Environment

- macOS (`Homebrew`) or Debian over WSL2 (`linuxbrew`) — these dotfiles target both
- Docker via Colima on macOS, not Docker Desktop; native `docker` on Debian
- 1Password for passwords and secrets; SSH keys and commit signing via 1Password on macOS, keychain on WSL2

## MCP & Tooling

- For work Jira, read the `umano-medical:jira` skill before any Atlassian tool call — never bypass it with `acli`
- Claude Projects follow a pop culture naming convention — respect existing names
