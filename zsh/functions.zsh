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

function rename_tmux_window {
  if [[ -n "$TMUX" ]]; then
    # Don't change the name automatically if it's the first window
    if [ "$(tmux display-message -p '#I')" != "0" ]; then
      # Determine if the current directory is under 'workspace'
      if [[ "$PWD" == *"/workspace/"* ]]; then
        local new_name=$(basename "$PWD")
      else
        # Optional: Define how to handle other directories
        local new_name=$(basename "$PWD")  # or some other logic
      fi

      # Set the new name to the tmux window
      echo -ne "\033k${new_name}\033\\"
      tmux rename-window "$new_name"

      # Update tmux environment variable (optional)
      tmux setenv "$(tmux display -p 'TMUX_PWD_#D')" "$PWD"
    fi
  fi
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

function rereplace() {
	echo "Running: ag --hidden -l $1 | xargs sed -i \"\" \"s/$1/$2/g\""
	ag --hidden -l $1 | xargs sed -i "" "s/$1/$2/g"
	ag --hidden $1
}

# AWK Commands
function aprint() {
	awk "{print \$${1:-1}}";
}

# Cleanup all VIM artifacts
function vimclean() {
	find ~/.vim/tmp/ctrp_cache -name "*" | tail -n +2 | xargs rm -Rf;
	find ~/.vim/tmp/backup -type f -name "*" | tail -n +2 | xargs rm;
	find ~/.vim/tmp/swap -type f -name "*" | tail -n +2 | xargs rm;
	find ~/.vim/tmp/undo -type f -name "*" | tail -n +2 | xargs rm;
	find ~/.vim/view -type f -name "*" | tail -n +2 | xargs rm;
}

function nvimclean() {
	find ~/.tmp/neovim/undo -name "*" | tail -n +2 | xargs rm -Rf;
	find ~/.tmp/neovim/backup -name "*" | tail -n +2 | xargs rm -Rf;
	find ~/.tmp/neovim/swap -name "*" | tail -n +2 | xargs rm -Rf;
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

if [ -f "/usr/bin/docker" ] || [ -f "/usr/local/bin/docker" ]; then
	alias docker-ps='docker ps'
	alias docker-psa='docker ps -a'

	containerip() {
		docker inspect $1 | grep "\"IPAddress\"" | head -n 1 | cut -d':' -f2 | cut -d'"' -f2
	}

	if [ ! -z "$UA_UTILS" ]; then
		alias dockerbuild="$UA_UTILS/docker/build.sh"
		alias dockerbuild-ab="$UA_UTILS/docker/build.sh armourbox-master-latest"
	fi

	function docker-rm {
		docker rm $@ $(docker ps -a -q)
	}

	function docker-shell {
    docker run --rm -it --entrypoint=bash $@
	}

	function docker-rs {
		docker ps -qaf "name=$1" | xargs docker restart
	}

	docker-clean() {
		docker rm -f $(docker ps -a -q)
		docker rmi $(docker images -q -f dangling=true)
		docker volume rm $(docker volume ls -qf dangling=true)
	}
fi

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

function containerid() {
	docker ps | grep $1 | aprint 1
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

function git-clone-remote {
	ORIGIN=$(git remote -v | grep origin | head -n 1 | awk '{print $2}')
	NEW=${ORIGIN/:$1/:$2}
	git remote add $2 $NEW
	git fetch $2
}

function json {
	echo $1 | python -m json.tool
}

function greum {
	HASH=$(git ll | head -n 1 | awk '{print $1}')
	git fu; git unm; git ms $HASH;
}

function killbyport {
	if [ -z $1 ]; then
		echo "Please add an argument for port"
	else
		PORT=$1
		lsof -t -i:$PORT | xargs kill &> /dev/null && echo "Closed Process runnin on $PORT" || echo "Nothing Running on $PORT"
	fi
}

function js-code-stats {
  docker run --rm -v $1:/tmp aldanial/cloc --3 --match-f='.*\.jsx?' /tmp
}

function sys-alert {
  MSG="display notification \"$1\""

	if [ ! -z $2 ]; then
	  MSG="$MSG with title \"$2\""
  fi

  osascript -e "$MSG"
}

function mkenv {
  ENVDIR=$(basename $(pwd))
  echo $ENVDIR
	mkvirtualenv -p $(pyenv which python) $ENVDIR
}

function reflogmore {
  git reflog --pretty='format:%C(auto)%h (%s, %ad)' | uniq | head -n 10 | while read commit_hash; do
    echo "Changes for reflog entry with commit $commit_hash:"
    git show --pretty="" --name-only $commit_hash | head
    echo ""
    echo ""
  done
}
