# Developer goodies
export EDITOR="vim"
alias gb="git branch"
alias gc="git commit"
alias gp="git push"
alias gs="git status"
alias grc="git rebase --continue"
alias gprom="git pull --rebase origin main"
# alias vim="nvim"

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