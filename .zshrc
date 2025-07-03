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

alias zshrc="code ~/.zshrc"
alias dotfiles="code ~/dotfiles"
alias brewfile="code ~/.dotfiles/Brewfile"

# Vanta
alias mdsw="make dev-start-web"
alias cs="gh cs create -R VantaInc/obsidian && gh cs code"

function codespace-cursor() {
  pushd ~/obsidian
  git checkout main
  git pull
  node ~/obsidian/scripts/setupCodespaceSSH.cjs
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