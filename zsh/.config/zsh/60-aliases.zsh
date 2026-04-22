# Aliases

# File Listing
alias la='lsd -lha --group-dirs=first'
alias ls='lsd --group-dirs=first -a'

# Tools
alias fz="fzf-noempty --bind 'tab:toggle,shift-tab:toggle+beginning-of-line+kill-line,ctrl-j:toggle+beginning-of-line+kill-line,ctrl-t:top' --color=light -1 -m"
alias glow='glow -s ~/.config/glow/${CATPPUCCIN_THEME}.json'
alias tree='tree -a -I .git'
alias k='kubectl'

# Editors
alias vim='nvim'
alias vi='nvim'

# Git
alias g='git'
alias gp='git pull origin $(git rev-parse --abbrev-ref HEAD)'
alias mr='git push origin $(git rev-parse --abbrev-ref HEAD)'

# Terminal
alias rt='refresh-theme'

# BAT
alias cat="bat"
