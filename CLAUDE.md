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
- `setup-common.sh` — always runs: installs Zsh/Volta/Homebrew, runs `brew bundle`, uses GNU Stow for symlinks
- `setup-macos.sh` — installs Xcode CLI tools
- `setup-linux.sh` / `setup-codespaces.sh` — minimal platform stubs (Codespaces or Gitpod)

**Symlink targets** (managed by GNU Stow, packages in `stow/`):
- `stow/git/` → `~/.gitconfig`
- `stow/shell/` → `~/.zshrc`, `~/.zprofile`
- `stow/ghostty/` → `~/.config/ghostty/config`
- `stow/tmux/` → `~/.config/tmux/tmux.conf`
- `stow/nvim/` → `~/.config/nvim/init.lua`
- `stow/claude/` → `~/.claude/settings.json`, `~/.claude/CLAUDE.md`, `~/.claude/skills/`

**Shell config loading order**: `.zprofile` (env vars, Volta/PATH) → `.zshrc` (prompt, sources all files in `config/shell/utilities/`)

**`config/shell/utilities/`** — modular shell extensions sourced by `.zshrc`:
- `general.sh` — navigation aliases, profile edit/reload helpers
- `git.sh` — git aliases and functions (`fixup()`)
- `docker.sh` — docker compose aliases, lazydocker
- `npm.sh` — npm completions
- `vanta.sh` — Vanta monorepo workspace helpers

**`config/brew/Brewfile`** — Homebrew packages, conditional on platform (cloud environments get minimal set, macOS gets full casks)

**`bin/vanta-mongodb`** — MongoDB connection script using Tailscale + aws-vault, supports multiple environments

## Claude Settings

`stow/claude/.claude/settings.json` contains shared permission defaults symlinked into `~/.claude/settings.json` via GNU Stow.

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
- `stow/claude/.claude/CLAUDE.md` — Shared global preferences symlinked to `~/.claude/CLAUDE.md` (agent tool preferences, etc.)
- `config/claude/claude.json` — Onboarding defaults (skip wizard, etc.)
- `stow/claude/.claude/skills/` — Shared skill definitions (pr, review-pr, bug-fix-workflow)
- `stow/claude/.claude/skills/pr/PULL_REQUEST_TEMPLATE.md` — Default PR template used when a repo has no `.github/PULL_REQUEST_TEMPLATE.md`

## Self-Improvement

This repo should get better over time through Claude's usage. Follow these defaults:

**Update CLAUDE.md** when you discover something useful that isn't documented — new patterns, gotchas, or architectural details that would help future sessions. Keep it concise and organized within existing sections.

**Suggest repo improvements** when you notice them during normal work (e.g. missing aliases, redundant code, outdated configs). For small fixes, offer to handle them inline. For larger improvements, suggest opening a GitHub issue with `gh issue create` so they can be tackled later.

**Keep settings.json in sync** — if you use a new tool or workflow that requires a permission, update `config/claude/settings.json` so future sessions don't need to prompt.

## Conventions

- Scripts use `set -e` and colored emoji output
- Symlinks managed by GNU Stow (`stow/` packages mirror `$HOME` structure)
- Platform detection via `$OSTYPE` and cloud env vars (`$IS_ON_ONA`, `$CODESPACES`)
- Component installers live in `scripts/install/` (brew, volta-and-node, zsh)
