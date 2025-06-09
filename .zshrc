# Developer goodies
export EDITOR="nvim"
alias gb="git branch"
alias gc="git commit"
alias gp="git push"
alias gs="git status"
alias vim="nvim"

alias zshrc="code ~/.zshrc"
alias dotfiles="code ~/.dotfiles"
alias brewfile="code ~/.dotfiles/Brewfile"

# Vanta
alias cs="gh cs create -R VantaInc/obsidian && gh cs code"

function codespace-cursor() {
  pushd ~/obsidian
  git checkout main
  git pull
  node ~/obsidian/scripts/setupCodespaceSSH.cjs
  popd
}