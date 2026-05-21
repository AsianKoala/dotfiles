#!/bin/sh
# One-time bootstrap for the Pywal spicetify theme on a fresh machine.
# Safe to re-run: each step is idempotent.
#
# Prereqs: spicetify-cli installed (`yay -S spicetify-cli`), bombadil already
# linked (so ~/.config/spicetify/Themes/Pywal/user.css exists), pywal palette
# generated at least once.

set -e

if ! command -v spicetify >/dev/null 2>&1; then
    echo "spicetify-cli not installed. Run: yay -S spicetify-cli" >&2
    exit 1
fi

# 1. make /opt/spotify writable for the current user (needed every Spotify update)
if [ ! -w /opt/spotify ] || [ ! -w /opt/spotify/Apps ]; then
    echo "Granting write access on /opt/spotify (requires sudo)..."
    sudo chmod a+wr /opt/spotify
    sudo chmod a+wr -R /opt/spotify/Apps
fi

# 2. ensure pywal-rendered color.ini is in the theme dir
if [ -f "$HOME/.cache/wal/colors-spicetify.ini" ]; then
    mkdir -p "$HOME/.config/spicetify/Themes/Pywal"
    cp "$HOME/.cache/wal/colors-spicetify.ini" \
       "$HOME/.config/spicetify/Themes/Pywal/color.ini"
else
    echo "Warning: ~/.cache/wal/colors-spicetify.ini missing. Run wal -i <wallpaper> first." >&2
fi

# 3. backup Spotify (only on first run or after a Spotify update)
if [ ! -d "$HOME/.config/spicetify/Backup" ] \
   || [ -z "$(ls -A "$HOME/.config/spicetify/Backup" 2>/dev/null)" ]; then
    spicetify backup
fi

# 4. point spicetify at the Pywal theme
spicetify config current_theme Pywal color_scheme Pywal

# 5. apply
spicetify apply
