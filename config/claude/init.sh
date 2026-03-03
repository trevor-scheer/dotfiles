#!/bin/bash

# Initialize Claude Code configuration for new environments

create_symlink "$DOTFILES_DIR/config/claude/settings.json" "$HOME/.claude/settings.json"
create_symlink "$DOTFILES_DIR/config/claude/skills" "$HOME/.claude/skills"

# Seed ~/.claude.json to skip the onboarding wizard
CLAUDE_JSON="$HOME/.claude.json"
ONBOARDING_FIELDS='{
  "hasCompletedOnboarding": true,
  "lastOnboardingVersion": "2.1.63",
  "shiftEnterKeyBindingInstalled": true
}'

if [ ! -f "$CLAUDE_JSON" ]; then
  echo "$ONBOARDING_FIELDS" > "$CLAUDE_JSON"
elif command -v jq &>/dev/null; then
  jq ". + $ONBOARDING_FIELDS" "$CLAUDE_JSON" > "$CLAUDE_JSON.tmp" && mv "$CLAUDE_JSON.tmp" "$CLAUDE_JSON"
fi
