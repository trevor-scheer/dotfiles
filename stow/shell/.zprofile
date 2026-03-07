export DOTFILES_DIR="$HOME/dotfiles"

# Cargo (Rust) environment
#. "$HOME/.cargo/env"
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
export EDITOR="vim"

# Add Homebrew to PATH (macOS and Linux)
if [ -d /opt/homebrew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -d /home/linuxbrew/.linuxbrew ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

export HOMEBREW_BUNDLE_FILE="$DOTFILES_DIR/config/brew/Brewfile"

# Enable command history
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
