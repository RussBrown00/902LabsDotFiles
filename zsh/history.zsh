# History configuration
bindkey '^R' zaw-history

if [ -z "$HISTFILE" ]; then
  HISTFILE=$HOME/.zsh_history
fi

# Size of history
HISTSIZE=10000
SAVEHIST=10000

# # Show history
# case $HIST_STAMPS in
#   "mm/dd/yyyy") alias history='fc -fl 1' ;;
#   "dd.mm.yyyy") alias history='fc -El 1' ;;
#   "yyyy-mm-dd") alias history='fc -il 1' ;;
#   *) alias history='fc -l 1' ;;
# esac

# Configuration
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
