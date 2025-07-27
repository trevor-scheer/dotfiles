#!/bin/bash

# Common setup script for cross-platform dependencies
# This script handles installations and configurations that are common across all environments

set -e

# Function to create symlinks
create_symlink() {
    local source="$1"
    local target="$2"

    if [ -e "$target" ]; then
        echo "$target already exists. Skipping."
    else
        ln -s "$source" "$target"
        echo "Created symlink from $source to $target"
    fi
}

$DOTFILES_DIR=$(pwd)
# Symlink configuration files
create_symlink "$DOTFILES_DIR/config/git/.gitconfig" "$HOME/.gitconfig"
#create_symlink "$DOTFILES_DIR/config/shell/.bashrc" "$HOME/.bashrc"
create_symlink "$DOTFILES_DIR/config/shell/.zshrc" "$HOME/.zshrc"
create_symlink "$DOTFILES_DIR/config/shell/.zprofile" "$HOME/.zprofile"


# Main setup function
echo "Setting up shell and common cross-platform dependencies..."

source ./scripts/install/zsh.sh
  # Change default shell to zsh if not already set
if [[ "$SHELL" != *"zsh"* ]]; then
echo "Changing default shell to zsh..."
chsh -s $(which zsh)
echo "Note: You may need to restart your terminal for the shell change to take effect."
fi

souce ./scripts/install/volta-and-node.sh

source ./scripts/install/brew.sh
brew update
brew upgrade
brew bundle --file="$DOTFILES_DIR/Brewfile"

echo "Common setup completed successfully."