autoload -U compinit
compinit
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'

setopt correct

export HISTSIZE=2000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups
setopt hist_ignore_space

setopt autocd
setopt extendedglob

alias l="ls -lah"
alias ll="ls -lh"
alias okular="setsid okular"

export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

source $HOME/.dotfiles/*.zsh

autoload -Uz vcs_info
zstyle ':vcs_info:git*' formats '[%b] '

precmd() { vcs_info }
setopt prompt_subst

if [ $UID -eq 0 ]; then
  local user_prompt=$'\U26A0\UFE0F'" %F{red}%n%f"
else
  local user_prompt="%F{green}%n%f"
fi

export PS1='$user_prompt@%M %F{cyan}%2~%f ${vcs_info_msg_0_}%(?..%F{red}[%?]%f )%# '

if [ ! -f $HOME/server ] && [ ! $UID -eq 0 ]; then
  export GPG_TTY="$(tty)"
  export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
  gpgconf --launch gpg-agent
  gpg-connect-agent updatestartuptty /bye > /dev/null
  gpg-connect-agent "scd serialno" "learn --force" /bye > /dev/null
fi
