#!/usr/bin/env bash
# Refresh every space's label with the Nerd Font glyphs of the apps it holds.
# Triggered by yabai window signals (custom event windows_on_spaces) and by
# built-in space_change / front_app_switched events.
source "$CONFIG_DIR/icon_map.sh"

declare -A GLYPHS
while IFS='|' read -r sid app; do
  [ -z "$sid" ] && continue
  __icon_map "$app"
  # de-dupe: one glyph per distinct app per space
  case " ${GLYPHS[$sid]:-} " in
    *" $ICON_RESULT "*) : ;;
    *) GLYPHS[$sid]="${GLYPHS[$sid]:-}$ICON_RESULT " ;;
  esac
done < <(yabai -m query --windows 2>/dev/null \
  | jq -r '.[] | select(.["is-minimized"]==false) | "\(.space)|\(.app)"')

args=()
# Only spaces 1..5 have sketchybar indicators (matches the skhd workflow).
for sid in 1 2 3 4 5; do
  label="${GLYPHS[$sid]:-}"
  if [ -n "$label" ]; then
    args+=(--set "space.$sid" label="$label" label.drawing=on)
  else
    args+=(--set "space.$sid" label.drawing=off)
  fi
done
[ ${#args[@]} -gt 0 ] && sketchybar "${args[@]}" >/dev/null
