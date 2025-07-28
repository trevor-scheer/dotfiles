#!/bin/bash

set -e

DOTFILES_DIR="$HOME/dotfiles"

echo "⏳ Setting up cross-platform dependencies..."
source $DOTFILES_DIR/scripts/setup-common.sh

# Check if the script is being run in GitHub Codespaces
if [ "$CODESPACE_NAME" ]; then
    echo "⏳ Setting up Codespaces specifics..."
    source "$DOTFILES_DIR/scripts/setup-codespaces.sh"
    exit 0
fi

# Determine the operating system
OS="$(uname -s)"

case "$OS" in
    Darwin)
        echo "⏳ Setting up macOS specifics..."
        source "$DOTFILES_DIR/scripts/setup-macos.sh"
        ;;
    Linux)
        echo "⏳ Setting up Linux specifics..."
        source "$DOTFILES_DIR/scripts/setup-linux.sh"
        ;;
    *)
        echo "❌ Unsupported operating system: $OS"
        exit 1
        ;;
esac

echo "✅ Dotfiles setup completed successfully."