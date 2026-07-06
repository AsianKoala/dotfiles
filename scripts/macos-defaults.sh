#!/usr/bin/env bash
# ============================================================================
# macos-defaults.sh — opinionated macOS system defaults. Idempotent; rerunnable.
# ============================================================================
set -euo pipefail

echo "Applying macOS defaults..."

# --- Keyboard: fast repeat, disable press-and-hold (needed for vim in some apps) ---
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# --- Text: disable all "smart"/automatic substitutions ---
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled     -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled  -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled   -bool false
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticInlinePredictionEnabled   -bool false

# --- Dock: autohide instantly, fast expose, don't rearrange spaces (yabai) ---
defaults write com.apple.dock autohide                 -bool true
defaults write com.apple.dock autohide-delay           -float 0
defaults write com.apple.dock expose-animation-duration -float 0.1
defaults write com.apple.dock mru-spaces               -bool false

# --- Finder: show hidden files and all extensions ---
defaults write com.apple.finder AppleShowAllFiles   -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# --- Screenshots to a dedicated folder ---
mkdir -p "$HOME/Pictures/screenshots"
defaults write com.apple.screencapture location "$HOME/Pictures/screenshots"

# --- Rice: hide desktop widgets, auto-hide the native menu bar (sketchybar is the bar) ---
defaults write com.apple.WindowManager StandardHideWidgets    -bool true
defaults write com.apple.WindowManager StageManagerHideWidgets -bool true
defaults write NSGlobalDomain _HIHideMenuBar -bool true

# --- Apply ---
killall Dock 2>/dev/null || true
killall Finder 2>/dev/null || true
killall SystemUIServer 2>/dev/null || true

echo "macOS defaults applied. (Some changes require logout/restart to fully take effect.)"
