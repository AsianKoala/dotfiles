#!/usr/bin/env bash
# install pywal-driven thunderbird theme into the active profile.
# safe to re-run: it just refreshes symlinks and the colors.css from wal cache.
set -euo pipefail

TB_DIR="$HOME/.thunderbird"
PROFILES_INI="$TB_DIR/profiles.ini"
THEME_SRC="$HOME/dotfiles/thunderbird"
WAL_COLORS="$HOME/.cache/wal/colors-thunderbird.css"

if [ ! -f "$PROFILES_INI" ]; then
    echo "no $PROFILES_INI — start thunderbird at least once first" >&2
    exit 1
fi

# pick the [Install*] Default= path if present (this is what TB actually opens),
# else fall back to a [Profile*] block with Default=1
profile=$(awk '
    /^\[Install/ { ininstall = 1; next }
    /^\[/        { ininstall = 0 }
    ininstall && /^Default=/ { sub(/^Default=/, ""); print; exit }
' "$PROFILES_INI")

if [ -z "$profile" ]; then
    profile=$(awk '
        BEGIN { path = ""; def = 0 }
        /^\[Profile/ { if (def && path != "") { print path; exit }; path=""; def=0; next }
        /^Path=/     { sub(/^Path=/, ""); path = $0 }
        /^Default=1/ { def = 1 }
        END          { if (def && path != "") print path }
    ' "$PROFILES_INI")
fi

if [ -z "$profile" ]; then
    echo "could not detect default thunderbird profile from $PROFILES_INI" >&2
    exit 1
fi

PROFILE_DIR="$TB_DIR/$profile"
if [ ! -d "$PROFILE_DIR" ]; then
    echo "profile dir $PROFILE_DIR missing" >&2
    exit 1
fi

echo "thunderbird profile: $PROFILE_DIR"

# 1) symlink chrome/ — replace any pre-existing chrome dir/symlink
if [ -L "$PROFILE_DIR/chrome" ] || [ -d "$PROFILE_DIR/chrome" ]; then
    rm -rf "$PROFILE_DIR/chrome"
fi
ln -sfn "$THEME_SRC/chrome" "$PROFILE_DIR/chrome"
echo "linked chrome/ -> $THEME_SRC/chrome"

# 2) symlink user.js
ln -sfn "$THEME_SRC/user.js" "$PROFILE_DIR/user.js"
echo "linked user.js -> $THEME_SRC/user.js"

# 3) drop the wal-generated colors.css into chrome/ (the symlinked dir)
mkdir -p "$THEME_SRC/chrome"
if [ -f "$WAL_COLORS" ]; then
    cp "$WAL_COLORS" "$THEME_SRC/chrome/colors.css"
    echo "wrote chrome/colors.css from $WAL_COLORS"
else
    echo "warn: $WAL_COLORS missing — run 'wal -R' or 'wal -i <wallpaper>' first; theme will use last colors.css if present" >&2
fi

echo
echo "done. restart thunderbird (full quit, not just close) to apply."
