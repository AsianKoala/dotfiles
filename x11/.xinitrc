#!/bin/sh

userresources=$HOME/.Xresources
sysresources=/etc/X11/xinit/.Xresources

if [ -f $sysresources ]; then
    xrdb -merge $sysresources

fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"

fi

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi


# autostart
$HOME/.screenlayout/setup.sh
sleep 2

{% if "laptop" in profiles %}
brightnessctl s 10%
(sleep 5; $HOME/scripts/keyboard-setup.sh) &
{% endif %}



export XCURSOR_SIZE=24
export XCURSOR_THEME=Bibata-Modern-Classic
export GTK_THEME=catppuccin-mocha-mauve-standard+default

# wm
exec bspwm
