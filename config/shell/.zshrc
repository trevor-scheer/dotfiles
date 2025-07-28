export DOTFILES_DIR="$HOME/dotfiles"
UTILITIES_DIR="$DOTFILES_DIR/config/shell/utilities"

# Alias, etc.
echo "⏳ Loading shell utilities..."
source $UTILITIES_DIR/docker.sh
source $UTILITIES_DIR/git.sh
source $UTILITIES_DIR/npm.sh
source $UTILITIES_DIR/codespaces.sh
source $UTILITIES_DIR/vanta.sh

# Add Homebrew to PATH if installed
if [ -d "$HOME/.linuxbrew" ]; then
  export PATH="$HOME/.linuxbrew/bin:$PATH"
elif [ -d "/home/linuxbrew/.linuxbrew" ]; then
  export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
fi

# Add custom scripts to PATH
export PATH="$HOME/bin:$PATH"

echo "✅ zshrc loaded."

