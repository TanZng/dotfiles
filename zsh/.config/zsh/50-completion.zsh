# Autoload functions and completions

# Autoload functions
autoload -Uz zmv

# Define functions and completions
function md() { [[ $# == 1 ]] && mkdir -p -- "$1" && cd -- "$1"; }
compdef _directories md

# Define named directories: ~w <=> Windows home directory on WSL
[[ -z $z4h_win_home ]] || hash -d w=$z4h_win_home

# AWSume completion
fpath=(~/.awsume/zsh-autocomplete/ $fpath)
