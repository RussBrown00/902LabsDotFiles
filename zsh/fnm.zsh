# Fast Node Manager
FNM_PATH="/usr/local/opt/fnm/bin"

if [ -d "$FNM_PATH" ]; then
  eval "`fnm env`"
else
  curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell
  eval "`fnm env`"
fi

# Choose correct node on init
fnm use 2>/dev/null || fnm use default &>/dev/null

# Choose correct node on CD
eval "$(fnm env --use-on-cd)"

# Setup Grok
alias grok=$(fnm use default &> /dev/null; which grok)

# Used by apps like VIM/NVIM
DEFAULT_NODE_PATH=$(fnm use default &> /dev/null; which node)
