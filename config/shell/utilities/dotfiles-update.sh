# Check for dotfiles updates on shell startup
function _dotfiles_check_updates() {
  local dotfiles_dir="${DOTFILES_DIR:-$HOME/dotfiles}"

  # Skip if not a git repo
  [ -d "$dotfiles_dir/.git" ] || return 0

  # Only check once per day (use a timestamp file)
  local stamp_file="$dotfiles_dir/.update-check"
  local now=$(date +%s)
  if [ -f "$stamp_file" ]; then
    local last_check=$(cat "$stamp_file")
    local elapsed=$((now - last_check))
    # Skip if checked within the last 24 hours
    [ "$elapsed" -lt 86400 ] && return 0
  fi

  # Update the timestamp
  echo "$now" > "$stamp_file"

  # Fetch quietly in the background, then check
  git -C "$dotfiles_dir" fetch --quiet 2>/dev/null || return 0

  local local_head=$(git -C "$dotfiles_dir" rev-parse HEAD 2>/dev/null)
  local remote_head=$(git -C "$dotfiles_dir" rev-parse @{upstream} 2>/dev/null) || return 0

  if [ "$local_head" != "$remote_head" ]; then
    local behind=$(git -C "$dotfiles_dir" rev-list --count HEAD..@{upstream} 2>/dev/null)
    if [ "$behind" -gt 0 ]; then
      echo "\033[33mDotfiles are $behind commit(s) behind remote.\033[0m"
      echo -n "Pull updates? [y/N] "
      read -r response
      if [[ "$response" =~ ^[Yy]$ ]]; then
        if git -C "$dotfiles_dir" pull --ff-only; then
          echo "\033[32mDotfiles updated. Running install script...\033[0m"
          "$dotfiles_dir/install.sh"
        else
          echo "\033[31mFailed to pull updates. You may need to resolve conflicts manually.\033[0m"
        fi
      fi
    fi
  fi
}

_dotfiles_check_updates
