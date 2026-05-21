#!/usr/bin/env bash
# Generate a Chrome extension theme from the current pywal palette.
# Output: ~/.local/share/pywal-chrome-theme/  (load as unpacked extension)
#
# Run once after `wal -i <wallpaper>`. Chrome auto-applies if the theme
# extension is already installed (Chrome reloads it when files change).

set -e
. "$HOME/.cache/wal/colors.sh"

THEME_DIR="$HOME/.local/share/pywal-chrome-theme"
mkdir -p "$THEME_DIR/images"

# convert #RRGGBB to "R, G, B"
hex_rgb() {
    local h=${1#\#}
    echo "$((16#${h:0:2})), $((16#${h:2:2})), $((16#${h:4:2}))"
}

BG=$(hex_rgb "$background")
FG=$(hex_rgb "$foreground")
ACCENT=$(hex_rgb "$color5")     # the brightest accent (vivid pink)
PRIMARY=$(hex_rgb "$color4")    # rose
MUTE=$(hex_rgb "$color8")       # dim text

cat > "$THEME_DIR/manifest.json" <<EOF
{
  "manifest_version": 3,
  "version": "1.0.0",
  "name": "Pywal Theme",
  "description": "Auto-generated from \$HOME/.cache/wal",
  "theme": {
    "colors": {
      "frame":                          [$BG],
      "frame_inactive":                 [$BG],
      "toolbar":                        [$BG],
      "background_tab":                 [$BG],
      "background_tab_inactive":        [$BG],
      "bookmark_text":                  [$FG],
      "tab_text":                       [$FG],
      "tab_background_text":            [$MUTE],
      "tab_background_text_inactive":   [$MUTE],
      "toolbar_button_icon":            [$FG],
      "ntp_background":                 [$BG],
      "ntp_text":                       [$FG],
      "ntp_link":                       [$ACCENT],
      "ntp_header":                     [$PRIMARY],
      "button_background":              [$BG],
      "omnibox_text":                   [$FG],
      "omnibox_background":             [$BG]
    },
    "tints": {
      "buttons": [-1.0, -1.0, 0.85]
    },
    "properties": {
      "ntp_background_alignment": "center"
    }
  }
}
EOF

# tiny solid-color PNG for any image slots that fall back
if command -v magick >/dev/null 2>&1; then
    magick -size 4x4 xc:"$background" "$THEME_DIR/images/bg.png" 2>/dev/null || true
fi

echo "Pywal Chrome theme generated at: $THEME_DIR"
echo "Load once: chrome://extensions → Developer mode → 'Load unpacked' → pick that dir."
echo "On subsequent palette changes the theme updates automatically (re-run this script after wal)."
