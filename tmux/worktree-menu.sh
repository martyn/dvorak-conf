#!/usr/bin/env bash
# tmux menu of king_alfred worktrees -> open/reuse a window rooted in each.
# Transient Claude worktrees (agent-*, wf_*) are noise and get filtered out.
set -euo pipefail

REPO="$HOME/dev/kestrel/Archicheck/king_alfred"
keys=(1 2 3 4 5 6 7 8 9 0 a o e u i d p g c r l m w v z)

args=(display-menu -T "#[align=centre,bold] worktrees " -x C -y C)
i=0
while IFS=$'\t' read -r path branch; do
  [[ "$path" == *"/.claude/worktrees/agent-"* ]] && continue
  [[ "$(basename "$path")" == wf_* ]] && continue
  [[ "$(basename "$path")" == factory-w* ]] && continue
  name="$(basename "$path")"
  name="${name#ka-}"
  key="${keys[$i]:-}"
  [[ -z "$key" ]] && break
  args+=("$name  #[fg=#565f89]$branch" "$key" "new-window -S -n '$name' -c '$path'")
  ((i++)) || true
done < <(git -C "$REPO" worktree list --porcelain | awk '
  /^worktree /  {wt=substr($0,10)}
  /^branch /    {b=$2; sub("refs/heads/","",b); print wt "\t" b}
  /^detached$/  {print wt "\tdetached"}')

if [[ "${1:-}" == "--dry-run" ]]; then
  printf '%s\n' "${args[@]}"
  exit 0
fi
exec tmux "${args[@]}"
