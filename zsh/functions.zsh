function zsh_recompile {
  autoload -U zrecompile
  rm -f ~/.zsh/*.zwc
  [[ -f ~/.zshrc ]] && zrecompile -p ~/.zshrc
  [[ -f ~/.zshrc.zwc.old ]] && rm -f ~/.zshrc.zwc.old

  for f in ~/.zsh/**/*.zsh; do
    [[ -f $f ]] && zrecompile -p $f
    [[ -f $f.zwc.old ]] && rm -f $f.zwc.old
  done

  [[ -f ~/.zcompdump ]] && zrecompile -p ~/.zcompdump
  [[ -f ~/.zcompdump.zwc.old ]] && rm -f ~/.zcompdump.zwc.old

  source ~/.zshrc
}

function extract {
  echo Extracting $1 ...
  if [ -f $1 ] ; then
      case $1 in
          *.tar.bz2)   tar xjf $1  ;;
          *.tar.gz)    tar xzf $1  ;;
          *.bz2)       bunzip2 $1  ;;
          *.rar)       unrar x $1    ;;
          *.gz)        gunzip $1   ;;
          *.tar)       tar xf $1   ;;
          *.tbz2)      tar xjf $1  ;;
          *.tgz)       tar xzf $1  ;;
          *.zip)       unzip $1   ;;
          *.Z)         uncompress $1  ;;
          *.7z)        7z x $1  ;;
          *)        echo "'$1' cannot be extracted via extract()" ;;
      esac
  else
      echo "'$1' is not a valid file"
  fi
}

function ss {
  if [ -e script/server ]; then
    script/server $@
  else
    script/rails server $@
  fi
}

function sc {
  if [ -e script/console ]; then
    script/console $@
  else
    script/rails console $@
  fi
}

function trash () {
  local path
  for path in "$@"; do
    # ignore any arguments
    if [[ "$path" = -* ]]; then :
    else
      local dst=${path##*/}
      # append the time if necessary
      while [ -e ~/.Trash/"$dst" ]; do
        dst="$dst "$(date +%H-%M-%S)
      done
      /bin/mv "$path" ~/.Trash/"$dst"
    fi
  done
}

# OSX Specific Functions
if [[ "$OSTYPE" == "darwin"* ]]; then
	function alert {
		osascript -e 'tell app "System Events" to display dialog "'$1'"'
	}

	function md5sum {
		md5 $@ | awk '{print $NF}'
	}
fi

# DOCKER
if [ "$OSTYPE" != "darwin" ] && [ -f "/usr/bin/docker" ]; then
	function docker {
		sudo /usr/bin/docker $@
	}

	function docker-compose {
		sudo /usr/local/bin/docker-compose $@
	}
fi

function docker-pull {
	docker images | grep "$1" | awk '{print $1}' | xargs -L1 sudo docker pull
}

function chmod-files {
	if [ -z $1 ]; then
		PERM=644
	else
		PERM=$1
	fi

	find . -type f -exec chmod $PERM {} \;
}

function chmod-folders {
	if [ -z $1 ]; then
		PERM=755
	else
		PERM=$1
	fi

	find . -type d -exec chmod $PERM {} \;
}


