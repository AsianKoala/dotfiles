#!/bin/sh
xsetroot -cursor_name left_ptr
xset m 0 0
xset s 1200 1200
xset r rate 240 60

# libadwaita / GTK4 apps (easyeffects, gnome-* apps) — force the dark color scheme
# so the pywal gtk-4.0/gtk.css overrides don't sit on top of a light baseline.
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark' >/dev/null 2>&1 || true
