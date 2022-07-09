#! /bin/sh
nvidia-settings --load-config-only
displaycal-apply-profiles &
xsetroot -cursor_name left_ptr &
xset m 0 0 &
~/scripts/setbg.sh &
picom --experimental-backend &
~/.config/polybar/docky/launch.sh &
# ~/.config/bspwm/2bspwm &
mpd &
