#!/bin/bash

# Shared library for install scripts
# Source this file to get access to common helpers.

# ---------------------------------------------------------------------------
# Logging
# ---------------------------------------------------------------------------

log_info()    { echo "⏳ $1"; }
log_success() { echo "✅ $1"; }
log_error()   { echo "❌ $1"; }
log_warn()    { echo "⚠️  $1"; }

# ---------------------------------------------------------------------------
# Environment detection
# ---------------------------------------------------------------------------

is_cloud_env() { [[ -n "${IS_ON_ONA:-}" ]] || [[ -n "${CODESPACES:-}" ]]; }
is_macos()     { [[ "$OSTYPE" == darwin* ]]; }
is_linux()     { [[ "$OSTYPE" == linux* ]]; }

# ---------------------------------------------------------------------------
# Idempotent file helper
# ---------------------------------------------------------------------------

ensure_line_in_file() {
  local file="$1" line="$2"
  grep -qF "$line" "$file" 2>/dev/null || echo "$line" >> "$file"
}

# ---------------------------------------------------------------------------
# Symlink helper (idempotent)
# ---------------------------------------------------------------------------

create_symlink() {
  local target="$1"
  local link_path="$2"

  # Ensure parent directory exists
  mkdir -p "$(dirname "$link_path")"

  # If symlink already exists and points to the right target, do nothing
  if [ -L "$link_path" ] && [ "$(readlink "$link_path")" = "$target" ]; then
    return 0
  fi

  # If file/symlink/directory exists but is wrong, remove it
  if [ -e "$link_path" ] || [ -L "$link_path" ]; then
    rm -rf "$link_path"
  fi

  # Create symlink
  ln -s "$target" "$link_path"
}

# ---------------------------------------------------------------------------
# GNU Stow helper (idempotent)
# ---------------------------------------------------------------------------

# Remove existing files/symlinks/dirs that would conflict with Stow,
# then stow the given packages.
#   Usage: safe_stow pkg1 pkg2 ...
safe_stow() {
  for pkg in "$@"; do
    local stow_dir="$DOTFILES_DIR/stow/$pkg"
    if [ -d "$stow_dir" ]; then
      # Remove directory symlinks that Stow created via folding (e.g. ~/.config/nvim -> stow/nvim/.config/nvim).
      # Must happen first so individual file removal below doesn't follow the dir symlink into the repo.
      (cd "$stow_dir" && find . -mindepth 1 -type d) | while read -r rel; do
        rel="${rel#./}"
        local target="$HOME/$rel"
        [ -L "$target" ] && rm -f "$target"
      done
      # Remove individual file symlinks/conflicts (only if not resolved through a dir symlink above)
      (cd "$stow_dir" && find . -type f) | while read -r rel; do
        rel="${rel#./}"
        local target="$HOME/$rel"
        [ -e "$target" ] || [ -L "$target" ] && rm -f "$target"
      done
    fi
  done
  stow -d "$DOTFILES_DIR/stow" -t "$HOME" "$@"
}
