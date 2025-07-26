# ~/.profile - User-specific environment and startup programs
# TODO: ensure zsh is installed
# export SHELL=/bin/zsh

# Cargo (Rust) environment
#. "$HOME/.cargo/env"
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

function profile() {
  code -w ~/.profile
  source ~/.profile
  echo ".profile reloaded successfully."
}

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

# Vanta
alias jdsw="just dev-start-web"
alias mdsw="jdsw"

csssh() {
  temp="___setupCodespaceSSH.temp.js"
  gh api repos/VantaInc/obsidian/contents/scripts/setupCodespaceSSH.js \
    --jq '.content' | base64 -d > "$temp"
  node "$temp"
  rm "$temp"
}

newcs() {
  cs_id=$(gh cs create -R VantaInc/obsidian)
  echo "Codespace created, waiting for it to be ready...(~40s arbitrarily)"
  sleep 40
  echo "Codespace ready, setting up SSH..."
  
  csssh
  
  cursor -n --folder-uri "vscode-remote://ssh-remote+${cs_id}.github.dev/workspaces/obsidian"
}

opencs() {
  echo "TODO"
}

stopcs() {
  temp="___shutdownCodespaces.temp.js"
  gh api repos/VantaInc/obsidian/contents/scripts/shutdownCodespaces.cjs \
    --jq '.content' | base64 -d > "$temp"
  node "$temp"
  rm "$temp"
}

turboclient() {
  turbo -F @vanta/web-client "$@"
}
alias tc=turboclient

alias dr="make dev-replace"
alias drw="make dev-replace web-client"
alias drs="docker container restart obsidian-web-client.internal-1"
alias logs="make dev-watch-logs"
alias yww="yarn workspace @vanta/web-client"
