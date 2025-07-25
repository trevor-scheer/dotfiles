# Git
export EDITOR="vim"
alias gb="git branch"
alias gc="git commit"
alias gp="git push"
alias gs="git status"
alias grc="git rebase --continue"
alias gprom="git pull --rebase origin main"
# alias vim="nvim"

fixup() {
  # Check for unstaged changes
  if ! git diff --quiet; then
    echo "Creating fixup commit for unstaged changes..."

    # Stage only unstaged changes (exclude untracked files)
    git diff --name-only | xargs git add

    # Create fixup commit targeting previous commit
    git commit --fixup=HEAD

    # Perform autosquash rebase to squash into previous commit
    git rebase --autosquash -i HEAD~2
  else
    echo "No unstaged changes found."
  fi
}

# Docker
dcl() {
  if [ -n "$1" ]; then
    docker compose logs -f "$1"
  else
    docker compose logs -f
  fi
}
alias ld="lazydocker"

alias dotfiles="code ~/dotfiles"
alias brewfile="code ~/.dotfiles/Brewfile"
function zshrc() {
  code -w ~/.zshrc
  source ~/.zshrc
  echo ".zshrc reloaded successfully."
}

# Vanta
alias jdsw="just dev-start-web"
alias mdsw="jdsw"
alias cs="gh cs create -R VantaInc/obsidian && gh cs code && codespace-cursor"

function codespace-cursor() {
  pushd ~/obsidian
  git checkout main
  git pull
  node ~/obsidian/scripts/setupCodespaceSSH.js
  popd
}

function turboclient() {
  turbo -F @vanta/web-client "$@"
}
alias tc=turboclient

alias dr="make dev-replace"
alias drw="make dev-replace web-client"
alias drs="docker container restart obsidian-web-client.internal-1"
alias logs="make dev-watch-logs"
alias yww="yarn workspace @vanta/web-client"


# NPM Completion
if type complete &>/dev/null; then
  _npm_completion () {
    local words cword
    if type _get_comp_words_by_ref &>/dev/null; then
      _get_comp_words_by_ref -n = -n @ -n : -w words -i cword
    else
      cword="$COMP_CWORD"
      words=("${COMP_WORDS[@]}")
    fi

    local si="$IFS"
    if ! IFS=$'\n' COMPREPLY=($(COMP_CWORD="$cword" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           npm completion -- "${words[@]}" \
                           2>/dev/null)); then
      local ret=$?
      IFS="$si"
      return $ret
    fi
    IFS="$si"
    if type __ltrim_colon_completions &>/dev/null; then
      __ltrim_colon_completions "${words[cword]}"
    fi
  }
  complete -o default -F _npm_completion npm
elif type compdef &>/dev/null; then
  _npm_completion() {
    local si=$IFS
    compadd -- $(COMP_CWORD=$((CURRENT-1)) \
                 COMP_LINE=$BUFFER \
                 COMP_POINT=0 \
                 npm completion -- "${words[@]}" \
                 2>/dev/null)
    IFS=$si
  }
  compdef _npm_completion npm
elif type compctl &>/dev/null; then
  _npm_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    if ! IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       npm completion -- "${words[@]}" \
                       2>/dev/null)); then

      local ret=$?
      IFS="$si"
      return $ret
    fi
    IFS="$si"
  }
  compctl -K _npm_completion npm
fi
###-end-npm-completion-###
