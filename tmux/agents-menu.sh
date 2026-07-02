#!/usr/bin/env bash
# tmux mission control: menu of every claude pane across all sessions, with the
# live pane_title (⠂ working · ✳ waiting) as the label. Select one to jump to it.
set -euo pipefail

keys="aoeuhtns1234567890"   # dvorak home row first
n=0
args=(display-menu -T "#[align=centre,bold] agents " -x C -y C)

while IFS='|' read -r sess win pane wname cmd title; do
    [[ "$cmd" == "claude" ]] || continue
    key="${keys:$n:1}"
    n=$((n + 1))
    label="$(printf '%s:%s %s — %.55s' "$sess" "$win" "$wname" "$title")"
    args+=("$label" "$key" "switch-client -t '$sess'; select-window -t '$sess:$win'; select-pane -t '$sess:$win.$pane'")
done < <(tmux list-panes -a -F '#{session_name}|#{window_index}|#{pane_index}|#{window_name}|#{pane_current_command}|#{pane_title}')

if (( n == 0 )); then
    tmux display-message "no claude panes running"
else
    tmux "${args[@]}"
fi
