# Install Rust via rustup if not installed
if ! command -v rustup &> /dev/null; then
  echo "⏳ Installing Rust via rustup..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
  source "$HOME/.cargo/env"
else
  echo "✅ Rust is already installed."
fi
