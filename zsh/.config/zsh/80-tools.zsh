# Tool-specific configurations

# AWSume Configuration
alias awsume="source awsume"

# FZF Configuration
source <(fzf --zsh)
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'

# Preview file or directory
export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always --theme=\"\$BAT_THEME\" {} 2>/dev/null ||  tree -L 2 -C {} 2>/dev/null || ls -la {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# CTRL-Y to copy the command into clipboard using pbcopy
export FZF_CTRL_R_OPTS="
  --preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

# Nix Package Manager
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
	. '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi

# asdf Version Manager
if [ -d "$HOME/.asdf" ]; then
	export ASDF_DATA_DIR="$HOME/.asdf"
	export PATH="$ASDF_DATA_DIR/shims:$PATH"
fi
