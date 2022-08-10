#!/bin/sh
nvidia-settings --load-config-only
displaycal-apply-profiles &
pkill redshift

xsetroot -cursor_name left_ptr &
xset m 0 0 &
xset -dpms &
xset s off &
xset r rate 240 60 &

$HOME/scripts/setbg.sh &
picom --experimental-backend &
mpd &
clipster -d &
fcitx &

~/.config/polybar/launch.sh &
