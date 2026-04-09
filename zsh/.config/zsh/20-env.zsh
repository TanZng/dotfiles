# Environment variables

# GPG Configuration
export GPG_TTY=$TTY

# Editor Configuration
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi
