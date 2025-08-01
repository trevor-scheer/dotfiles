export DOTFILES_DIR="$HOME/dotfiles"
UTILITIES_DIR="$DOTFILES_DIR/config/shell/utilities"

# Alias, etc.
echo "⏳ Loading shell utilities..."
source $UTILITIES_DIR/docker.sh
source $UTILITIES_DIR/git.sh
source $UTILITIES_DIR/npm.sh

# if VANTA env is truthy, load Vanta
# else echo instructions to install Vanta
if [[ -z "$VANTA" ]]; then
  echo "⚠️  Vanta utilities not loaded. Set VANTA=true in .zprofile to enable."
else
  source $UTILITIES_DIR/vanta.sh
fi

export HOMEBREW_BUNDLE_FILE="$DOTFILES_DIR/config/brew/Brewfile"
# Add Homebrew to PATH if installed
# Add Homebrew to PATH (linux and macOS)
if [ -d /opt/homebrew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -d /home/linuxbrew/.linuxbrew ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Don't think this does anything
# Add custom scripts to PATH
#export PATH="$HOME/bin:$PATH"

# Prompt
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%b '
setopt PROMPT_SUBST
PROMPT='%F{green}%*%f %F{blue}%~%f %F{red}${vcs_info_msg_0_}%f$ '

echo "✅ zshrc loaded."

