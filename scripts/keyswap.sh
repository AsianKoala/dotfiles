#!/usr/bin/env bash
# ============================================================================
# keyswap.sh — swap Escape <-> Caps Lock at the HID level (macOS). Idempotent.
# hidutil mappings reset on reboot/reconnect; the LaunchAgent re-applies at login.
#   keyswap.sh          apply the swap
#   keyswap.sh --reset  clear all user key mappings (restore defaults)
# HID usage codes: Caps Lock 0x700000039, Escape 0x700000029.
# ============================================================================
set -euo pipefail

CAPS=0x700000039
ESC=0x700000029

if [[ "${1:-}" == "--reset" ]]; then
  hidutil property --set '{"UserKeyMapping":[]}' >/dev/null
  echo "cleared user key mappings"
  exit 0
fi

hidutil property --set "{\"UserKeyMapping\":[
  {\"HIDKeyboardModifierMappingSrc\":$CAPS,\"HIDKeyboardModifierMappingDst\":$ESC},
  {\"HIDKeyboardModifierMappingSrc\":$ESC,\"HIDKeyboardModifierMappingDst\":$CAPS}
]}" >/dev/null
echo "swapped Esc <-> Caps Lock"
