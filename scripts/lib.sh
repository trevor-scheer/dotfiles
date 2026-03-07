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

is_cloud_env() { [[ -n "${CODESPACES:-}" ]] || [[ -n "${GITPOD_WORKSPACE_ID:-}" ]]; }
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
