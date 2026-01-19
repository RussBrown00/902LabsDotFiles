# chpwd -- Run every folder change
function auto_local_bin_folder {
  # Remove the previous .bin directory from PATH if it was added
  if [[ -n $PREV_BIN ]]; then
    PATH=${PATH//:$PREV_BIN/}
  fi

  # Add current directory's .bin to PATH if it exists
  if [[ -d .bin ]]; then
    export PATH="$PATH:$PWD/.bin"
    PREV_BIN="$PWD/.bin"
  else
    PREV_BIN=""
  fi
}

# Run once
auto_local_bin_folder

# Add chpwd to the hook functions array to ensure it runs on directory change
chpwd_functions+=(auto_local_bin_folder)

function precmd {
  if [ -d "$FNM_PATH" ]; then
    eval "`fnm env`"
  fi

  # vcs_info
  # Put the string "hostname::/full/directory/path" in the title bar:
  echo -ne "\e]2;$PWD\a"

  # Put the parentdir/currentdir in the tab
  echo -ne "\e]1;$PWD:h:t/$PWD:t\a"
}

function set_running_app {
  printf "\e]1; $PWD:t:$(history $HISTCMD | cut -b7- ) \a"
}

function preexec {
  set_running_app
}

function postexec {
  set_running_app
}
