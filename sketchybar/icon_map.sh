#!/usr/bin/env bash
# Maps an application name to a Nerd Font glyph. Sets $ICON_RESULT.
# Generated with explicit codepoints so glyphs are correctly UTF-8 encoded.
__icon_map() {
  case "$1" in
    "kitty"|"Kitty"|"Alacritty"|"WezTerm"|"Terminal"|"iTerm2"|"Ghostty") ICON_RESULT="" ;;
    "Code"|"Code - Insiders"|"VSCodium"|"Cursor") ICON_RESULT="" ;;
    "Neovim"|"nvim"|"MacVim"|"VimR"|"Vim") ICON_RESULT="" ;;
    "Google Chrome"|"Chromium"|"Google Chrome Canary"|"Brave Browser") ICON_RESULT="" ;;
    "Safari"|"Safari Technology Preview") ICON_RESULT="" ;;
    "Firefox"|"Firefox Developer Edition"|"Zen"|"LibreWolf") ICON_RESULT="" ;;
    "Arc") ICON_RESULT="" ;;
    "Finder") ICON_RESULT="" ;;
    "Spotify") ICON_RESULT="" ;;
    "Music") ICON_RESULT="" ;;
    "Discord"|"Discord Canary"|"Vesktop") ICON_RESULT="" ;;
    "Slack") ICON_RESULT="" ;;
    "Mail"|"Spark"|"Airmail") ICON_RESULT="" ;;
    "Messages"|"Telegram"|"WhatsApp") ICON_RESULT="" ;;
    "Notes"|"Notion"|"Obsidian"|"Bear") ICON_RESULT="" ;;
    "Preview"|"Skim"|"PDF Expert") ICON_RESULT="" ;;
    "Calendar"|"Fantastical") ICON_RESULT="" ;;
    "System Settings"|"System Preferences") ICON_RESULT="" ;;
    "Activity Monitor") ICON_RESULT="" ;;
    "zoom.us") ICON_RESULT="" ;;
    *) ICON_RESULT="" ;;
  esac
}
