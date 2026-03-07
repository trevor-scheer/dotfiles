# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

Personal dotfiles repo managing development environment configs across macOS, Linux, and cloud dev environments (GitHub Codespaces / Gitpod). All scripts are idempotent.

## Setup

```bash
./install.sh
```

This detects the OS/environment, symlinks config files to `$HOME`, and installs packages via Homebrew. There are no tests or build system.

## Architecture

**`install.sh`** is the entry point. It sources platform-specific scripts from `scripts/`:
- `setup-common.sh` — always runs: creates symlinks, installs Zsh/Volta/Homebrew, runs `brew bundle`
- `setup-macos.sh` — installs Xcode CLI tools
- `setup-linux.sh` / `setup-codespaces.sh` — minimal platform stubs (Codespaces or Gitpod)

**Symlink targets** (created by `setup-common.sh`):
- `~/.gitconfig` ← `config/git/.gitconfig`
- `~/.zshrc` ← `config/shell/.zshrc`
- `~/.zprofile` ← `config/shell/.zprofile`
- `~/.config/ghostty/config` ← `config/ghostty/config`

**Shell config loading order**: `.zprofile` (env vars, Volta/PATH) → `.zshrc` (prompt, sources all files in `config/shell/utilities/`)

**`config/shell/utilities/`** — modular shell extensions sourced by `.zshrc`:
- `general.sh` — navigation aliases, profile edit/reload helpers
- `git.sh` — git aliases and functions (`fixup()`, `ship-it()`)
- `docker.sh` — docker compose aliases, lazydocker
- `npm.sh` — npm completions
- `vanta.sh` — Vanta monorepo workspace helpers

**`config/brew/Brewfile`** — Homebrew packages, conditional on platform (cloud environments get minimal set, macOS gets full casks)

**`bin/vanta-mongodb`** — MongoDB connection script using Tailscale + aws-vault, supports multiple environments

## Claude Settings

`config/claude/settings.json` contains shared permission defaults symlinked into `~/.claude/settings.json`.

**Permissions philosophy:** Very permissive defaults. Claude should freely use all file tools, git/gh CLI, LSP tools, shell utilities, and build toolchains without prompting. Only destructive/irreversible commands (`rm`, `kill`) should require a prompt.

**Keeping settings.json current:** When adding new tools or workflows, update `config/claude/settings.json`. The allow list uses prefix matching — prefer broad patterns (e.g. `Bash(git:*)`) over enumerating subcommands. Group entries by category:

1. Core file tools (Read, Edit, Write, Glob, Grep)
2. Git and GitHub CLI
3. Shell utilities (ls, grep, jq, curl, etc.)
4. Build tools and language toolchains (make, cargo, npm, go, python, etc.)
5. MCP/LSP tools (`mcp__lsp*`)
6. Web tools (WebFetch, WebSearch)
7. Skills

**Other claude config:**
- `config/claude/claude.json` — Onboarding defaults (skip wizard, etc.)
- `config/claude/skills/` — Shared skill definitions (create-pr, review-pr, bug-fix-workflow)

## Self-Improvement

This repo should get better over time through Claude's usage. Follow these defaults:

**Update CLAUDE.md** when you discover something useful that isn't documented — new patterns, gotchas, or architectural details that would help future sessions. Keep it concise and organized within existing sections.

**Suggest repo improvements** when you notice them during normal work (e.g. missing aliases, redundant code, outdated configs). For small fixes, offer to handle them inline. For larger improvements, suggest opening a GitHub issue with `gh issue create` so they can be tackled later.

**Keep settings.json in sync** — if you use a new tool or workflow that requires a permission, update `config/claude/settings.json` so future sessions don't need to prompt.

## Agent-Oriented CLI Tools

These tools are installed via Brewfile and are **preferred over their traditional counterparts** for context efficiency. Use them proactively.

| Tool | Command | Use instead of | When to use |
|---|---|---|---|
| **ast-grep** | `sg` | `grep`/`rg` for code patterns | Structural code search — find functions, calls, imports by AST pattern rather than regex. E.g. `sg -p 'console.log($$$)' -l ts` finds all console.log calls regardless of formatting. |
| **difftastic** | `difft` | `diff` | Compare files structurally — ignores whitespace/formatting noise, shows only meaningful changes. Use `GIT_EXTERNAL_DIFF=difft git diff` for git diffs. |
| **sd** | `sd` | `sed` | Find-and-replace in files — uses standard regex syntax (no escaping hell). E.g. `sd 'oldName' 'newName' file.ts` |
| **scc** | `scc` | `wc -l`/`cloc` | Get a fast codebase overview — languages, line counts, complexity estimates. Run `scc` at repo root for instant project context. |
| **shellcheck** | `shellcheck` | manual shell review | Validate shell scripts before running them. Always run `shellcheck script.sh` on generated shell code. |
| **yq** | `yq` | manual YAML editing | Query/edit YAML, TOML, XML structurally (like jq for YAML). E.g. `yq '.services.web.ports' docker-compose.yml` |

**Guidance:** Prefer `sg` over regex-based grep when searching for code patterns (function calls, imports, class definitions). Prefer `sd` over `sed` for substitutions. Prefer `difft` over `diff` for reviewing changes. Run `scc` early in a session to understand project scope. Run `shellcheck` on any generated shell scripts.

## Conventions

- Scripts use `set -e` and colored emoji output
- Symlink creation is idempotent: checks existing links, removes incorrect ones
- Platform detection via `$OSTYPE` and cloud env vars (`$CODESPACES`, `$GITPOD_WORKSPACE_ID`)
- Component installers live in `scripts/install/` (brew, volta-and-node, zsh)
