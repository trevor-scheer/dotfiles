alias jdsw="just dev-start-web"
alias mdsw="jdsw"

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

alias tc=turboclient

alias dr="just dev-replace"
alias drw="just dev-replace web-client"
alias drs="docker container restart obsidian-web-client.internal-1"
alias logs="just dev-watch-logs"
alias jpp="just post-pull"
alias yww="yarnweb"

