#!/usr/bin/env bash
# Compact bluetooth status for polybar.
# Prints:
#   "off"             — controller powered off
#   "on"              — powered on, nothing connected
#   "<device alias>"  — powered on, device(s) connected (first one)

powered=$(bluetoothctl show 2>/dev/null | awk -F': ' '/Powered:/ {print $2; exit}')
[ "$powered" != "yes" ] && { echo "off"; exit 0; }

connected=$(bluetoothctl devices Connected 2>/dev/null | head -1 | cut -d ' ' -f 3-)
[ -n "$connected" ] && { echo "$connected"; exit 0; }

echo "on"
