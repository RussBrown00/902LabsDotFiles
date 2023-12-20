# HISTORY
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

setopt hist_ignore_all_dups

bindkey '^R' zaw-history
