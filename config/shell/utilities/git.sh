#!/usr/bin/env zsh
alias gb="git branch"
alias gc="git commit"
alias gp="git push"
alias gs="git status"
alias grc="git rebase --continue"
alias gprom="git pull --rebase origin main"

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