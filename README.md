# Dotfiles Repository

Personal dotfiles and configuration scripts for setting up my development environment across macOS, Linux, and GitHub Codespaces.

## Structure

- **install.sh**: Main bootstrapping script. Detects OS/environment and applies appropriate configurations. Idempotent — safe to run multiple times.
- **scripts/**: Setup scripts:
  - **setup-common.sh**: Cross-platform setup (Homebrew, common packages)
  - **setup-macos.sh**: macOS-specific setup
  - **setup-linux.sh**: Linux-specific setup
  - **setup-codespaces.sh**: GitHub Codespaces-specific setup
  - **macos-defaults.sh**: macOS system defaults
  - **validate.sh**: Validation script
- **config/**: Configuration files for various tools:
  - **brew/**: Homebrew Brewfile
  - **claude/**: Claude Code settings and skills
  - **git/**: Git configuration
  - **shell/**: Shell configuration (Bash/Zsh)
  - **ssh/**: SSH configuration
  - **vscode/**: VS Code settings
  - **vanta/**: Vanta agent configuration
- **stow/**: Symlinked dotfiles managed via GNU Stow:
  - **claude/**: Claude Code dotfiles
  - **ghostty/**: Ghostty terminal config
  - **git/**: Git dotfiles
  - **nvim/**: Neovim config
  - **shell/**: Shell dotfiles
  - **tmux/**: tmux config
- **modules/**: Self-contained setup modules (e.g., Vanta)

## Usage

```bash
./install.sh
```

Detects your OS and environment, then applies the appropriate configurations.
