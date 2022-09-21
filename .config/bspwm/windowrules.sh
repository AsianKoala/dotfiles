#!/bin/sh
bspc rule -a leagueclientux.exe desktop='4' 
bspc rule -a riotclientux.exe desktop='4' 
bspc rule -a explorer.exe desktop='4' border=off
bspc rule -a 'league of legends.exe' desktop='4'  
bspc rule -a Lutris desktop='4' 
bspc rule -a discord desktop='6' 
# bspc rule -a 'jetbrains-studio' state=floating follow=on
bspc rule -a obs state=floating
bspc rule -a chatterino state=floating
bspc rule -a 'Fcitx-config-gtk3' state=floating
bspc rule -a Anki state=floating
bspc rule -a 'OpenTabletDriver.UX.Gtk' state=floating
bspc rule -a 'Thunderbird' state=floating
bspc rule -a 'matplotlib' state=floating
bspc rule -a 'Thunar' state=floating
bspc rule -a 'Pcmanfm' state=floating
bspc rule -a kitty:R state=floating
