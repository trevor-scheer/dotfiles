#!/usr/bin/env zsh
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
