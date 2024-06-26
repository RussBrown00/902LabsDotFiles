# Colorize output, add file type indicator, and put sizes in human readable format
alias ls='ls -GFh'

# Same as above, but in long listing format
alias ll='ls -GFhl'

alias rake='noglob rake'
alias bower='noglob bower'

# Launch chrome with remote debugging port on
alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --remote-debugging-port=9222'

#GREP
alias grep='grep --color'
alias grepn='grep -n --color'

#GIT
alias g='git'
alias gt='git'
alias got='git'
alias gut='git'

# Kubernetes
alias k='kubectl'
alias k8='kubectl'

# npm
alias npmpub='mv .npmrc ._npmrc; npm publish; mv ._npmrc .npmrc;'
alias p='pnpm'

#OTHER
alias weather='curl -4 http://wttr.in'
alias uuid="python -c 'import sys,uuid; sys.stdout.write(uuid.uuid4().hex)' | pbcopy && pbpaste && echo"
alias cleardns="sudo killall -HUP mDNSResponder"

#VIM
alias clear-vim-swap="find ~/.vim/tmp -type f -name \"\.*sw[klmnop]\" -delete"
alias fzfp='vim `fzf --preview="cat {}" --preview-window=right:70%:wrap`'

alias flush-dns="sudo killall -HUP mDNSResponder; sudo dscacheutil -flushcache; SLEEP 2; echo macOS DNS Cache Reset"

alias copy="tr -d '\n' | pbcopy"

alias epoch="date '+%s'"

function epochc() {
  ts=$(epoch | tr -d '\n')
  echo "$ts" | tr -d '\n' | pbcopy
  echo "$ts"
}

if command -v nvim 1>/dev/null 2>&1; then
  alias vim="$(which nvim)"
fi
