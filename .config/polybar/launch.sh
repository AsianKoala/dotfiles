#!/usr/bin/env bash
# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch the bar
polybar -q center -c ~/.config/polybar/config.ini &
polybar -q left -c   ~/.config/polybar/config.ini &
polybar -q right -c  ~/.config/polybar/config.ini &
