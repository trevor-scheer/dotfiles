export DOTFILES_DIR="$HOME/dotfiles"
UTILITIES_DIR="$DOTFILES_DIR/config/shell/utilities"

# Alias, etc.
echo "⏳ Loading shell utilities..."
source $UTILITIES_DIR/docker.sh
source $UTILITIES_DIR/git.sh
source $UTILITIES_DIR/npm.sh
source $UTILITIES_DIR/vanta.sh

# Add Homebrew to PATH if installed
eval "$(/opt/homebrew/bin/brew shellenv)"

# Add custom scripts to PATH
export PATH="$HOME/bin:$PATH"

# Prompt
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%b '
setopt PROMPT_SUBST
PROMPT='%F{green}%*%f %F{blue}%~%f %F{red}${vcs_info_msg_0_}%f$ '

echo "✅ zshrc loaded."

