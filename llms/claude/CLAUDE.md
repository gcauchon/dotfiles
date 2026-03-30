# User Preferences

## Task Management

- Use `tasks/todo.md` for tracking progress across compactions (separate from plan mode)
- For non-trivial tasks (3+ steps), write the plan there and confirm before starting
- Track progress: mark items complete as you go, summarize changes at each step
- After corrections: capture the lesson in `tasks/lessons.md` as a rule that prevents recurrence

## Subagents

- Use subagents for isolated subtasks to keep main context clean
- One clear responsibility per subagent — scope tightly, report results back
- For cross-cutting work (e.g., embedded + web + infra), prefer parallel subagents over sequential

## Compaction

- When compacting, always preserve: list of modified files, current test status, active todo items, and key architectural decisions made this session
- Summarize what was attempted and what failed, not just final state

## Code Style

- 2-space indentation across all languages
- Prefer early returns over deep nesting
- Prefer functional patterns where the language idiom supports it (e.g., Enum pipelines in Elixir, LINQ in C#, list comprehensions in Python)
- Always match existing code style and patterns in a project before imposing preferences
- When unsure about project conventions, read existing code first — ask if still ambiguous

## Testing

- Testing strategy depends on context — do not default to TDD unless the project's CLAUDE.md says so
- Always run existing tests after changes and fix what you break
- When adding new functionality, propose a testing approach and confirm before writing tests

## Languages & Stack

### Personal / Side Projects
- Primary: Elixir (with OTP), Ruby, Python, Node.js
- Secondary: Java, Javascript/Typescript (frontend / SPA)

### Work (Umano Medical)
- Backend: .NET Core (C#)
- Frontend: Vue.js with Quasar Framework
- Messaging: MQTT
- Embedded: C/C++ on RTOS, migrating toward Embedded Linux
- Infrastructure: OpenTofu (IaC), Keycloak (identity)

### Tooling
- Version manager: `mise` — use it for runtime version switching, not system-level installs
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
- Never commit files that may contain secrets (.env, credentials, tokens)
- When generating config files, always add sensitive paths to `.gitignore`

## Environment

- macOS with Homebrew
- Docker via Colima, not Docker Desktop
- 1Password for passwords, secrets, SSH keys, and commit signing

## MCP & Tooling

- For Jira: prefer Atlassian CLI (`acli`) over MCP when available
- Claude Projects follow a pop culture naming convention — respect existing names
