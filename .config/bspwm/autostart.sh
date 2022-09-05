#!/bin/sh
nvidia-settings --load-config-only
displaycal-apply-profiles &
# pkill redshift

$HOME/scripts/setbg.sh &
picom --experimental-backend &
mpd &
clipster -d &
fcitx &

~/.config/polybar/launch.sh &
