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
fnm use --install-if-missing 2>/dev/null || fnm use --install-if-missing default &> /dev/null

# Choose correct node on CD
eval "$(fnm env --install-if-missing --use-on-cd &> /dev/null)"

# Used by apps like VIM/NVIM
DEFAULT_FNM_MULTISHELL_PATH=$(fnm use default &> /dev/null; fnm env | grep FNM_MULTISHELL_PATH | cut -d'"' -f2)

# Setup Cline
function cline {
  "$DEFAULT_FNM_MULTISHELL_PATH/bin/cline" "$@"
}

# Setup Agent Skills
function grok {
  "$DEFAULT_FNM_MULTISHELL_PATH/bin/node ~/workspace/grok-cli/dist" "$@"
}

# Setup Agent Skills
function skills {
  "$DEFAULT_FNM_MULTISHELL_PATH/bin/skills" "$@"
}
