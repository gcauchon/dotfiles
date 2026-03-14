# User Preferences

## Communication

- Match the language I write in (English or French)
- Explain your reasoning briefly — include rationale for decisions and trade-offs
- Be concise, no filler

## Code Style

- 2-space indentation across all languages
- Prefer early returns over deep nesting
- Prefer functional patterns where idiomatic
- Always match existing code style and patterns in a project before imposing preferences

## Languages & Stack

- Primary: `Elixir` (with `OTP`), `Ruby`, `Python`, `Node.js`
- Secondary: `Java`, `.Net Core`, `Javascript`/`Typescript` (frontend / _Single Page Application_)
- DevOps: _Infrastructure as Code_ using `OpenTofu`
- Version manager: `mise`
- Shell: `zsh` — **always test shell commands in zsh, not bash**
- Editor: Neovim (`lua` configuration)
- Terminal: Ghostty with `tmux`

## Git

- Signed commits via 1Password SSH agent
- Prefer rebase over merge for local branches
- Descriptive commit messages focused on "why" not "what"

## Security

- Proactively flag potential security issues (OWASP top 10, secrets in code, insecure defaults)
- Never commit files that may contain secrets (.env, credentials, tokens)

## Environment

- macOS with Homebrew
- Docker via `Colima` not _Docker Desktop_
- 1Password for passwords, secrets, SSH keys and commit signing
