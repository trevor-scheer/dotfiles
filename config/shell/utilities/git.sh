#!/usr/bin/env zsh
alias gb="git branch"
alias gc="git commit"
alias gcm="git checkout main"
alias gc-="git checkout -"
alias gp="git push"
alias gs="git status"
alias grc="git rebase --continue"
alias grhh="git reset HEAD --hard"
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

ship-it() {
  local REPO="VantaInc/obsidian"

  if [ $# -lt 1 ]; then
    echo "Usage: ship-it <PR_NUMBER>"
    return 1
  fi

  local PR_NUMBER="$1"

  echo "🚀 Approving PR #${PR_NUMBER} in ${REPO}..."
  gh pr review "${PR_NUMBER}" --repo "${REPO}" --approve

  echo "✅ Done!"
}