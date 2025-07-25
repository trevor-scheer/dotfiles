# For Codespaces

# Set shell to zsh
sudo chsh "$(id -un)" --shell "/usr/bin/zsh"

cp .gitconfig ~/.gitconfig
cp .profile ~/.profile
cp .zshrc ~/.zshrc

source ~/.profile


if [ -n "$CODESPACES" ]; then
  echo "This script is running inside a GitHub Codespace."
  # Add Codespace-specific logic here
else
  echo "This script is NOT running inside a GitHub Codespace."
  # Add non-Codespace-specific logic here
fi