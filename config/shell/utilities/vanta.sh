alias jdsw="just dev-start-web"
alias mdsw="jdsw"
alias dr="make dev-replace"
alias drw="make dev-replace web-client"
alias drs="docker container restart obsidian-web-client.internal-1"
alias logs="make dev-watch-logs"
alias yww="yarn workspace @vanta/web-client"

alias tc=turboclient
turboclient() {
  turbo -F @vanta/web-client "$@"
}