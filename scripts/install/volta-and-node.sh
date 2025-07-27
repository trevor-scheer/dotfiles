# Install Volta if not installed
if ! command -v volta &> /dev/null; then
  echo "⏳ Installing Volta..."
  curl https://get.volta.sh | bash
  echo 'export VOLTA_HOME="$HOME/.volta"' >> $HOME/.zprofile
  echo 'export PATH="$VOLTA_HOME/bin:$PATH"' >> $HOME/.zprofile
  
  # Source the new environment to make volta available immediately
  export VOLTA_HOME="$HOME/.volta"
  export PATH="$VOLTA_HOME/bin:$PATH"
else 
  echo "✅ Volta is already installed."
fi

# Install Node if not installed
if ! command -v node &> /dev/null; then
  echo "⏳ Installing Node.js..."
  volta install node
else 
  echo "✅ Node.js is already installed."
fi