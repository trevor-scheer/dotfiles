#!/bin/zsh
alias ld="lazydocker"

dcl() {
  if [ -n "$1" ]; then
    docker compose logs -f "$1"
  else
    docker compose logs -f
  fi
}