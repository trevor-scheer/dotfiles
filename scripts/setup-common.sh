#!/bin/bash

# Common setup script for cross-platform dependencies
# This script handles installations and configurations that are common across all environments

set -e

# Function to create symlinks
create_symlink() {
  local target="$1"
  local link_path="$2"

  # Ensure parent directory exists
  mkdir -p "$(dirname "$link_path")"

  # If symlink already exists and points to the right target, do nothing
  if [ -L "$link_path" ] && [ "$(readlink "$link_path")" = "$target" ]; then
    return 0
  fi

  # If file/symlink exists but is wrong, remove it
  if [ -e "$link_path" ] || [ -L "$link_path" ]; then
    rm -f "$link_path"
  fi

  # Create symlink
  ln -s "$target" "$link_path"
}

echo "⏳ Setting up symlinks for configuration files..."
create_symlink "$DOTFILES_DIR/config/git/.gitconfig" "$HOME/.gitconfig"
create_symlink "$DOTFILES_DIR/config/shell/.zshrc" "$HOME/.zshrc"
create_symlink "$DOTFILES_DIR/config/shell/.zprofile" "$HOME/.zprofile"
create_symlink "$DOTFILES_DIR/config/ghostty/config" "$HOME/.config/ghostty/config"
source "$DOTFILES_DIR/config/claude/init.sh"

source "$HOME/.zshrc"
source "$HOME/.zprofile"

# Main setup function
echo "⏳ Setting up shell and common cross-platform dependencies..."

source $DOTFILES_DIR/scripts/install/zsh.sh

source $DOTFILES_DIR/scripts/install/volta-and-node.sh

source $DOTFILES_DIR/scripts/install/rustup.sh

source $DOTFILES_DIR/scripts/install/brew.sh

export HOMEBREW_BUNDLE_FILE="$DOTFILES_DIR/config/brew/Brewfile"

echo "⏳ Installing Homebrew packages..."
brew update
brew upgrade
brew bundle

echo "✅ Homebrew packages installed successfully."

echo "✅ Common setup completed successfully."