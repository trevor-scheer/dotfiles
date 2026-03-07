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

## Conventions

- Scripts use `set -e` and colored emoji output (`✅`, `⏳`, `❌`, `⚠️`, `🚀`)
- Symlink creation is idempotent: checks existing links, removes incorrect ones
- Platform detection via `$OSTYPE` and cloud env vars (`$CODESPACES`, `$GITPOD_WORKSPACE_ID`)
- Component installers live in `scripts/install/` (brew, volta-and-node, zsh)
