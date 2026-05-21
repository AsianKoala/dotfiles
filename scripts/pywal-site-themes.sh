#!/usr/bin/env bash
# Generate a Chrome MV3 extension that injects pywal-derived CSS into
# soundcloud.com and youtube.com via content_scripts.
#
# Output: ~/.local/share/pywal-site-themes/
# Load once: chrome://extensions -> Developer mode -> Load unpacked.
# On subsequent palette changes, re-run this script (postrun does it
# automatically) and reload the extension once (Chrome picks up the new
# CSS files on the next page navigation).

set -e
. "$HOME/.cache/wal/colors.sh"

EXT_DIR="$HOME/.local/share/pywal-site-themes"
mkdir -p "$EXT_DIR"

BG=$background
FG=$foreground
DIM=$color8
ACCENT=$color4
ACCENT2=$color5
SURFACE=$color0

cat > "$EXT_DIR/manifest.json" <<EOF
{
  "manifest_version": 3,
  "name": "Pywal Site Themes",
  "version": "1.0.0",
  "description": "Inject pywal-derived CSS into youtube.com and soundcloud.com.",
  "content_scripts": [
    {
      "matches": ["*://*.youtube.com/*"],
      "css": ["youtube.css"],
      "run_at": "document_start"
    },
    {
      "matches": ["*://*.soundcloud.com/*", "*://soundcloud.com/*"],
      "css": ["soundcloud.css"],
      "run_at": "document_start"
    }
  ]
}
EOF

# ---- YouTube ---------------------------------------------------------------
# YouTube uses CSS custom properties under html; overriding those re-themes
# nearly everything (page bg, cards, popups, nav, sidebar, hover states).
cat > "$EXT_DIR/youtube.css" <<EOF
html {
  --yt-spec-base-background: $BG !important;
  --yt-spec-raised-background: $SURFACE !important;
  --yt-spec-menu-background: $SURFACE !important;
  --yt-spec-inverted-background: $FG !important;
  --yt-spec-additive-background: ${SURFACE}cc !important;
  --yt-spec-outline: $DIM !important;
  --yt-spec-shadow: rgba(0, 0, 0, 0.6) !important;

  --yt-spec-text-primary: $FG !important;
  --yt-spec-text-primary-inverse: $BG !important;
  --yt-spec-text-secondary: $DIM !important;
  --yt-spec-text-disabled: $DIM !important;

  --yt-spec-call-to-action: $ACCENT !important;
  --yt-spec-call-to-action-inverse: $BG !important;
  --yt-spec-suggested-action: $SURFACE !important;
  --yt-spec-suggested-action-inverse: $FG !important;

  --yt-spec-brand-button-background: $ACCENT !important;
  --yt-spec-brand-link-text: $ACCENT2 !important;
  --yt-spec-themed-blue: $ACCENT2 !important;

  --yt-spec-icon-active-other: $FG !important;
  --yt-spec-icon-inactive: $DIM !important;
  --yt-spec-icon-disabled: $DIM !important;

  --yt-spec-badge-chip-background: $SURFACE !important;
  --yt-spec-verified-badge-background: $ACCENT !important;

  --yt-spec-static-overlay-background-solid: $BG !important;
  --yt-spec-static-overlay-background-heavy: ${BG}e6 !important;
  --yt-spec-static-overlay-background-medium: ${BG}b3 !important;
  --yt-spec-static-overlay-background-light: ${BG}80 !important;

  --yt-spec-touch-response: ${ACCENT}33 !important;
  --yt-spec-10-percent-layer: ${FG}1a !important;
  --yt-spec-general-background-a: $BG !important;
  --yt-spec-general-background-b: $SURFACE !important;
  --yt-spec-general-background-c: $SURFACE !important;

  color-scheme: dark !important;
}

body { background: $BG !important; }
EOF

# ---- SoundCloud ------------------------------------------------------------
# SoundCloud has no CSS-variable layer, so we hit common class selectors.
# This is a minimal-but-effective dark theme; refine selectors as needed.
cat > "$EXT_DIR/soundcloud.css" <<EOF
html, body, #app, .l-fluid-fixed, .l-content, .l-fixed-top {
  background: $BG !important;
  color: $FG !important;
}

.header, .header__inner, .header__navigation, .g-z-index-header {
  background: $BG !important;
  border-bottom-color: $DIM !important;
}

.header__logo-svg path,
.header__userNavUsernameButton .sc-text,
.header__navigationLink {
  color: $FG !important;
  fill: $FG !important;
}

.searchTitle, .searchTitle__input {
  background: $SURFACE !important;
  color: $FG !important;
  border-color: $DIM !important;
}

.l-listen-wrapper, .listenContent, .stream__list, .soundList,
.searchResults, .sidebarModule, .l-sidebar-right, .l-aside {
  background: $BG !important;
  color: $FG !important;
}

.sc-text-h1, .sc-text-h2, .sc-text-h3, .sc-text-h4,
.sc-text-body, .sc-text, .sc-link-primary,
.soundTitle__title, .soundTitle__usernameText {
  color: $FG !important;
}

.sc-text-secondary, .sc-text-light, .sc-text-tiny,
.sound__time, .commentItem__date, .soundTitle__uploadTime {
  color: $DIM !important;
}

.sc-button, .sc-button-secondary, .sc-button-medium {
  background: $SURFACE !important;
  color: $FG !important;
  border-color: $DIM !important;
}

.sc-button-cta, .sc-button-primary,
.sc-button-like.sc-button-selected,
.sc-button-follow.sc-button-selected {
  background: $ACCENT !important;
  color: $BG !important;
  border-color: $ACCENT !important;
}

.sc-button:hover, .sc-button-secondary:hover {
  background: ${ACCENT}33 !important;
  border-color: $ACCENT !important;
}

.playbackSoundBadge, .playControls, .playControls__inner {
  background: $BG !important;
  color: $FG !important;
  border-color: $DIM !important;
}

.playControl, .skipControl, .repeatControl, .shuffleControl,
.volume__button {
  color: $FG !important;
}

.commentNode, .commentNode__sound, .commentItem,
.modal__modal, .dialog, .menu__list, .dropdownMenu {
  background: $SURFACE !important;
  color: $FG !important;
  border-color: $DIM !important;
}

a, a:visited { color: $ACCENT2 !important; }
a:hover { color: $ACCENT !important; }
EOF

echo "Pywal site themes generated at: $EXT_DIR"
echo "Load once: chrome://extensions -> Developer mode -> 'Load unpacked' -> pick that dir."
echo "After future palette changes the CSS files update automatically;"
echo "Chrome picks up new CSS on next page navigation (or hit reload on the extension)."
