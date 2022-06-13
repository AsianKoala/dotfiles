#!/usr/bin/bash

echo $1 >> ~/scripts/wallpaper-path
feh --bg-fill $1
wal -i $1
~/sources/cli-visualizer_pywal/vis
~/.config/polybar/docky/scripts/pywal.sh $1
pkill polybar
~/.config/polybar/docky/launch.sh
pywal-discord
pywalfox update
betterlockscreen -u $1
