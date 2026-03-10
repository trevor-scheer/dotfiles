# Ensure DOTFILES_DIR is set even if .zprofile was skipped (non-login shells)
export DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"

# Re-declare in case .zprofile wasn't sourced (defines _dotfiles_log)
if ! type _dotfiles_log &>/dev/null; then
  export DOTFILES_DEBUG="${DOTFILES_DEBUG:-true}"
  _dotfiles_log() {
    [[ "$DOTFILES_DEBUG" == "true" ]] && echo "[dotfiles:$1] $2"
  }
  _dotfiles_log "!!" ".zshrc: .zprofile was NOT sourced — running as non-login shell"
fi

_dotfiles_log "05" ".zshrc: start (DOTFILES_DIR=$DOTFILES_DIR)"

UTILITIES_DIR="$DOTFILES_DIR/config/shell/utilities"

bindkey '^R' history-incremental-search-backward

# Common shell options
setopt AUTO_CD            # cd by typing directory name
setopt HIST_IGNORE_DUPS   # no duplicate history entries
setopt SHARE_HISTORY      # share history across sessions
setopt APPEND_HISTORY     # append, don't overwrite

# Alias, etc.
_dotfiles_log "06" ".zshrc: sourcing utilities from $UTILITIES_DIR"
source "$UTILITIES_DIR/general.sh"
source "$UTILITIES_DIR/docker.sh"
source "$UTILITIES_DIR/git.sh"
source "$UTILITIES_DIR/npm.sh"
source "$UTILITIES_DIR/dotfiles-update.sh"
_dotfiles_log "07" ".zshrc: utilities loaded"

# Prompt
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%b '
setopt PROMPT_SUBST
PROMPT='%F{green}%*%f %F{blue}%~%f %F{red}${vcs_info_msg_0_}%f$ '
_dotfiles_log "08" ".zshrc: prompt configured"

# Source optional modules (e.g. work-specific configs in modules/*/)
_dotfiles_log "09" ".zshrc: looking for modules in $DOTFILES_DIR/modules/*/shell.sh"
for module_shell in "$DOTFILES_DIR"/modules/*/shell.sh; do
  if [ -f "$module_shell" ]; then
    _dotfiles_log "10" ".zshrc: sourcing module $module_shell"
    source "$module_shell"
  else
    _dotfiles_log "10" ".zshrc: no module found at $module_shell"
  fi
done

# Add module bin directories to PATH
for module_bin in "$DOTFILES_DIR"/modules/*/bin; do
  if [ -d "$module_bin" ]; then
    _dotfiles_log "11" ".zshrc: adding module bin $module_bin to PATH"
    export PATH="$module_bin:$PATH"
  else
    _dotfiles_log "11" ".zshrc: no module bin at $module_bin"
  fi
done

_dotfiles_log "12" ".zshrc: done"
