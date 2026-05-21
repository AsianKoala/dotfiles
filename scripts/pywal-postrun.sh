#!/bin/sh
# run after `wal -i <wallpaper>` to apply the new palette across the desktop
# wired into pywal via ~/.config/wal/postrun hook (see wal docs) or run manually.

set -e

# 1. reload polybar (sources colors-polybar.ini)
~/.config/polybar/launch.sh &

# 2. reload tmux (sources colors-tmux.conf)
if pgrep -x tmux >/dev/null 2>&1; then
    tmux source-file ~/.config/tmux/tmux.conf
fi

# 3. re-apply bspwm border colors (does not auto-reload from wal)
. "$HOME/.cache/wal/colors.sh"
bspc config focused_border_color "$color5"
bspc config active_border_color  "$color4"
bspc config normal_border_color  "$color1"

# 4. regenerate dunst colors and restart it
sed -i \
    -e "s|background = \"#[0-9A-Fa-f]\{6\}\"|background = \"$background\"|g" \
    -e "s|frame_color = \"#[0-9A-Fa-f]\{6\}\"|frame_color = \"$color4\"|g" \
    ~/.config/dunst/dunstrc 2>/dev/null || true
pkill -USR1 dunst 2>/dev/null || true

# 5. kitty reload (picks up include automatically next launch; live-reload via socket)
if [ -n "$KITTY_LISTEN_ON" ] && command -v kitty >/dev/null 2>&1; then
    kitty @ load-config 2>/dev/null || true
fi

# 6. lockscreen cache rebuild (if betterlockscreen present) — dim only, no blur
if command -v betterlockscreen >/dev/null 2>&1 && [ -n "$wallpaper" ]; then
    betterlockscreen -u "$wallpaper" --fx dim >/dev/null 2>&1 &
fi

# 7. regenerate Chrome theme extension from the palette
[ -x "$HOME/scripts/pywal-chrome-theme.sh" ] && "$HOME/scripts/pywal-chrome-theme.sh" >/dev/null 2>&1 || true

# 7a. regenerate per-site Chrome content_script CSS (youtube, soundcloud)
[ -x "$HOME/scripts/pywal-site-themes.sh" ] && "$HOME/scripts/pywal-site-themes.sh" >/dev/null 2>&1 || true

# 7b. apply gtk-4.0/libadwaita theming (easyeffects + other libadwaita apps)
if [ -f "$HOME/.cache/wal/colors-gtk4.css" ]; then
    mkdir -p "$HOME/.config/gtk-4.0"
    cp "$HOME/.cache/wal/colors-gtk4.css" "$HOME/.config/gtk-4.0/gtk.css"
fi

# 8. spicetify: copy generated color.ini into the Pywal theme and re-apply
if command -v spicetify >/dev/null 2>&1 && [ -f "$HOME/.cache/wal/colors-spicetify.ini" ]; then
    theme_dir="$HOME/.config/spicetify/Themes/Pywal"
    mkdir -p "$theme_dir"
    cp "$HOME/.cache/wal/colors-spicetify.ini" "$theme_dir/color.ini"
    spicetify apply >/dev/null 2>&1 || true
fi

# 9. thunderbird: refresh chrome/colors.css from the wal cache.
# chrome/ is symlinked into the active TB profile by scripts/thunderbird-theme-install.sh,
# so this single copy reaches the running profile. TB needs a full restart to re-read it.
if [ -f "$HOME/.cache/wal/colors-thunderbird.css" ] && [ -d "$HOME/dotfiles/thunderbird/chrome" ]; then
    cp "$HOME/.cache/wal/colors-thunderbird.css" "$HOME/dotfiles/thunderbird/chrome/colors.css"
fi

# 10. plasma color scheme: install ~/.local/share/color-schemes/Pywal.colors
# so any app that looks the "Pywal" scheme up by ID (kcolorschemeeditor etc.) finds it.
if [ -f "$HOME/.cache/wal/colors-plasma.colors" ]; then
    mkdir -p "$HOME/.local/share/color-schemes"
    cp "$HOME/.cache/wal/colors-plasma.colors" "$HOME/.local/share/color-schemes/Pywal.colors"
fi

# 11. kdeglobals: KDEPlasmaPlatformTheme6 (plasma-integration) reads [Colors:*]
# sections directly from kdeglobals — NOT from the scheme file referenced by
# ColorScheme=. So inline the palette here. Without this, Qt6/Kirigami apps
# (easyeffects, etc.) fall back to the default light palette.
if [ -f "$HOME/.cache/wal/kdeglobals" ]; then
    # break symlinks; we want a regular file so cp overwrites in place
    if [ -L "$HOME/.config/kdeglobals" ]; then
        rm "$HOME/.config/kdeglobals"
    fi
    cp "$HOME/.cache/wal/kdeglobals" "$HOME/.config/kdeglobals"
fi

# 12. pywalfox: push new palette to Thunderbird (and Firefox) via the
# pywalfox native messaging host. Requires the pywalfox TB add-on installed.
if command -v pywalfox >/dev/null 2>&1; then
    pywalfox update >/dev/null 2>&1 || true
fi
