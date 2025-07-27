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

# Define the home directory
HOME_DIR="$HOME"

# Symlink configuration files
create_symlink "$HOME_DIR/dotfiles/config/git/.gitconfig" "$HOME_DIR/.gitconfig"
create_symlink "$HOME_DIR/dotfiles/config/shell/.bashrc" "$HOME_DIR/.bashrc"
create_symlink "$HOME_DIR/dotfiles/config/shell/.zshrc" "$HOME_DIR/.zshrc"
create_symlink "$HOME_DIR/dotfiles/config/shell/.profile" "$HOME_DIR/.profile"

# Function to setup zsh for Linux and Codespaces
setup_zsh() {
    # Only setup zsh on Linux/Codespaces (macOS already uses zsh by default)
    if [[ "$OSTYPE" == "linux-gnu"* ]] || [ -n "$CODESPACE_NAME" ]; then
        echo "Setting up zsh for Linux/Codespaces..."
        
        # Install zsh using system package manager
        if command -v apt-get &> /dev/null; then
            sudo apt-get update && sudo apt-get install -y zsh
        elif command -v yum &> /dev/null; then
            sudo yum install -y zsh
        elif command -v dnf &> /dev/null; then
            sudo dnf install -y zsh
        else
            echo "Warning: Could not install zsh automatically. Please install it manually."
            return
        fi
        
        # Change default shell to zsh if not already set
        if [[ "$SHELL" != *"zsh"* ]]; then
            echo "Changing default shell to zsh..."
            chsh -s $(which zsh)
            echo "Note: You may need to restart your terminal for the shell change to take effect."
        fi
        
        echo "zsh setup completed."
    else
        echo "macOS already uses zsh by default. Skipping zsh setup."
    fi
}

# Function to install Homebrew
install_homebrew() {
    if ! command -v brew &> /dev/null; then
        echo "Homebrew not found. Installing..."
        
        # Install Homebrew (works on both macOS and Linux)
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        
        # Add Homebrew to PATH for Linux/Codespaces
        if [[ "$OSTYPE" == "linux-gnu"* ]] || [ -n "$CODESPACE_NAME" ]; then
            echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.bashrc
            echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.zshrc
            eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
        fi
        
        echo "Homebrew installed successfully."
    else
        echo "Homebrew is already installed."
    fi
}

# Main setup function
echo "Setting up common cross-platform dependencies..."

# Setup zsh first for Linux/Codespaces
setup_zsh

# Install Homebrew
install_homebrew

echo "Common setup completed successfully."