#!/bin/zsh

set -e


DOTFILES_DIR="$HOME/dotfiles"
ORIGINAL_DOTFILES_DIR="$( cd "$( dirname "${0}" )" &> /dev/null && pwd )"
if [ ! -e "$HOME/dotfiles" ]; then
    ln -s "$ORIGINAL_DOTFILES_DIR" "$DOTFILES_DIR"
fi

source "$DOTFILES_DIR/scripts/lib.sh"

log_info "Setting up cross-platform dependencies..."
source "$DOTFILES_DIR/scripts/setup-common.sh"

# Check if the script is being run in a cloud dev environment (Codespaces or Gitpod)
if is_cloud_env; then
    log_info "Setting up cloud environment specifics..."
    source "$DOTFILES_DIR/scripts/setup-codespaces.sh"
    log_success "Dotfiles setup completed successfully. Reload your shell: exec zsh"
    exit 0
fi

if is_macos; then
    log_info "Setting up macOS specifics..."
    source "$DOTFILES_DIR/scripts/setup-macos.sh"
elif is_linux; then
    log_info "Setting up Linux specifics..."
    source "$DOTFILES_DIR/scripts/setup-linux.sh"
else
    log_error "Unsupported operating system: $(uname -s)"
    exit 1
fi

log_success "Dotfiles setup completed successfully. Reload your shell: exec zsh"