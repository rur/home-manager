#!/bin/zsh

export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export XDG_DATA_DIRS="$HOME/.nix-profile/share:${XDG_DATA_DIRS:-/usr/local/share:/usr/share}"

# Disable console start/stop: makes ^S and ^Q go through
if [[ -t 0 ]]; then
  stty -ixon
fi

# prevent ctrl-d closing terminal window
set -o ignoreeof

## Colored manpages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;91m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;93m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;92m'

## Utilities
# go back n directories
function b {
    str=""
    count=0
    while [ "$count" -lt "$1" ];
    do
        str=$str"../"
        let count=count+1
    done
    cd $str
}

# extract files: depends on zip, unrar and p7zip
function ex {
    if [ -f $1 ] ; then
      case $1 in
        *.tar.bz2)   tar xjf $1     ;;
        *.tar.gz)    tar xzf $1     ;;
        *.bz2)       bunzip2 $1     ;;
        *.rar)       unrar e $1     ;;
        *.gz)        gunzip $1      ;;
        *.tar)       tar xf $1      ;;
        *.tbz2)      tar xjf $1     ;;
        *.tgz)       tar xzf $1     ;;
        *.zip)       unzip $1       ;;
        *.Z)         uncompress $1  ;;
        *.7z)        7z x $1        ;;
        *)     echo "'$1' cannot be extracted via ex()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}

# mkdir && cd
function mkcd {
  mkdir -p "$1" && cd "$1";
}

# find or create tmux session
function tat {
  name=$(basename `pwd` | sed -e 's/\.//g')

  if tmux ls 2>&1 | grep "$name"; then
    tmux attach -t "$name"
  elif [ -f .envrc ]; then
    direnv exec / tmux new-session -s "$name"
  else
    tmux new-session -s "$name"
  fi
}

# find and edit
function find_and_edit() {
  if test -d .git
  then
    SOURCE="$(git ls-files)"
  else
    SOURCE="$(find . -type f)"
  fi
  files="$(fzf --preview='bat --color=always --paging=never --style=changes {} | head -$FZF_PREVIEW_LINES' --select-1 --multi --query="$@" <<< "$SOURCE")"
  if [[ "$?" != "0" ]]
  then
    return 1
  fi
  vim $files
}

function find_git_branch() {
  branch="$(git branch --format '%(refname:short)' | fzf --select-1 --multi --query="$@")"
  if [[ -n "$branch" ]]; then
    git checkout "$branch"
  fi
}

function scml() {
  if [[ -n "$ZSH_VERSION" ]]; then
    # zsh-specific array splitting
    locations_arr=( ${(s/,/)CODE_SEARCH_LIST} )
  else
    # bash-compatible approach
    IFS=',' read -ra locations_arr <<< "$CODE_SEARCH_LIST"
  fi
  if [[ "${#locations_arr[@]}" == 0 ]]; then
    echo "no CODE_SEARCH_LIST defined"
    return 1
  fi
  echo $(find ${locations_arr[@]} -name "README.*" | xargs -I{} dirname {} | fzf -q "$1")
}

function scm() {
  location=$(scml "$1")
  if [[ -d "${location}" ]]; then
    cd "${location}"
    tmux rename-window "$(basename "${location}")" || true # ignore failure
  else
    return 1
  fi
}
