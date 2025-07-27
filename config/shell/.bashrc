# ~/.bashrc configuration for Bash shell

# Alias definitions
alias ll='ls -la'
alias gs='git status'
alias gp='git pull'
alias gc='git commit'

# Prompt customization
export PS1="\[\e[32m\]\u@\h:\[\e[34m\]\w\[\e[0m\]\$ "

# Environment variables
export EDITOR=nano
export PATH="$HOME/bin:$PATH"

# Load additional scripts if they exist
if [ -f "$HOME/.bash_aliases" ]; then
    . "$HOME/.bash_aliases"
fi

# Source the profile if it exists
if [ -f "$HOME/.bash_profile" ]; then
    . "$HOME/.bash_profile"
fi