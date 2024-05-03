#!/bin/sh
{% if using_displaycal == "true" %}
displaycal-apply-profiles &
{% endif %}
mpd &

$HOME/scripts/setbg.sh &
pkill picom && picom --experimental-backend --refresh-rate 144 --xrender-sync-fence &
clipster -d &

~/.config/polybar/launch.sh &
