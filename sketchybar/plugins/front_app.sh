#!/bin/sh
# Show the focused app's name. Uses $INFO on the switch event; otherwise (e.g.
# on initial load / forced update) queries yabai for the focused window's app.
if [ "$SENDER" = "front_app_switched" ]; then
  sketchybar --set "$NAME" label="$INFO"
else
  APP="$(yabai -m query --windows --window 2>/dev/null | jq -r '.app // empty')"
  [ -n "$APP" ] && sketchybar --set "$NAME" label="$APP"
fi
