export DOTFILES_DIR="$HOME/dotfiles"
UTILITIES_DIR="$DOTFILES_DIR/config/shell/utilities"

bindkey '^R' history-incremental-search-backward

# Common shell options
setopt AUTO_CD            # cd by typing directory name
setopt HIST_IGNORE_DUPS   # no duplicate history entries
setopt SHARE_HISTORY      # share history across sessions
setopt APPEND_HISTORY     # append, don't overwrite

# Alias, etc.
source $UTILITIES_DIR/general.sh
source $UTILITIES_DIR/docker.sh
source $UTILITIES_DIR/git.sh
source $UTILITIES_DIR/npm.sh
source $UTILITIES_DIR/dotfiles-update.sh

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

# Source optional modules (e.g. work-specific configs in modules/*/)
for module_shell in $DOTFILES_DIR/modules/*/shell.sh; do
  [ -f "$module_shell" ] && source "$module_shell"
done

# Add module bin directories to PATH
for module_bin in $DOTFILES_DIR/modules/*/bin; do
  [ -d "$module_bin" ] && export PATH="$module_bin:$PATH"
done
