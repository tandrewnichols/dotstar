#!/usr/bin/env bash
# tmux status-right: dim "<repo>:" + bright "<branch>" for a pane's cwd.
# Prints nothing outside a repo.

dir=${1:-$PWD}

# --git-common-dir, unlike --show-toplevel, resolves a linked worktree back to the
# main clone — so every worktree of a repo reports the repo's name, not the card's.
common=$(git -C "$dir" rev-parse --path-format=absolute --git-common-dir 2>/dev/null) || exit 0
repo=$(basename "$(dirname "$common")")

branch=$(git -C "$dir" symbolic-ref --quiet --short HEAD 2>/dev/null) ||
  branch=$(git -C "$dir" rev-parse --short HEAD 2>/dev/null)

# Trailing space lives here, not in the conf, so a non-repo pane collapses cleanly.
if [[ -n $branch ]]; then
  printf '#[fg=colour243]%s:#[fg=colour215,bold]%s ' "$repo" "$branch"
else
  printf '#[fg=colour243]%s ' "$repo"
fi
