#!/bin/sh
# Highlight the focused space: fill its background and tint the number/icons.
# $SELECTED is provided by sketchybar for space components.
sketchybar --set "$NAME" \
  background.drawing="$SELECTED" \
  icon.highlight="$SELECTED" \
  label.highlight="$SELECTED"
