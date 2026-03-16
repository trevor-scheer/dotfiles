if ! command -v brew &> /dev/null; then
  echo "⏳ Installing Homebrew..."
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" > /dev/null
  echo "✅ Homebrew installed successfully."
else
  echo "✅ Homebrew is already installed."
fi

# Always add Homebrew to PATH on Linux (idempotent, needed when brew was pre-installed)
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi