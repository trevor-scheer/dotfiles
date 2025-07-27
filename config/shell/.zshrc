# Enable command auto-correction
# setopt correct

export DOTFILES_DIR="$HOME/dotfiles"
UTILITIES_DIR="$DOTFILES_DIR/config/shell/utilities"

echo "⚠️ Utilities directory set to: $UTILITIES_DIR"
# Alias, etc.
echo "⏳ Loading shell utilities..."
source $UTILITIES_DIR/docker.sh
source $UTILITIES_DIR/git.sh
source $UTILITIES_DIR/npm.sh
source $UTILITIES_DIR/codespaces.sh
source $UTILITIES_DIR/vanta.sh

# Add custom scripts to PATH
export PATH="$HOME/bin:$PATH"

echo "✅ zshrc loaded."