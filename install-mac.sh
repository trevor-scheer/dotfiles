#!/bin/bash

echo "Setting up your Mac..."

# Install Xcode command line tools
if xcode-select -p &> /dev/null; then
    echo "✅ Xcode Command Line Tools are already installed."
else
    echo "💡 Installing Xcode Command Line Tools..."
    xcode-select --install || true
fi

# Copy ssh keys
if [ ! -d "$HOME/.ssh" ]; then
  echo "💡 No .ssh directory found, creating .ssh directory..."
  mkdir -p "$HOME/.ssh"
fi

if [ ! -f "$HOME/.ssh/id_ed25519" ]; then
  echo "💡 No SSH key found (id_ed25519), copying SSH key..."
  cp "$DOTFILES_DIR/ssh/id_ed25519" "$HOME/.ssh/id_ed25519"
  cp "$DOTFILES_DIR/ssh/id_ed25519.pub" "$HOME/.ssh/id_ed25519.pub"
  chmod 600 "$HOME/.ssh/id_ed25519"
  chmod 644 "$HOME/.ssh/id_ed25519.pub"
fi

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
  echo "💡 Installing Rust toolchain..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
else
  echo "✅ Rust toolchain is already installed."
fi

echo "✅ Done! Reload your terminal."

# Mac settings
defaults write -g com.apple.swipescrolldirection -bool false
defaults write com.apple.menuextra.battery ShowPercent YES
echo "🔄 You will need to log out for preference updates to take effect."