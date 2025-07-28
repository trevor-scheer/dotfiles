alias jdsw="just dev-start-web"
alias mdsw="jdsw"

csssh() {
  temp="___setupCodespaceSSH.temp.js"
  gh api repos/VantaInc/obsidian/contents/scripts/setupCodespaceSSH.js \
    --jq '.content' | base64 -d > "$temp"
  node "$temp"
  rm "$temp"
}

newcs() {
  cs_id=$(gh cs create -R VantaInc/obsidian)
  
  echo -n "Codespace $cs_id created, waiting for it to be ready..."
  status=""
  while [ "$status" != "Available" ]; do
    sleep 1
    status=$(gh cs list | grep $cs_id | sed 's/.*obsidian//' | awk '{print $2}')
    echo -n "."
  done
  echo " Codespace ready, setting up SSH"
  
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

turboclient() {
  turbo -F @vanta/web-client "$@"
}
alias tc=turboclient

alias dr="make dev-replace"
alias drw="make dev-replace web-client"
alias drs="docker container restart obsidian-web-client.internal-1"
alias logs="make dev-watch-logs"
alias yww="yarn workspace @vanta/web-client"

echo "✅ Vanta utilities loaded."