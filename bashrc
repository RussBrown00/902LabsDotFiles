#
# Set file open limit
ulimit -n 2048

alias whynosleep="pmset -g assertions | egrep '(PreventUserIdleSystemSleep|PreventUserIdleDisplaySleep|InternalPreventDisplaySleep)'"
