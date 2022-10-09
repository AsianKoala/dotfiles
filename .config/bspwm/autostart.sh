#!/bin/sh
nvidia-settings --load-config-only
displaycal-apply-profiles &
mpd &

$HOME/scripts/setbg.sh &
picom --experimental-backend &
clipster -d &
fcitx &
~/scripts/mpd-discord.sh

~/.config/polybar/launch.sh &
