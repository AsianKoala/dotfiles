#!/usr/bin/env bash
# ============================================================================
# mac-setwall.sh — the full macOS "rice" one-shot.
# Crops <image> to the main display's aspect ratio, sets it as the wallpaper,
# regenerates the pywal palette from it (kmeans), and propagates colors to
# kitty / tmux / nvim / borders / sketchybar.
#   mac-setwall.sh <image>
# ============================================================================
set -euo pipefail

SRC="${1:?usage: mac-setwall.sh <image>}"
SRC="$(cd "$(dirname "$SRC")" && pwd)/$(basename "$SRC")"
[ -f "$SRC" ] || { echo "not found: $SRC"; exit 1; }

WALL_DIR="$HOME/Pictures/wallpapers"
mkdir -p "$WALL_DIR"
DST="$WALL_DIR/$(basename "${SRC%.*}").jpg"

# --- crop to the main display's aspect ratio (center crop, no upscaling) ---
read -r DW DH < <(system_profiler SPDisplaysDataType | awk '/Resolution/{print $2, $4; exit}')
read -r SW SH < <(sips -g pixelWidth -g pixelHeight "$SRC" \
  | awk '/pixelWidth/{w=$2} /pixelHeight/{h=$2} END{print w, h}')
read -r CW CH < <(awk -v dw="$DW" -v dh="$DH" -v sw="$SW" -v sh="$SH" 'BEGIN{
  dar=dw/dh; sar=sw/sh;
  if (sar>dar){ ch=sh; cw=int(sh*dar) } else { cw=sw; ch=int(sw/dar) }
  print cw, ch }')
sips -c "$CH" "$CW" "$SRC" --out "$DST" >/dev/null
echo "cropped ${SW}x${SH} -> ${CW}x${CH}  ($DST)"

# --- set wallpaper on ALL spaces (macOS stores wallpaper per-space) ---
if ! command -v wallpaper >/dev/null 2>&1; then
  echo "note: 'wallpaper' CLI missing (brew install wallpaper)"
elif command -v yabai >/dev/null 2>&1 && yabai -m query --spaces >/dev/null 2>&1; then
  orig=$(yabai -m query --spaces | jq -r '.[] | select(.["has-focus"]==true) | .index')
  for s in $(yabai -m query --spaces | jq -r '.[] | select(.["is-native-fullscreen"]==false) | .index'); do
    yabai -m space --focus "$s" 2>/dev/null; sleep 0.5; wallpaper set "$DST"
  done
  yabai -m space --focus "${orig:-1}" 2>/dev/null; sleep 0.3; wallpaper set "$DST"
  echo "wallpaper set on all spaces."
else
  wallpaper set "$DST"; echo "wallpaper set (current space only; yabai unavailable)."
fi

# --- regenerate palette from the wallpaper via kmeans ---
VPY="$HOME/.local/pipx/venvs/pywal16/bin/python"
[ -x "$VPY" ] || VPY="$(command -v python3)"
"$VPY" "$HOME/dotfiles/scripts/pywal-from-kmeans.py" "$DST"

# --- propagate to all running surfaces ---
exec "$HOME/dotfiles/scripts/mac-reload.sh"
