#!/bin/bash

# Common setup script for cross-platform dependencies
# This script handles installations and configurations that are common across all environments

set -e

source "$DOTFILES_DIR/scripts/lib.sh"

log_info "Setting up symlinks for configuration files..."
create_symlink "$DOTFILES_DIR/config/git/.gitconfig" "$HOME/.gitconfig"
create_symlink "$DOTFILES_DIR/config/shell/.zshrc" "$HOME/.zshrc"
create_symlink "$DOTFILES_DIR/config/shell/.zprofile" "$HOME/.zprofile"
create_symlink "$DOTFILES_DIR/config/ghostty/config" "$HOME/.config/ghostty/config"
source "$DOTFILES_DIR/config/claude/init.sh"

source "$HOME/.zshrc"
source "$HOME/.zprofile"

# Main setup function
log_info "Setting up shell and common cross-platform dependencies..."

source "$DOTFILES_DIR/scripts/install/zsh.sh"

source "$DOTFILES_DIR/scripts/install/volta-and-node.sh"

source "$DOTFILES_DIR/scripts/install/rustup.sh"

source "$DOTFILES_DIR/scripts/install/brew.sh"

export HOMEBREW_BUNDLE_FILE="$DOTFILES_DIR/config/brew/Brewfile"

log_info "Installing Homebrew packages..."
brew update
brew upgrade
brew bundle

log_success "Homebrew packages installed successfully."

log_success "Common setup completed successfully."
