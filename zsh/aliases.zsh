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
alias got='git'
alias gut='git'

#Python
alias pythong='python'

#DOCKER
if [[ -f "/usr/bin/docker" ]]; then
	alias docker-rm='docker rm -f $(docker ps -a -q)'
	alias docker-ps='docker ps'
	alias docker-psa='docker ps -a'
fi
