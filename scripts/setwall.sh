#!/bin/sh
# usage: setwall.sh <image>
# replaces the desktop wallpaper, regenerates the palette via kmeans (softer
# than vanilla pywal), and propagates colors to every themed surface.

set -e
WP="${1:?usage: setwall.sh <image>}"
WP=$(realpath "$WP")

# 1. set as background immediately
feh --bg-fill "$WP"

# 2. kmeans → wal theme + apply
"$HOME/documents/projects/kmeans_image_clustering/.venv/bin/python" \
    "$HOME/scripts/pywal-from-kmeans.py" "$WP"

# 3. propagate to polybar / tmux / bspwm / dunst / kitty / lockscreen / chrome
"$HOME/scripts/pywal-postrun.sh"

echo "wallpaper set: $WP"
