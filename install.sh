#!/bin/bash

DOTFILES_DIR=$(pwd)
set -e

# Create symlinks
ln -sf "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
ln -sf "$DOTFILES_DIR/.profile" "$HOME/.profile"
ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"


# Install Volta if not installed
if ! command -v volta &> /dev/null; then
  echo "💡 Installing Volta..."
  curl https://get.volta.sh | bash
  echo 'export VOLTA_HOME="$HOME/.volta"' >> $HOME/.zprofile
  echo 'export PATH="$VOLTA_HOME/bin:$PATH"' >> $HOME/.zprofile
  
  # Source the new environment to make volta available immediately
  export VOLTA_HOME="$HOME/.volta"
  export PATH="$VOLTA_HOME/bin:$PATH"
else 
  echo "✅ Volta is already installed."
fi

# Install Node if not installed
if ! command -v node &> /dev/null; then
  echo "💡 Installing Node.js..."
  volta install node
else 
  echo "✅ Node.js is already installed."
fi

# Install Homebrew if not installed
if ! command -v brew &> /dev/null; then
  echo "💡 Installing brew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  echo >> $HOME/.zprofile
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
else 
  echo "✅ Brew is already installed."
fi

# Install apps from Brewfile
brew bundle --file="$DOTFILES_DIR/Brewfile"

if [ -n "$CODESPACES" ]; then
  echo "This script is running inside a GitHub Codespace."
  sudo chsh "$(id -un)" --shell "/usr/bin/zsh"
else  
  # Check if running on macOS
  if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "Detected macOS. Running install-mac.sh..."
    ./install-mac.sh
  else
    echo "Not running on macOS. Skipping install-mac.sh"
  fi
fi