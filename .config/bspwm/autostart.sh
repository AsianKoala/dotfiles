#!/bin/sh
nvidia-settings --load-config-only
displaycal-apply-profiles &
# pkill redshift
mpd &

$HOME/scripts/setbg.sh &
picom --experimental-backend &
clipster -d &
fcitx &

~/.config/polybar/launch.sh &
