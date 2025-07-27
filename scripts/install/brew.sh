if ! command -v brew &> /dev/null; then
  echo "⏳ Installing Homebrew..."

  # Install Homebrew (works on both macOS and Linux)
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  
  # Add Homebrew to PATH for Linux/Codespaces
  if [[ "$OSTYPE" == "linux-gnu"* ]] || [ -n "$CODESPACE_NAME" ]; then
    # echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.bashrc
    # echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.zshrc
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  fi

  echo "✅ Homebrew installed successfully."
else
  echo "✅ Homebrew is already installed."
fi