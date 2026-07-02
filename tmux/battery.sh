#!/usr/bin/env bash
# Native Linux battery readout for the tmux status bar.
bat=/sys/class/power_supply/BAT0
[ -d "$bat" ] || exit 0

cap=$(< "$bat/capacity")
status=$(< "$bat/status")

case "$status" in
  Charging)         icon="+" ;;   # plugged in, filling
  Full)             icon="✓" ;;   # topped off
  "Not charging")   icon="~" ;;   # plugged but held
  *)                icon="-" ;;   # on battery
esac

# Color thresholds (tokyonight-ish): green > yellow > red
if   [ "$cap" -ge 60 ]; then col="#9ece6a"
elif [ "$cap" -ge 25 ]; then col="#e0af68"
else                        col="#f7768e"
fi

# single literal % — tmux >=3.2 no longer strftime-expands #() output
printf '#[fg=%s]%s %s%%' "$col" "$icon" "$cap"
