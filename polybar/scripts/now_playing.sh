#!/usr/bin/env bash
# Polybar tail script — emits current track on every metadata/status change.
# Requires `playerctl`. Works with Spotify (desktop) and SoundCloud / YouTube /
# anything in a browser tab (Chromium/Firefox expose MediaSession as MPRIS).

if ! command -v playerctl >/dev/null 2>&1; then
  echo "install playerctl"
  exit 0
fi

format='{{ title }} — {{ artist }}'

emit() {
  local status title artist line
  status=$(playerctl status 2>/dev/null)
  [ -z "$status" ] && { echo ""; return; }

  title=$(playerctl metadata --format '{{ title }}' 2>/dev/null)
  artist=$(playerctl metadata --format '{{ artist }}' 2>/dev/null)
  [ -z "$title" ] && { echo ""; return; }

  if [ -n "$artist" ]; then
    line="$title — $artist"
  else
    line="$title"
  fi

  case "$status" in
    Playing) echo "$line" ;;
    Paused)  echo "$line  (paused)" ;;
    *)       echo "" ;;
  esac
}

emit
playerctl --follow metadata --format "$format" 2>/dev/null | while read -r _; do
  emit
done
