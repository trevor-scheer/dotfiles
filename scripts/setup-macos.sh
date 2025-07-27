#!/bin/bash

# macOS specific setup

# Install Xcode command line tools
if xcode-select -p &> /dev/null; then
    echo "✅ Xcode Command Line Tools are already installed."
else
    echo "💡 Installing Xcode Command Line Tools..."
    xcode-select --install || true
fi

# Additional macOS specific configurations can be added here

echo "macOS setup complete."