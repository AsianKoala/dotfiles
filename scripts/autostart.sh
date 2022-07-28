#!/bin/sh
nvidia-settings --load-config-only
displaycal-apply-profiles &

xsetroot -cursor_name left_ptr &
xset m 0 0 &
xset -dpms &
xset s off &

$HOME/scripts/setbg.sh &
picom --experimental-backend &
mpd &
