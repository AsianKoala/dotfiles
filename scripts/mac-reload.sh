#!/usr/bin/env bash
# ============================================================================
# mac-reload.sh — propagate the current ~/.cache/wal palette to running
# macOS surfaces (kitty, tmux, borders, sketchybar). nvim picks it up on
# next launch. Called by mac-theme.sh and mac-setwall.sh; safe to run alone.
# ============================================================================
set -uo pipefail

# kitty: reload config (re-reads the wal include) via SIGUSR1
if pgrep -x kitty >/dev/null 2>&1; then
  kill -SIGUSR1 "$(pgrep -x kitty | tr '\n' ' ')" 2>/dev/null && echo "reloaded kitty"
fi

# tmux: re-source (picks up colors-tmux.conf)
if tmux info >/dev/null 2>&1; then
  tmux source-file "$HOME/.config/tmux/tmux.conf" 2>/dev/null && echo "reloaded tmux"
fi

# borders + sketchybar: restart services so their rc re-sources the wal palette
if command -v brew >/dev/null 2>&1; then
  brew services restart borders    >/dev/null 2>&1 && echo "reloaded borders"
  brew services restart sketchybar >/dev/null 2>&1 && echo "reloaded sketchybar"
fi

echo "nvim: restart to pick up the palette."
