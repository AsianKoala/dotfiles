#!/usr/bin/env bash
# Watch for monitor hotplug events and re-apply the screen layout
# (incl. correct refresh rate). Polls every 3s — RandR-event watchers
# require srandrd/autorandr which we don't depend on.

LAYOUT="$HOME/.screenlayout/setup.sh"
[ -x "$LAYOUT" ] || exit 0

prev=""
while true; do
  cur=$(xrandr --query 2>/dev/null | grep -c ' connected')
  if [ -n "$cur" ] && [ "$cur" != "$prev" ]; then
    # Skip the very first observation (we don't want to clobber the
    # layout that xinit/.xinitrc already set on login).
    if [ -n "$prev" ]; then
      "$LAYOUT"
      # Polybar's bar is monitor-bound; restart so bars rebind correctly.
      "$HOME/.config/polybar/launch.sh" >/dev/null 2>&1 &
    fi
    prev=$cur
  fi
  sleep 3
done
