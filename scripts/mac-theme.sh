#!/usr/bin/env bash
# ============================================================================
# mac-theme.sh — static pywal theming for macOS.
# Regenerates ~/.cache/wal/* from a preset colorscheme (no wallpaper/imagemagick
# needed) and live-reloads kitty + tmux. nvim picks it up on next launch.
# Usage: mac-theme.sh [scheme]   (default: nia)
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

# Live-reload running apps (kitty reloads config on SIGUSR1)
if pgrep -x kitty >/dev/null; then
  kill -SIGUSR1 "$(pgrep -x kitty | tr '\n' ' ')" 2>/dev/null && echo "reloaded kitty"
fi
if tmux info &>/dev/null; then
  tmux source-file "$HOME/.config/tmux/tmux.conf" 2>/dev/null && echo "reloaded tmux"
fi
echo "nvim: restart to pick up the new palette."
