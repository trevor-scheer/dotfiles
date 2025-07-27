#!/bin/bash

# Check if running in Codespaces
if [ -n "$CODESPACES" ]; then
    echo "Setting up for GitHub Codespaces..."

    # Add any Codespaces-specific setup here
    # For example, symlinking dotfiles or installing extensions

    echo "Codespaces setup complete."
else
    echo "This script is intended to be run in GitHub Codespaces."
fi