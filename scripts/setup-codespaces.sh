#!/bin/bash

# Check if running in a cloud dev environment (Codespaces or Gitpod)
if [ -n "$IS_ON_ONA" ] || [ -n "$CODESPACES" ]; then
    # Add any cloud environment-specific setup here
    echo "✅ Cloud environment setup complete."
else
    echo "❌ This script is intended to be run in a cloud dev environment."
fi
