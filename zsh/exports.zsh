# Currently this path is appendend to dynamically when picking a ruby version
export PATH=bin:script:~/.rbenv/bin:~/.bin:node_modules/.bin:/usr/local/sbin:/usr/local/bin:/usr/local/share/npm/bin:~/.cabal/bin:$HOME/Library/Haskell/bin:$PATH
export PATH=$PATH:/opt/boxen/homebrew/opt/go/libexec/bin

CURRENT_DIRECTORY=$(pwd)

# chpwd -- Run every folder change
function chpwd {
  if [ -d "$CURRENT_DIRECTORY/.bin" ]; then
	  export PATH="$PATH:$CURRENT_DIRECTORY/.bin"
  fi

  if [ -r $PWD/.zsh_config ]; then
    source $PWD/.zsh_config
  fi
}

# Slack Dev Menu
export SLACK_DEVELOPER_MENU=true

# Setup terminal, and turn on colors
export LANG=en_US.UTF-8
export EDITOR=nvim
export KUBE_EDITOR=nvim
export TERM=xterm-256color
export CLICOLOR=1
export LSCOLORS=Gxfxcxdxbxegedabagacad
export LESS='--ignore-case --raw-control-chars'
export PAGER='most'

# This resolves issues install the mysql, postgres, and other gems with native non universal binary extensions
export ARCHFLAGS='-arch x86_64'

export LESS='--ignore-case --raw-control-chars'
export PAGER='most'
export EDITOR='vim'
# export PYTHONPATH=/usr/local/lib/python2.6/site-packages

# CTAGS Sorting in VIM/Emacs is better behaved with this in place
export LC_COLLATE=C

LS_COLORS='di=1;34:fi=0:ln=31:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ex=1;36:*.rpm=90:*.tar=1;31'
export LS_COLORS

# ZFZ / RipGrep Settings
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'

#Python (expects pyenv)
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# export PYTHONPATH=$(pyenv which python)
