# User Preferences

## Subagents

- Use subagents for isolated subtasks to keep main context clean
- One clear responsibility per subagent — scope tightly, report results back
- For cross-cutting work (e.g., embedded + web + infra), prefer parallel subagents over sequential

## Compaction

- When compacting, always preserve: list of modified files, current test status, active todo items, and key architectural decisions made this session
- Summarize what was attempted and what failed, not just final state

## Code Style

- Prefer early returns over deep nesting
- Prefer functional patterns where the language idiom supports it (e.g., Enum pipelines in Elixir, LINQ in C#, list comprehensions in Python)
- When unsure about project conventions, read existing code first — ask if still ambiguous

## Testing

- Testing strategy depends on context — do not default to TDD unless the project's CLAUDE.md says so
- When adding new functionality, propose a testing approach and confirm before writing tests

## Languages & Stack

### Personal / Side Projects

- Primary: Elixir (with OTP), Ruby, Python, Node.js
- Secondary: Java, Javascript/Typescript (frontend / SPA)

### Tooling

- Version manager: `mise` — use it for runtime version switching, not system-level installs
- Shell: `zsh` — always test shell commands in zsh, not bash
- Editor: Visual Studio Code (with Claude Code in terminal mode) + Neovim (`lua` configuration)
- Terminal: Ghostty with `tmux`

## Git

- Prefer rebase over merge for local branches
- Commit messages: imperative mood, concise subject line, focus on "why" not "what"
  - Feature: "Add payment webhook endpoint"
  - Bug fix: "Fix off-by-one error in pagination"
  - Refactor: "Extract authentication logic into middleware"
- Never amend shared branches without asking

## Security

- Proactively flag potential security issues (OWASP top 10, secrets in code, insecure defaults)
- `~/.gitignore_global` already excludes common secret patterns (.env, keys, credentials); when a project has its own sensitive paths beyond that, add them to its `.gitignore` too

## Environment

- macOS (Homebrew) or WSL2 (linuxbrew) — these dotfiles target both
- Docker via Colima on macOS, not Docker Desktop
- 1Password for passwords, secrets, SSH keys, and commit signing

## MCP & Tooling

- For Jira: the `umano-connect` skills own the Atlassian MCP workflow — use them for work Jira. Prefer `acli` only for ad-hoc/personal Jira outside those skills
- Claude Projects follow a pop culture naming convention — respect existing names
