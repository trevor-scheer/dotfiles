#!/bin/bash

# macOS system defaults
# Applied during initial setup — some changes require a logout or restart to take effect.

set -e

source "$DOTFILES_DIR/scripts/lib.sh"

log_info "Applying macOS system defaults..."

# Close System Preferences to prevent it from overriding our changes
osascript -e 'tell application "System Preferences" to quit' 2>/dev/null || true

###############################################################################
# Finder                                                                       #
###############################################################################

# Show hidden files in Finder
defaults write com.apple.finder AppleShowAllFiles -bool true

# Show path bar at bottom of Finder window
defaults write com.apple.finder ShowPathbar -bool true

# Show status bar at bottom of Finder window
defaults write com.apple.finder ShowStatusBar -bool true

# Default to list view in Finder windows (icnv=icon, clmv=column, glyv=gallery)
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Search the current folder by default (not entire Mac)
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Show all file extensions in Finder
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

###############################################################################
# Dock                                                                         #
###############################################################################

# Set Dock icon size to 48 pixels
defaults write com.apple.dock tilesize -int 48

# Auto-hide the Dock
defaults write com.apple.dock autohide -bool true

# Remove the auto-hide delay
defaults write com.apple.dock autohide-delay -float 0

# Use scale effect for minimizing windows (instead of genie)
defaults write com.apple.dock mineffect -string "scale"

# Don't show recent applications in the Dock
defaults write com.apple.dock show-recents -bool false

###############################################################################
# Keyboard                                                                     #
###############################################################################

# Set fast key repeat rate (lower = faster, default is 6)
defaults write NSGlobalDomain KeyRepeat -int 2

# Set short delay until key repeat starts (lower = shorter, default is 25)
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Disable automatic capitalization
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Disable smart dashes (converts -- to em dash)
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Disable smart quotes (converts straight quotes to curly quotes)
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable automatic period substitution (double space → period)
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

###############################################################################
# Trackpad                                                                     #
###############################################################################

# Enable tap to click on trackpad
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

###############################################################################
# Screenshots                                                                  #
###############################################################################

# Save screenshots to ~/Screenshots (instead of Desktop)
mkdir -p "$HOME/Screenshots"
defaults write com.apple.screencapture location -string "$HOME/Screenshots"

# Save screenshots as PNG (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"

# Disable screenshot shadow
defaults write com.apple.screencapture disable-shadow -bool true

###############################################################################
# Dialogs                                                                      #
###############################################################################

# Expand save dialogs by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print dialogs by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

###############################################################################
# Misc                                                                         #
###############################################################################

# Disable .DS_Store file creation on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Disable .DS_Store file creation on USB volumes
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

###############################################################################
# Apply changes                                                                #
###############################################################################

# Restart affected applications
killall Finder 2>/dev/null || true
killall Dock 2>/dev/null || true
killall SystemUIServer 2>/dev/null || true

log_success "macOS defaults applied. Some changes may require a logout or restart."
