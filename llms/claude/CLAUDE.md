# User Preferences

## Task Management

For any multi-step task, track progress with the harness's built-in todo/task tool — do not create a markdown todo file.

- Write the full plan upfront, one item per step; mark completed immediately after each, never batch at the end.
- If the plan changes mid-task, update the list rather than leaving stale items.

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

- Signed commits via 1Password SSH agent
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

- macOS with Homebrew
- Docker via Colima, not Docker Desktop
- 1Password for passwords, secrets, SSH keys, and commit signing

## MCP & Tooling

- For work Jira, read the `umano-medical:jira` skill before any Atlassian tool call — never bypass it with `acli`
- Claude Projects follow a pop culture naming convention — respect existing names
- Claude Projects follow a pop culture naming convention — respect existing names
