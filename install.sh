#!/bin/bash

set -e

echo "Setting up cross-platform dependencies"
source ./scripts/setup-common.sh

# Check if the script is being run in GitHub Codespaces
if [ "$CODESPACE_NAME" ]; then
    echo "Running in GitHub Codespaces..."
    source ./scripts/setup-codespaces.sh
    exit 0
fi

# Determine the operating system
OS="$(uname -s)"

case "$OS" in
    Darwin)
        echo "Detected macOS..."
        source ./scripts/setup-macos.sh
        ;;
    Linux)
        echo "Detected Linux..."
        source ./scripts/setup-linux.sh
        ;;
    *)
        echo "Unsupported operating system: $OS"
        exit 1
        ;;
esac

echo "Dotfiles setup completed successfully."