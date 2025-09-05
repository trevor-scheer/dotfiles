alias jdsw="just dev-start-web"
alias mdsw="jdsw"

newcs() {
  cs_id=$(gh cs create -R VantaInc/obsidian)
  
  echo -n "Codespace $cs_id created, waiting for it to be ready..."
  cs_status=""
  while [ "$cs_status" != "Available" ]; do
    sleep 1
    cs_status=$(gh cs list | grep $cs_id | sed 's/.*obsidian//' | awk '{print $2}')
    echo -n "."
  done
  echo "\nCodespace ready, setting up SSH"
  
  cs_configure_ssh_launch_cursor
}

opencs() {
  cs_id=$(gh cs list --json name,displayName,state,gitStatus,lastUsedAt | \
    jq -r 'sort_by(.lastUsedAt) | reverse | .[] | "\(.name) \(.gitStatus.ref) (\(.state))"' | \
    fzf --prompt="Select codespace: " | \
    cut -d' ' -f1)

  if [ -n "$cs_id" ]; then
    echo "Starting codespace: $cs_id"
    # this starts the codespace and there isn't a better way (dump the output, not interesting)
    gh cs ports --codespace "$cs_id" > /dev/null 2>&1

    echo "Codespace ready, setting up SSH"
    cs_configure_ssh_launch_cursor
  fi
}

cs_configure_ssh_launch_cursor() {
  gh api repos/VantaInc/obsidian/contents/scripts/setupCodespaceSSH.js --jq '.content' | base64 -d | node - > /dev/null 2>&1
  echo "Finished running setupCodespaceSSH.js"
  echo "Launching cursor..."
  cursor -n --folder-uri "vscode-remote://ssh-remote+${cs_id}.github.dev/workspaces/obsidian"
}

stopcs() {
  gh api repos/VantaInc/obsidian/contents/scripts/shutdownCodespaces.cjs \
    --jq '.content' | base64 -d | node -
}

turboclient() {
  turbo -F @vanta/web-client "$@"
}

yarnweb() {
  yarn workspace @vanta/web-client "$@"
}

install_extensions() {
  cat .devcontainer/devcontainer.json \
    | npx strip-json-comments-cli \
    | jq -r '.customizations.vscode.extensions[]' \
    | while read -r extension; do
        cursor --install-extension "$extension" || echo "Failed to install extension: $extension"
      done
}

# if in codespaces, install extensions
if [ -n "$CODESPACES" ]; then
  install_extensions
fi

alias tc=turboclient

alias dr="just dev-replace"
alias drw="just dev-replace web-client"
alias drs="docker container restart obsidian-web-client.internal-1"
alias logs="just dev-watch-logs"
alias jpp="just post-pull"
alias yww="yarnweb"

function codemod() {
  # ./build-tools/vsx.sh scripts/refactoring-tools/src/gql/gql-tada-codemod.ts "$@"
  node ./parcel-plugins/parcel-transformer-gqlts/bin/index.js "**/src/**/*.(ts|tsx)"
}

echo "✅ Vanta utilities loaded."