export DOTFILES_DIR="$HOME/dotfiles"
export DOTFILES_DEBUG=true

_dotfiles_log() {
  [[ "$DOTFILES_DEBUG" == "true" ]] && echo "[dotfiles:$1] $2"
}

_dotfiles_log "01" ".zprofile: start (DOTFILES_DIR=$DOTFILES_DIR)"

# Cargo (Rust) environment
#. "$HOME/.cargo/env"
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
export EDITOR="vim"
_dotfiles_log "02" ".zprofile: volta/editor configured"

# Add Homebrew to PATH (macOS and Linux)
if [ -d /opt/homebrew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  _dotfiles_log "03" ".zprofile: homebrew loaded (macOS /opt/homebrew)"
elif [ -d /home/linuxbrew/.linuxbrew ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  _dotfiles_log "03" ".zprofile: homebrew loaded (Linux linuxbrew)"
else
  _dotfiles_log "03" ".zprofile: no homebrew found"
fi

export HOMEBREW_BUNDLE_FILE="$DOTFILES_DIR/config/brew/Brewfile"

# Enable command history
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
_dotfiles_log "04" ".zprofile: done"
