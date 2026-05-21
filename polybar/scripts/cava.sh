#!/usr/bin/env bash
# Polybar tail script — emits one line per frame from cava, with each digit
# (0-7) mapped to a unicode block character. Polybar renders the line in the
# bar's foreground color, so set the module's foreground = accent.

set -e

CONFIG="$HOME/.config/polybar/scripts/cava_config"
[ -f "$CONFIG" ] || { echo ""; exit 0; }

if ! command -v cava >/dev/null 2>&1; then
  echo "install cava"
  exit 0
fi

bars="▁▂▃▄▅▆▇█"
sed_expr="s/;//g"
for ((i = 0; i < ${#bars}; i++)); do
  sed_expr+=";s/$i/${bars:$i:1}/g"
done

exec cava -p "$CONFIG" | sed -u "$sed_expr"
