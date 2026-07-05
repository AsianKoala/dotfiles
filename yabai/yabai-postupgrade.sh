#!/usr/bin/env bash
# ============================================================================
# yabai-postupgrade.sh — run after every `brew upgrade yabai`.
# Re-pins the sudoers NOPASSWD hash to the new binary, reloads the scripting
# addition, and restarts the service. Idempotent.
# ============================================================================
set -euo pipefail

YABAI="$(command -v yabai)"
[ -x "$YABAI" ] || { echo "yabai not found on PATH"; exit 1; }

HASH="$(shasum -a 256 "$YABAI" | cut -d' ' -f1)"
USER_NAME="$(whoami)"
SUDOERS=/private/etc/sudoers.d/yabai
LINE="$USER_NAME ALL=(root) NOPASSWD: sha256:$HASH $YABAI --load-sa"

echo "Pinning sudoers hash for $YABAI"
echo "$LINE" | sudo tee "$SUDOERS" >/dev/null
sudo chmod 440 "$SUDOERS"

# Validate before trusting it — a malformed sudoers.d file can lock out sudo.
if ! sudo visudo -c -f "$SUDOERS"; then
  echo "ERROR: sudoers validation failed — inspect $SUDOERS" >&2
  exit 1
fi

# Reload scripting addition (should now be passwordless) and restart service.
sudo yabai --load-sa
yabai --restart-service

echo
echo "Done. If yabai still can't manage windows, re-check the Accessibility toggle:"
echo "  System Settings > Privacy & Security > Accessibility > yabai (toggle off/on)."
