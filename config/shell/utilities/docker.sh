#!/bin/zsh
alias ld="lazydocker"
alias dcu="docker compose up -d"
alias dcd="docker compose down"
alias dcdu="dcd && dcu"
alias dc="docker compose"

dcl() {
  if [ -n "$1" ]; then
    docker compose logs -f "$1"
  else
    docker compose logs -f
  fi
}