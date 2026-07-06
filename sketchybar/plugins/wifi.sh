#!/usr/bin/env bash
# Show a wifi glyph reflecting the en0 link state (no SSID -> no Location perms).
if ifconfig en0 2>/dev/null | grep -q "status: active"; then
  sketchybar --set "$NAME" icon="" label.drawing=off
else
  sketchybar --set "$NAME" icon="" label.drawing=off
fi
