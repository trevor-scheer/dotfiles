#!/bin/bash

# Initialize Claude Code configuration for new environments

safe_stow claude

# Seed ~/.claude.json to skip the onboarding wizard
CLAUDE_JSON="$HOME/.claude.json"
CLAUDE_JSON_DEFAULTS="$DOTFILES_DIR/config/claude/claude.json"

if [ ! -f "$CLAUDE_JSON" ]; then
  cp "$CLAUDE_JSON_DEFAULTS" "$CLAUDE_JSON"
elif command -v jq &>/dev/null; then
  jq ". + $(cat "$CLAUDE_JSON_DEFAULTS")" "$CLAUDE_JSON" > "$CLAUDE_JSON.tmp" && mv "$CLAUDE_JSON.tmp" "$CLAUDE_JSON"
fi
