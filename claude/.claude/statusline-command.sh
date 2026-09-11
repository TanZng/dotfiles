#!/usr/bin/env bash

input=$(cat)

cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // empty')
model=$(echo "$input" | jq -r '.model.display_name // empty')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
git_worktree=$(echo "$input" | jq -r '.workspace.git_worktree // empty')
worktree_branch=$(echo "$input" | jq -r '.worktree.branch // empty')
vim_mode=$(echo "$input" | jq -r '.vim.mode // empty')
cost_usd=$(echo "$input" | jq -r '.cost.total_cost_usd // empty')

RESET="\033[0m"
BOLD="\033[1m"
DIM="\033[2m"
BLUE="\033[34m"
CYAN="\033[36m"
GREEN="\033[32m"
YELLOW="\033[33m"
MAGENTA="\033[35m"
RED="\033[31m"
WHITE="\033[37m"

home="$HOME"
if [ -n "$cwd" ]; then
	short_cwd="${cwd/#$home/~}"
else
	short_cwd="$(pwd | sed "s|^$home|~|")"
fi

git_branch=""
if [ -n "$worktree_branch" ]; then
	git_branch="$worktree_branch"
elif [ -n "$git_worktree" ]; then
	git_branch="$git_worktree"
else
	git_branch=$(git -C "$cwd" branch --show-current 2>/dev/null)
fi

used_int=$(printf "%.0f" "${used_pct:-0}")
if [ "$used_int" -ge 50 ]; then
	ctx_color="$RED"
else
	ctx_color="$YELLOW"
fi
ctx_segment=" ${ctx_color}${used_int}%%${RESET}"

cost_segment=""
if [ -n "$cost_usd" ]; then
	cost_rounded=$(printf "%.2f" "$cost_usd")
	cost_segment=" ${GREEN}\$${cost_rounded}${RESET}"
fi

vim_segment=""
if [ -n "$vim_mode" ]; then
	case "$vim_mode" in
	INSERT) vim_color="$GREEN" ;;
	NORMAL) vim_color="$BLUE" ;;
	VISUAL*) vim_color="$MAGENTA" ;;
	*) vim_color="$WHITE" ;;
	esac
	vim_segment=" ${vim_color}[${vim_mode}]${RESET}"
fi

printf "${BLUE} ${short_cwd}${RESET}"

if [ -n "$git_branch" ]; then
	printf " ${MAGENTA} ${git_branch}${RESET}"
fi

if [ -n "$model" ]; then
	printf " ${DIM}${RESET}${WHITE}󰚩 ${model}${RESET}"
fi

printf "${ctx_segment}"
printf "${cost_segment}"
printf "${vim_segment}"
