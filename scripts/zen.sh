#!/bin/sh
# Toggle zen mode: zero gaps/padding/borders + hide polybar.
# Uses `polybar-msg cmd hide/show` (real X11 unmap/map → picom fades it via
# `fading = true`) instead of pkill/launch, so polybar's process stays alive
# and its stacking position above kitty is preserved.

STATE="${XDG_RUNTIME_DIR:-/tmp}/bspwm-zen"
KEYS="window_gap border_width top_padding bottom_padding left_padding right_padding"

if [ -f "$STATE" ]; then
  while IFS='=' read -r k v; do
    [ -n "$k" ] && bspc config "$k" "$v"
  done < "$STATE"
  rm -f "$STATE"
  polybar-msg cmd show >/dev/null
  sleep 0.1
  ~/scripts/polybar-raise.sh
else
  : > "$STATE"
  for k in $KEYS; do
    printf '%s=%s\n' "$k" "$(bspc config $k)" >> "$STATE"
  done
  for k in $KEYS; do
    bspc config "$k" 0
  done
  polybar-msg cmd hide >/dev/null
fi
