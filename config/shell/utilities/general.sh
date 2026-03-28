alias ..="cd .."
alias ...="cd ../.."

function zprofile() {
  code -w ~/.zprofile
  source ~/.zprofile
  echo ".zprofile reloaded successfully."
}

function zshrc() {
  code -w ~/.zshrc
  source ~/.zshrc
  echo ".zshrc reloaded successfully."
}

function cw() {
  if [[ -z "$1" ]]; then
    echo "Usage: cw <worktree-name>" >&2
    return 1
  fi
  claude --worktree "$1" --dangerously-skip-permissions
}
