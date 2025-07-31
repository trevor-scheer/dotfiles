export DOTFILES_DIR="$HOME/dotfiles"
UTILITIES_DIR="$DOTFILES_DIR/config/shell/utilities"

# Alias, etc.
echo "⏳ Loading shell utilities..."
source $UTILITIES_DIR/docker.sh
source $UTILITIES_DIR/git.sh
source $UTILITIES_DIR/npm.sh
source $UTILITIES_DIR/vanta.sh

# Add Homebrew to PATH if installed
eval "$(/opt/homebrew/bin/brew shellenv)"

# Add custom scripts to PATH
export PATH="$HOME/bin:$PATH"

export PS1="\[\e[32m\]\u@\h:\[\e[34m\]\w\[\e[0m\]\$ "

echo "✅ zshrc loaded."

