rh() {
  rm ~/.zsh_history
  exec zsh
}

bz() {
  setsid "$@" &> /dev/null < /dev/null
}
