#
# Set file open limit
ulimit -n 2048

#
# Console Settings
export LANG=en_US.UTF-8
export EDITOR=vim
export TERM=xterm-256color

#
# Setup file list defaults
alias ls='ls -ahl --color=auto'
LS_COLORS='di=1;34:fi=0:ln=31:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ex=1;36:*.rpm=90:*.tar=1;31'
export LS_COLORS
