# Check for dotfiles updates on shell startup
# shellcheck disable=SC1083
function _dotfiles_check_updates() {
  local dotfiles_dir="${DOTFILES_DIR:-$HOME/dotfiles}"

  [ -d "$dotfiles_dir/.git" ] || return 0

  git -C "$dotfiles_dir" fetch --quiet 2>/dev/null || return 0

  local behind
  behind=$(git -C "$dotfiles_dir" rev-list --count HEAD..@{upstream} 2>/dev/null) || return 0
  [ "$behind" -gt 0 ] || return 0

  printf '\033[33mDotfiles are %s commit(s) behind remote.\033[0m\n' "$behind"
  printf 'Pull updates? [y/N] '
  read -r response
  if [[ "$response" =~ ^[Yy]$ ]]; then
    if git -C "$dotfiles_dir" pull --no-rebase --ff-only; then
      printf '\033[32mDotfiles updated. Running install script...\033[0m\n'
      "$dotfiles_dir/install.sh" && exec zsh
    else
      printf '\033[31mFailed to pull updates. You may need to resolve conflicts manually.\033[0m\n'
    fi
  fi
}

_dotfiles_check_updates
