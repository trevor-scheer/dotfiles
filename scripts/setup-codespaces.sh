#!/bin/bash

# Check if running in a cloud dev environment (Codespaces or Gitpod)
if [ -n "$CODESPACES" ] || [ -n "$GITPOD_WORKSPACE_ID" ]; then
    # Add any cloud environment-specific setup here
    echo "✅ Cloud environment setup complete."
else
    echo "❌ This script is intended to be run in a cloud dev environment (Codespaces or Gitpod)."
fi
