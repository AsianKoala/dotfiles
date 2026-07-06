#!/usr/bin/env bash
# pywal-derived colors for sketchybar, sourced by sketchybarrc.
# Converts pywal hex (#RRGGBB) to sketchybar's 0xAARRGGBB. Falls back to the
# hydrangea palette if the wal cache isn't present yet.

_c() { printf '0x%s%s' "$1" "${2#\#}"; }   # $1=alpha(hex) $2=#RRGGBB -> 0xAARRGGBB

if [ -f "$HOME/.cache/wal/colors.sh" ]; then
  # shellcheck disable=SC1091
  . "$HOME/.cache/wal/colors.sh"
  export BAR_COLOR=$(_c e6 "$background")     # translucent bar
  export ICON_COLOR=$(_c ff "$foreground")
  export LABEL_COLOR=$(_c ff "$foreground")
  export ACCENT_COLOR=$(_c ff "$color6")      # vivid pink
  export SPACE_BG=$(_c 55 "$color6")          # active-space highlight
else
  export BAR_COLOR=0xe6170411
  export ICON_COLOR=0xffecd4e4
  export LABEL_COLOR=0xffecd4e4
  export ACCENT_COLOR=0xffea70b8
  export SPACE_BG=0x55ea70b8
fi
