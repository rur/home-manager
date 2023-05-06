# Helpers
# safe source
function safe_source {
  [ -f "$1" ] && source "$1"
}

# check if program is available
function has_program {
  hash $1 2>/dev/null
}

function is_direnv_dir {
  [[ -n "${DIRENV_DIR}" ]]
}

## Load direnv
has_program direnv && eval "$(direnv hook bash)"

# get an SSH Agent started
eval "$(ssh-agent -s)"

## Load secrets
safe_source "$HOME/.bash_secrets"

