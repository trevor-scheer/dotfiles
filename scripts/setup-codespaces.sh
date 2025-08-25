#!/bin/bash

# Check if running in Codespaces
if [ -n "$CODESPACES" ]; then
    # Add any Codespaces-specific setup here
    # For example, symlinking dotfiles or installing extensions

    # if cursor is installed, install extensions
    if command -v cursor &> /dev/null; then
        echo "✅ Cursor is installed."
        install_extensions
    else
        echo "❌ Cursor is not installed."
    fi

    echo "✅ Codespaces setup complete."
else
    echo "❌ This script is intended to be run in GitHub Codespaces."
fi

install_extensions() {
  cat .devcontainer/devcontainer.json \
    | npx strip-json-comments-cli \
    | jq -r '.customizations.vscode.extensions[]' \
    | while read -r extension; do
        cursor --install-extension "$extension" || echo "Failed to install extension: $extension"
      done
}