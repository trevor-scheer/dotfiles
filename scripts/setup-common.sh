#!/bin/bash

# Common setup script for cross-platform dependencies
# This script handles installations and configurations that are common across all environments

set -e

# Function to create symlinks
create_symlink() {
    local source="$1"
    local target="$2"

    # TODO: should prompt to overwrite existing files
    ln -sf "$source" "$target"
    # if [ -e "$target" ]; then
    #     echo "❌ $target already exists. Skipping."
    # else
    #     ln -s "$source" "$target"
    #     echo "✅ Created symlink from $source to $target"
    # fi
}

echo "⏳ Setting up symlinks for configuration files..."
create_symlink "$DOTFILES_DIR/config/git/.gitconfig" "$HOME/.gitconfig"
#create_symlink "$DOTFILES_DIR/config/shell/.bashrc" "$HOME/.bashrc"
create_symlink "$DOTFILES_DIR/config/shell/.zshrc" "$HOME/.zshrc"
create_symlink "$DOTFILES_DIR/config/shell/.zprofile" "$HOME/.zprofile"

source "$HOME/.zshrc"
source "$HOME/.zprofile"

# Main setup function
echo "⏳ Setting up shell and common cross-platform dependencies..."

source $DOTFILES_DIR/scripts/install/zsh.sh
  # Change default shell to zsh if not already set
if [[ "$SHELL" != *"zsh"* ]]; then
    echo "⏳ Changing default shell to zsh..."
    echo "⚠️ Actually not doing that because it's not working"
    #chsh -s $(which zsh)
    echo "⚠️ You may need to restart your terminal for the shell change to take effect."
fi

source $DOTFILES_DIR/scripts/install/volta-and-node.sh

source $DOTFILES_DIR/scripts/install/brew.sh

export HOMEBREW_BUNDLE_FILE="$DOTFILES_DIR/config/brew/Brewfile"
if [ ! "$CODESPACES" ]; then
    echo "⏳ Installing Homebrew packages..."
    brew update
    brew upgrade
    brew bundle
fi
echo "✅ Homebrew packages installed successfully."

echo "✅ Common setup completed successfully."