#!/bin/sh
nvidia-settings --load-config-only
displaycal-apply-profiles &
mpd &

$HOME/scripts/setbg.sh &
picom --experimental-backend --refresh-rate 144 --xrender-sync-fence &
clipster -d &
fcitx &
~/scripts/mpd-discord.sh

~/.config/polybar/launch.sh &
