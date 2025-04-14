#!/bin/bash

set -e

echo "Setting up your Mac..."

# Install Xcode command line tools
xcode-select --install || true

# Install Homebrew if not installed
if ! command -v brew &> /dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  echo "testing!"
  echo >> $HOME/.zprofile
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Create symlinks
ln -sf "$HOME/.dotfiles/zsh/.zshrc" "$HOME/.zshrc"
ln -sf "$HOME/.dotfiles/git/.gitconfig" "$HOME/.gitconfig"

if [ -d "$HOME/.oh-my-zsh" ]; then
  echo "✅ Oh My Zsh is already installed."
else
  echo "💡 Installing Oh My Zsh..."
  RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  # Install powerlevel10k
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
  echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>! ~/.zshrc
fi

# Install rustup (and rustc)
if ! command -v rustup &> /dev/null; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi


# Install apps from Brewfile
brew bundle --file="$HOME/.dotfiles/Brewfile"

echo "✅ Done! Reload your terminal."