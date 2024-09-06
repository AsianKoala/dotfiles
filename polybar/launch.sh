#!/usr/bin/env bash
# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch the bar

{%- if use_main == "true" %}
polybar -q center -c   ~/.config/polybar/config.ini &
{% endif -%}

{%- if use_l == "true" %}
polybar -q left -c   ~/.config/polybar/config.ini &
{% endif -%}

{%- if use_r == "true" %}
polybar -q right -c   ~/.config/polybar/config.ini &
{% endif -%}

