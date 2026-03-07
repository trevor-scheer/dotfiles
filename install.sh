#!/bin/zsh

set -e


DOTFILES_DIR="$HOME/dotfiles"
ORIGINAL_DOTFILES_DIR="$( cd "$( dirname "${0}" )" &> /dev/null && pwd )"
if [ ! -e "$HOME/dotfiles" ]; then
    ln -s "$ORIGINAL_DOTFILES_DIR" "$DOTFILES_DIR"
fi


echo "⏳ Setting up cross-platform dependencies..."
source $DOTFILES_DIR/scripts/setup-common.sh

# Check if the script is being run in a cloud dev environment (Codespaces or Gitpod)
if [ -n "$CODESPACES" ] || [ -n "$GITPOD_WORKSPACE_ID" ]; then
    echo "⏳ Setting up cloud environment specifics..."
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