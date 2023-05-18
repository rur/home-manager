if [[ -o interactive ]]; then
  . "$HOME/.nix-profile/share/git/contrib/completion/git-prompt.sh"

  setopt PROMPT_SUBST

  autoload colors && colors

  function print_term_color_codes {
    local color=16;
    while [ $color -lt 245 ]; do
        echo -e "$color: \\033[38;5;${color}mhello\\033[48;5;${color}mworld\\033[0m"
        ((color++));
    done
  }

  function is_suspended_jobs {
    jobs | grep -o 'suspended' &> /dev/null
  }

  function __prev_cmd_status {
    red='%F{203}'
    bg_red='%K{203}'
    black='%F{black}'
    white='%F{white}'
    WHITE='%B%F{white}'
    if [[ $1 == 0 ]]; then
      echo "%F{white}%K{white}█%F{black}ok%{%b%F{white}%K{white}█%k%f%}"
    else
      echo "${red}${bg_red}█%F{black}error: %?%{%b${red}${bg_red}█%k%f%}"
    fi
  }

  __print_fancy_prompt ()
  {
    ## Fancy prompt
    # see color code guide https://unix.stackexchange.com/questions/124407/what-color-codes-can-i-use-in-my-bash-ps1-prompt/124409#124409
    red='%F{203}'
    bg_red='%K{203}'
    RED='%B%F{red}'
    blue='%F{81}'
    BLUE='%B%F{81}'
    green='%F{119}'
    GREEN='%B%F{119}'
    magenta='%F{201}'
    MAGENTA='%B%F{201}'
    white='%F{white}'
    WHITE='%B%F{white}'
    grey='%F{243}'
    orange='%F{221}'
    NC='%f%b'

    _newline=$'\n'

    PROMPT_INFO="%{${grey}%}[%t]%{${NC}%} %{${green}%}%n%{${NC}%} %{${blue}%}%~"
    PROMPT_DIRENV="\$(is_direnv_dir && echo \"*\")"
    PROMPT_GIT="${orange}\$(__git_ps1)"
    PROMPT_FOOTER="${_newline}%{\$(is_suspended_jobs && echo \"${magenta}\" || echo \"${grey}\")%}↳ %{${WHITE}%}$ %{${NC}%}"
      
     echo "${PROMPT_INFO}${PROMPT_DIRENV}${PROMPT_GIT} ${PROMPT_FOOTER}"
  }
  PROMPT=`__print_fancy_prompt`
  
  __print_fancy_right_prompt ()
  {
    _lineup=$'\e[1A'
    _linedown=$'\e[1B'
    PROMPT_STATUS="\$(__prev_cmd_status \${?})"
    echo "%{${_lineup}%}${PROMPT_STATUS}%{${_linedown}%}"
  }
  RPROMPT=`__print_fancy_right_prompt`

fi

