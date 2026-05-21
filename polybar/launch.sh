#!/usr/bin/env bash
# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch the bar

polybar -q center -c   ~/.config/polybar/config.ini &

{% if "home" in profiles %}

polybar -q left -c   ~/.config/polybar/config.ini &
polybar -q right -c   ~/.config/polybar/config.ini &

{% elif "edward" in profiles %}

polybar -q right -c   ~/.config/polybar/config.ini &

{% elif "displaylink2" in profiles %}

polybar -q left -c   ~/.config/polybar/config.ini &

{% elif "displaylink3" in profiles %}

polybar -q left -c   ~/.config/polybar/config.ini &
polybar -q right -c   ~/.config/polybar/config.ini &

{% endif %}


