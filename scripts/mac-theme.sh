#!/usr/bin/env bash
# ============================================================================
# mac-theme.sh — apply a *preset* pywal colorscheme on macOS (no wallpaper).
# Regenerates ~/.cache/wal/* from a scheme in wal/colorschemes/dark/ and
# propagates to kitty/tmux/borders/sketchybar. To theme FROM a wallpaper
# instead, use mac-setwall.sh <image>.
#   mac-theme.sh [scheme]   (default: nia; e.g. kmeans-current)
# ============================================================================
set -euo pipefail

SCHEME="${1:-nia}"
WAL="$(command -v wal || echo "$HOME/.local/bin/wal")"
SCHEME_PATH="$HOME/.config/wal/colorschemes/dark/${SCHEME}.json"

[ -x "$WAL" ] || { echo "pywal16 not found (pipx install pywal16)"; exit 1; }
[ -f "$SCHEME_PATH" ] || { echo "scheme not found: $SCHEME_PATH"; exit 1; }

# -n no wallpaper, -s/-t skip terminal/tty sequences, -e skip external reloads, -q quiet
"$WAL" -n -s -t -e -q --theme "$SCHEME_PATH"
echo "Generated ~/.cache/wal from '$SCHEME'."

exec "$HOME/dotfiles/scripts/mac-reload.sh"
