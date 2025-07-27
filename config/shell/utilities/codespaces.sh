#!/usr/bin/env zsh

csssh() {
  temp="___setupCodespaceSSH.temp.js"
  gh api repos/VantaInc/obsidian/contents/scripts/setupCodespaceSSH.js \
    --jq '.content' | base64 -d > "$temp"
  node "$temp"
  rm "$temp"
}

newcs() {
  cs_id=$(gh cs create -R VantaInc/obsidian)
  echo "Codespace created, waiting for it to be ready...(~40s arbitrarily)"
  sleep 40
  echo "Codespace ready, setting up SSH..."
  
  csssh
  
  cursor -n --folder-uri "vscode-remote://ssh-remote+${cs_id}.github.dev/workspaces/obsidian"
}

opencs() {
  echo "TODO"
}

stopcs() {
  temp="___shutdownCodespaces.temp.js"
  gh api repos/VantaInc/obsidian/contents/scripts/shutdownCodespaces.cjs \
    --jq '.content' | base64 -d > "$temp"
  node "$temp"
  rm "$temp"
}

echo "✅ Codespaces utilities loaded."