function zprofile() {
  code -w ~/.zprofile
  source ~/.zprofile
  echo ".zprofile reloaded successfully."
}

function zshrc() {
  code -w ~/.zshrc
  source ~/.zshrc
  echo ".zshrc reloaded successfully."
}