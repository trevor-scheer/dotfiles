#!/bin/bash
set -e

errors=0

check_symlink() {
  local link="$2"
  if [[ -L "$link" ]]; then
    echo "✅ $link -> $(readlink "$link")"
  elif [[ -e "$link" ]]; then
    echo "❌ $link exists but is not a symlink"
    ((errors++))
  else
    echo "⚠️  $link does not exist"
    ((errors++))
  fi
}

echo "=== Checking symlinks ==="
check_symlink "$HOME/dotfiles/config/git/.gitconfig" "$HOME/.gitconfig"
check_symlink "$HOME/dotfiles/config/shell/.zshrc" "$HOME/.zshrc"
check_symlink "$HOME/dotfiles/config/shell/.zprofile" "$HOME/.zprofile"
check_symlink "$HOME/dotfiles/config/ghostty/config" "$HOME/.config/ghostty/config"

echo ""
echo "=== Checking required tools ==="
for cmd in git zsh curl; do
  if command -v "$cmd" &>/dev/null; then
    echo "✅ $cmd found: $(command -v "$cmd")"
  else
    echo "❌ $cmd not found"
    ((errors++))
  fi
done

for cmd in brew volta node jq gh; do
  if command -v "$cmd" &>/dev/null; then
    echo "✅ $cmd found: $(command -v "$cmd")"
  else
    echo "⚠️  $cmd not found (optional)"
  fi
done

echo ""
echo "=== Running shellcheck ==="
if command -v shellcheck &>/dev/null; then
  while IFS= read -r f; do
    # Skip zsh scripts
    head -1 "$f" | grep -q 'zsh' && continue
    if shellcheck -s bash -x -e SC1091,SC2016 "$f" 2>/dev/null; then
      echo "✅ $f"
    else
      echo "❌ $f has shellcheck warnings"
      ((errors++))
    fi
  done < <(find "$(dirname "$0")/.." -name "*.sh" -not -path "*/.git/*" -not -path "*/.claude/*")
else
  echo "⚠️  shellcheck not installed, skipping"
fi

echo ""
if [[ $errors -gt 0 ]]; then
  echo "❌ $errors error(s) found"
  exit 1
else
  echo "✅ All checks passed"
fi
