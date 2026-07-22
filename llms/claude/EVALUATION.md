# Evaluation — Claude Code configuration in `llms/claude/`

Assessment of the global Claude Code setup (symlinked into `~/.claude/` by `04-symlinks.sh`) against Anthropic's official documentation, published guidance, and community consensus as of 2026-07. Assessment only — no changes applied. Findings are ordered per file, each with severity. Sources are cited inline; claims labeled _community_ are consensus/issue-tracker evidence rather than official documentation.

## Executive summary

**What's strong.** The overall architecture is sound and ahead of most setups: settings are schema-validated and version-controlled, the `~/.claude/rules/` mechanism is used exactly as documented, `CLAUDE.md` is under the official 200-line target, the permission model uses all three tiers (allow/deny/ask) with sensible intent boundaries (`git push` on ask, secrets on ask/deny), `disableBypassPermissionsMode` is correctly nested under `permissions`, the PreToolUse protected-file blocker uses exit-code-2 semantics correctly, and credentials handling on Linux (0600 `.credentials.json`, never synced) matches guidance.

**Top problems.**

1. The entire custom usage-tracking pipeline (`fetch-usage.sh` + three hook invocations + cache-file plumbing in `status-line.sh`) is obsolete: the undocumented `oauth/usage` endpoint has been aggressively rate-limited (429) since ~March 2026 with the tracking issue closed as not-planned, and Claude Code now delivers `rate_limits.five_hour/seven_day.{used_percentage,resets_at}` natively in the statusline stdin JSON. (High)
2. The PostToolUse shellcheck hook is a no-op as written: for PostToolUse, stdout with exit 0 goes to the debug log only and never reaches Claude. The findings it prints are invisible. (High)
3. The `Bash(curl * | sh*)` / `Bash(wget * | sh*)` deny rules almost certainly never match anything: Claude Code splits compound commands at `|` before rule matching, so no single rule containing a literal pipe can match. False sense of security. (High)
4. The deny list is treated as a security boundary, but official docs explicitly warn Bash argument patterns are fragile and community issues (#4956, #38119) document trivial bypasses. The documented hardening layer — `sandbox.enabled` (bubblewrap works on WSL2) — is unused. (Medium)
5. `CLAUDE.md` states "macOS with Homebrew" while the config actively runs on WSL2/linuxbrew — a permanent contradiction Claude sees in every session on this machine. Several other sections restate built-in behavior and would be trimmed by `/doctor`'s philosophy. (Medium)

---

## 1. `settings.json`

### 1.1 Permission rules

**`Bash(curl * | sh*)` and `Bash(wget * | sh*)` never match — High.** Official docs state compound commands are split at `&&`, `||`, `;`, `|`, `|&`, `&`, and newlines, and "a rule must match each subcommand independently" (https://code.claude.com/docs/en/permissions). `curl … | sh` is decomposed into `curl …` and `sh …` before matching, so a pattern containing a literal `|` has nothing to match against. The documented alternatives: deny network tools in Bash outright and funnel web access through `WebFetch(domain:…)` allow rules (already partially done), or a PreToolUse hook validating Bash commands. This is inferred from documented per-subcommand splitting; docs don't explicitly address literal pipes in patterns.

**Deny list is advisory, not enforcement — Medium.** Docs warn verbatim that "Bash permission patterns that try to constrain command arguments are fragile" and list bypasses: variable expansion (`URL=… && curl $URL`), protocol changes, flag reordering (https://code.claude.com/docs/en/permissions). Community issues confirm chaining and multi-line bypasses of deny rules (_community_: anthropics/claude-code#4956, #38119). The `rm -rf /*` / `rm -rf ~*` rules illustrate the problem: `rm -rf ./`, `rm -rf $HOME`, `rm -fr /` all slip past. Official posture: deny rules block attempts; the sandbox enforces the boundary at the OS level "even if a prompt injection bypasses Claude's decision-making" (https://code.claude.com/docs/en/sandboxing). Sandboxing supports WSL2 (bubblewrap + socat) and macOS (Seatbelt), and `sandbox.credentials` covers what `Read` deny rules cannot: subprocess reads of key material (a Python script opening `~/.ssh/id_ed25519` bypasses `Read(**/*.key)` entirely, per the same docs page).

**`Read`/`Edit` path rule scoping — Medium.** These rules follow gitignore semantics relative to the current directory: `Read(**/.env)` blocks `.env` at or under the project, but not in a parent directory or elsewhere on the filesystem. For user-level settings meant to apply everywhere, the documented forms are `//**/…` (filesystem-absolute) or `~/…` (https://code.claude.com/docs/en/permissions). Also note `Read(**/.env)` and `Read(.env)` are equivalent — the `**/` is redundant.

**Pattern style inconsistencies — Low.** Three styles coexist: `Bash(git status*)` (no space — also matches hypothetical `git statusfoo`), `Bash(git add *)` (space-star — word boundary, matches bare `git add` too), and no use of the equivalent `:*` suffix form. All are valid per docs; picking one convention (docs examples favor trailing `*` or `:*`) would make the list auditable. `Bash(tig*)` matching `tigfoo` is harmless in practice.

### 1.2 Hooks

**PostToolUse shellcheck hook output never reaches Claude — High.** Docs: "For most events, stdout is written to the debug log but not shown in the transcript. The exceptions are UserPromptSubmit, UserPromptExpansion, and SessionStart" (https://code.claude.com/docs/en/hooks). The hook prints shellcheck findings to stdout and exits 0, so they are silently discarded. To make Claude see and fix findings, the documented mechanisms are: exit 2 with the findings on stderr, or exit 0 with JSON (`decision: "block"` + reason, or `hookSpecificOutput.additionalContext`). As written, the hook only costs latency.

**Three `fetch-usage.sh` invocations are dead weight — High.** See §3.1. SessionStart, UserPromptSubmit, and Stop all fire a background script polling a dead endpoint. All three hook entries can go away along with the script.

**Backgrounding with `&` is superseded — Low.** Hooks support `async: true` since v2.1.0, which preserves timeout and exit-code semantics that `cmd … &` loses (_community_: shipped Jan 2026, announced by Boris Cherny). Relevant only if any background hooks survive the cleanup above.

**Prompt logging: unbounded and world-readable — Medium.** The UserPromptSubmit logger has produced a 725 KB, 9,400-line `~/.claude/prompts.log` with mode 0644 containing every prompt ever typed — including anything pasted (credentials, work-confidential content). The bash-commands log gets a 10,000-line trim; prompts.log has no rotation and no restrictive mode. At minimum it deserves 0600 and the same trim treatment; better, question whether it earns its keep at all — `~/.claude/history.jsonl` and session transcripts already exist.

**Protected-file blocker — sound, one behavior to confirm — Low.** Exit-2-with-stderr semantics are correct per docs. The `\.lock$` pattern blocks edits to `Cargo.lock`, `Gemfile.lock`, `yarn.lock`, etc. — usually those should change via the package manager in Bash (unaffected by the hook), so this is likely intentional, but note `mise.lock`/`flake.lock` style files are also caught.

**Unused officially-showcased hook opportunities — Low.** The official hooks guide demos: desktop notification on Notification events, auto-format after Edit/Write (the repo itself uses dprint — commit `c5bdf6a` — but no formatting hook exists), context re-injection after compaction (which would make the CLAUDE.md "Compaction" section enforceable instead of advisory), and prompt/agent-based Stop hooks (https://code.claude.com/docs/en/hooks-guide).

### 1.3 Settings keys

- `noBanner` — not present in the settings reference; unrecognized or removed. (Low)
- `effortLevel: "high"` — valid, but `high` is already the default on Fable 5; the key currently changes nothing. (Low)
- `permissions.defaultMode: "plan"` — valid, but official guidance frames plan mode as situational: "If you could describe the diff in one sentence, skip the plan" (https://code.claude.com/docs/en/best-practices). Docs position `defaultMode: plan` as a per-project choice. The newer `auto` mode (classifier-reviewed permissions) is the endorsed low-friction path for reducing prompts — note `auto` is ignored in project/local settings, so user settings is the right scope if adopted. Keeping plan-by-default is defensible for a deliberate workflow; it's flagged as a conscious trade-off, not an error. (Info)
- `includeGitInstructions: false` — valid; be aware it also removes the git-status snapshot from the system prompt, not just commit/PR workflow instructions. The Git section of CLAUDE.md partially compensates. (Info)
- Everything else audited (`cleanupPeriodDays`, `env`, `model: "fable"`, `autoUpdatesChannel`, `plansDirectory`, `tui`, `autoMemoryEnabled`, `showTurnDuration`, `enabledPlugins`, `extraKnownMarketplaces`, `statusLine`, `hooks`) is documented and correctly placed, including `disableBypassPermissionsMode` inside `permissions`.

## 2. `CLAUDE.md` (user-level)

At ~100 lines it respects the official "target under 200 lines" rule (https://code.claude.com/docs/en/memory), but the combined always-loaded budget is CLAUDE.md + unscoped `rules/*.md` (~130 lines) plus plugin instructions. Community research consistently shows adherence degradation is uniform — every rule added dilutes compliance with all rules (_community_: humanlayer.dev "Writing a good CLAUDE.md", Nov 2025) — so the pruning test from official docs applies line by line: "Would removing this cause Claude to make mistakes? If not, cut it."

**Stale platform claim — Medium.** "Environment: macOS with Homebrew" is false on this machine (WSL2, linuxbrew). Claude sees the contradiction every session — the harness reports `linux` while the memory file asserts macOS. Docs warn that contradictory rules make Claude "pick one arbitrarily". Since the dotfiles target both platforms, the section should either state both or be machine-scoped (e.g. a machine-local, gitignored mechanism — `CLAUDE.local.md` exists for projects; for user scope, an @import of a gitignored file is the documented pattern, https://code.claude.com/docs/en/memory).

**Task Management section restates built-in behavior — Medium.** The harness already manages todo tracking natively (and its tooling has evolved past the TodoWrite phrasing the section hardcodes). Official exclusion guidance: "If Claude already does something correctly without the instruction, delete it or convert it to a hook"; `/doctor` trims exactly this category. The one non-derivable line is the `tasks/lessons.md` rule — see next.

**`tasks/lessons.md` lessons loop — Medium.** A recognized community pattern, but not consensus, and it carries two documented failure modes: unpruned lessons files recreate the instruction-bloat problem (_community_: consolidate at ~100 bullets or weekly), and as a user-level rule it directs Claude to create `tasks/lessons.md` inside every repo it touches, including work repos where that file doesn't belong. If kept, it fits Anthropic's newer framing better as a skill ("when a section of CLAUDE.md stopped being a fact and became a procedure, extract it to a skill", https://claude.com/blog/steering-claude-code-skills-hooks-rules-subagents-and-more).

**Compaction section — keep.** This is an officially endorsed pattern verbatim ("Customize compaction behavior in CLAUDE.md with instructions like 'When compacting, always preserve…'", https://code.claude.com/docs/en/best-practices).

**Languages & Stack section — Low.** Per-project stacks are "anything Claude can figure out by reading code" (official exclusion list) — each work repo's own CLAUDE.md is the documented home for its stack. The genuinely user-level facts here are the tooling lines (mise, zsh, editor, terminal). The work-stack subsection loads into every personal-project session where it's noise.

**Code Style / Testing / Git / Security sections — mostly keep.** Concrete and verifiable, matching the official specificity guidance. Minor trims: "Always match existing code style" and "run existing tests after changes" are close to default behavior; the git commit-message examples are the kind of thing worth keeping (non-derivable convention). "Signed commits via 1Password" is derivable from `.gitconfig`.

**Subagents section — Low.** Largely restates default harness behavior; the cross-cutting-parallelism line is the only non-obvious preference.

## 3. `scripts/`

### 3.1 `fetch-usage.sh` — obsolete — High

Two independent reasons to delete it:

- The undocumented `api.anthropic.com/oauth/usage` endpoint has returned persistent 429s since early 2026; the GitHub issue tracking it was closed as not-planned, which reads as intentional lockdown of third-party polling (_community_: anthropics/claude-code#30930, #31021, #31637).
- The data is now first-party: statusline stdin JSON includes `rate_limits.five_hour.used_percentage`, `rate_limits.seven_day.used_percentage`, and `resets_at` for subscribers, documented at https://code.claude.com/docs/en/statusline, plus the built-in `/usage` command. Zero API calls, zero credential reads, zero cache files.

Deleting it also removes the script's direct read of OAuth tokens from Keychain/`.credentials.json` (works, but is surface area that no longer buys anything) and three hook invocations.

### 3.2 `status-line.sh` — solid design, needs a data-source swap — Medium

The jq-single-pass parsing, 5s git cache, and ANSI assembly are good practice, and all consumed stdin fields are documented. Changes indicated:

- Read `rate_limits.*` from stdin instead of `/tmp/.claude_usage_cache`; drop `compute_delta`'s ISO-parsing (resets_at still needs delta math, but no cache file, no fallback-fetch branch).
- **macOS portability bug**: `stat -c %Y` is GNU-only; on macOS (the repo's stated bootstrap target) it fails, `cache_age` becomes huge, and the git cache never hits — git status/rev-parse run on every render. BSD `stat -f %m` needs the same uname branch `compute_delta` already has. Ironically the script currently only works as intended on the platform the repo claims not to target.
- Predictable world-readable `/tmp` cache paths are a theoretical multi-user concern only; contents (branch name, dirty count) are non-sensitive. (Low)

## 4. `rules/conversation-style.md`

The mechanism is used correctly — user-level `~/.claude/rules/` is fully documented, and unscoped rules load at launch with CLAUDE.md priority (https://code.claude.com/docs/en/memory). Two challenges:

- **Wrong layer for voice/format rules — Medium.** Anthropic's split: output styles "change how Claude responds… They modify the system prompt to set role, tone, and output format. Use one when you keep re-prompting for the same voice or format every turn"; CLAUDE.md/rules are for conventions and facts, delivered as a weaker user-message-level signal (https://code.claude.com/docs/en/output-styles). The `<style>`, `<tone>`, and most of `<output>` sections are exactly the output-style use case and would get stronger, system-prompt-level adherence as a custom style in `~/.claude/output-styles/` (with `keep-coding-instructions: true`). Caveat: output styles don't affect subagents; the language rule below arguably should, so a hybrid split is reasonable.
- **The `<language>` section is the highest-value content in the whole config** — genuinely user-specific, non-derivable, and impossible for Claude to infer. Keep it always-loaded wherever it lands.
- Since user-level rules load unscoped here, this file counts against the same instruction budget as CLAUDE.md — one more reason to move the style bulk to an output style. Note path-scoped (`paths:` frontmatter) user-level rules have had loading bugs (_community_: #21858, #22170) — unscoped, as used here, is the reliable mode.

## 5. Gaps — mechanisms best-practice setups use that this one doesn't

- **No sandbox config.** The single biggest hardening gap given the deny-list findings; supported on both target platforms (Seatbelt / bubblewrap). Official recommendation is deny rules + sandbox for defense-in-depth. `sandbox.credentials` would also close the subprocess-secret-read hole.
- **No user-level skills (`~/.claude/skills/`).** Anthropic's current framing: procedures move out of always-loaded memory into on-demand skills. Candidates already visible in this config: the lessons-learned workflow, the testing-approach-proposal workflow. (The repo does have a project-level skill, so the pattern is familiar.)
- **No user-level subagents (`~/.claude/agents/`).** The CLAUDE.md Subagents section describes a philosophy but defines no reusable workers; docs recommend defining one "when you keep spawning the same kind of worker with the same instructions" (https://code.claude.com/docs/en/sub-agents).
- **No output styles** — see §4.
- **No machine-local settings split.** macOS/WSL differences are handled inside scripts via `uname` branching; `settings.local.json` (or user-scope @imports of gitignored files) is the documented mechanism for per-machine divergence, and would let the Environment section of CLAUDE.md be truthful per machine.
- **No auto-format hook** despite dprint being the repo's formatter.
- **Path-scoped rules unused.** Per-language conventions (Elixir/C#/Vue idioms in CLAUDE.md's Code Style) could load only when matching files are touched — the token-efficient pattern official docs recommend — though user-level `paths:` scoping has open reliability issues (see §4); project-level rules don't have that caveat.

## 6. Prioritized recommendations

1. **High** — Delete `fetch-usage.sh`, its three hook invocations, and the cache plumbing; switch `status-line.sh` to stdin `rate_limits.*`. (§3.1, §3.2)
2. **High** — Fix the shellcheck hook so findings actually reach Claude (stderr + exit 2, or JSON `additionalContext`), or remove it. (§1.2)
3. **High** — Replace `Bash(curl * | sh*)` / `Bash(wget * | sh*)` with rules that can match (per-subcommand) or a PreToolUse validation hook. (§1.1)
4. **Medium** — Enable and configure `sandbox` (filesystem, network, credentials) as the real enforcement layer; keep the deny list as the first-attempt blocker. (§1.1, §5)
5. **Medium** — Fix the prompts.log privacy/rotation problem, or drop the logger. (§1.2)
6. **Medium** — CLAUDE.md pass: fix the macOS/WSL contradiction via a machine-local mechanism, drop the Task Management restatement, move the lessons workflow to a skill or add consolidation discipline, demote the work-stack subsection to project files. (§2)
7. **Medium** — Move voice/format rules from `rules/conversation-style.md` into a custom output style; keep the language rule always-loaded. (§4)
8. **Low** — `status-line.sh` macOS `stat` fix; normalize permission-pattern style; remove `noBanner` and (optionally) the redundant `effortLevel`; scope `Read` secret-deny rules with `//` or `~/` for global coverage; consider auto-format and Notification hooks; revisit `defaultMode: plan` vs `auto` as a deliberate choice.

## Sources

Official: https://code.claude.com/docs/en/permissions · /docs/en/hooks · /docs/en/hooks-guide · /docs/en/memory · /docs/en/statusline · /docs/en/settings · /docs/en/model-config · /docs/en/sandboxing · /docs/en/best-practices · /docs/en/skills · /docs/en/sub-agents · /docs/en/output-styles · /docs/en/permission-modes · https://claude.com/blog/steering-claude-code-skills-hooks-rules-subagents-and-more · https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents

Community: anthropics/claude-code issues #4956, #38119, #17619, #20254, #30930, #31021, #31637, #21858, #22170, #10039 · humanlayer.dev/blog/writing-a-good-claude-md · disler/claude-code-hooks-mastery · hesreallyhim/awesome-claude-code
