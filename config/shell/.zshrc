# Enable command auto-correction
setopt correct

UTILITIES_DIR="$DOTFILES_DIR/config/shell/utilities"

# Alias, etc.
echo "Loading shell utilities..."
source $UTILITIES_DIR/docker.sh
source $UTILITIES_DIR/git.sh
source $UTILITIES_DIR/codespaces.sh
source $UTILITIES_DIR/vanta.sh

# Add custom scripts to PATH
export PATH="$HOME/bin:$PATH"