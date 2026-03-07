#!/bin/bash

# macOS-specific setup

set -e

source "$DOTFILES_DIR/scripts/lib.sh"

# Install Xcode command line tools
if xcode-select -p &> /dev/null; then
    log_success "Xcode Command Line Tools are already installed."
else
    log_info "Installing Xcode Command Line Tools..."
    xcode-select --install || true
fi

# Apply macOS system defaults
source "$DOTFILES_DIR/scripts/macos-defaults.sh"

log_success "macOS setup complete."
