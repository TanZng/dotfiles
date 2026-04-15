# Theme management

# Refresh theme by re-detecting system appearance
function refresh-theme() {
	# Re-detect macOS appearance
	if [[ ! ($(defaults read -g AppleInterfaceStyle 2>/dev/null) =~ 'Dark') ]]; then
		export CATPPUCCIN_THEME="Catppuccin-light"
		export FZF_DEFAULT_OPTS=" --ansi --color=bg+:#ccd0da,bg:#eff1f5,spinner:#dc8a78,hl:#d20f39,fg:#4c4f69,header:#d20f39,info:#8839ef,pointer:#dc8a78,marker:#dc8a78,fg+:#4c4f69,prompt:#8839ef,hl+:#d20f39"
		export FZF_PREVIEW_PREVIEW_BAT_THEME="Catppuccin-light"
	else
		export CATPPUCCIN_THEME="Catppuccin-dark"
		export FZF_DEFAULT_OPTS=" --ansi --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8,fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc,marker:#f5e0dc,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#74C7EC"
		export FZF_PREVIEW_PREVIEW_BAT_THEME="Catppuccin-dark"
	fi

	# Reload kitty theme in all windows
	kitten themes --reload-in=all "${CATPPUCCIN_THEME}-tanx"
}

# Auto-detect theme on shell startup
refresh-theme
