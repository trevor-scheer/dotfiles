# Contents of /dotfiles/dotfiles/config/shell/.zshrc

# Zsh configuration file

# Set the default editor
export EDITOR='vim'

# Enable command auto-correction
setopt correct

# Enable command history
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# Set the prompt
PROMPT='%n@%m %1~ %# '

# Alias definitions
alias ll='ls -la'
alias gs='git status'
alias gp='git pull'
alias gcm='git commit -m'

# Load additional configurations if they exist
if [ -f ~/.zsh_aliases ]; then
    source ~/.zsh_aliases
fi

# Add custom scripts to PATH
export PATH="$HOME/bin:$PATH"