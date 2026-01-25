# Fast Node Manager
FNM_PATH="~/.fnm/bin"

if [ -n "$(which fnm)" ]; then
  eval "`fnm env`" &> /dev/null;
else
  mkdir -p ~/.fnm/bin
  curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell
  fnm --fnm-dir ~/.fnm

  # setup default node version
  fnm install 25.2.1
  fnm alias 25.2.1 default

  # Setup hook
  eval "`fnm env`" &> /dev/null;
fi

# Choose correct node on init
fnm use 2>/dev/null || fnm use default &> /dev/null

# Choose correct node on CD
eval "$(fnm env --use-on-cd &> /dev/null)"

# Used by apps like VIM/NVIM
DEFAULT_NODE_PATH=$(fnm use default &> /dev/null; which node)

# Setup Grok
# alias grok=$(fnm use default &> /dev/null; which grok)

# Setup grok using the fixed branch of superagent-ai/grok-cli 19af6ac (PR#132)
alias grok="$DEFAULT_NODE_PATH ~/workspace/grok-cli/dist"
