# Only setup zsh on Linux/Codespaces (macOS already uses zsh by default)
if [[ "$OSTYPE" == "linux-gnu"* ]] || [ -n "$CODESPACES" ] || [ -n "$GITPOD_WORKSPACE_ID" ]; then
  echo "⏳ Setting up zsh..."
  
  # Install zsh using system package manager
  if command -v apt-get &> /dev/null; then
    sudo apt-get update && sudo apt-get install -y zsh
  elif command -v yum &> /dev/null; then
    sudo yum install -y zsh
  elif command -v dnf &> /dev/null; then
    sudo dnf install -y zsh
  else
    echo "⚠️ Warning: Could not install zsh automatically. Please install it manually."
    return
  fi

  echo "✅ zsh setup completed."
else
  echo "✅ macOS already uses zsh by default. Skipping zsh setup."
fi