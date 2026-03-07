#!/bin/bash

# Common setup script for cross-platform dependencies
# This script handles installations and configurations that are common across all environments

set -e

source "$DOTFILES_DIR/scripts/lib.sh"

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

log_info "Creating symlinks with GNU Stow..."
stow -d "$DOTFILES_DIR/stow" -t "$HOME" git shell ghostty tmux nvim
log_success "Symlinks created successfully."

source "$DOTFILES_DIR/config/claude/init.sh"

# Source shell configs so new tools are available in this session
source "$HOME/.zprofile"
source "$HOME/.zshrc"

log_success "Common setup completed successfully."
