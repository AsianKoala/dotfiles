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

# fuck you java
export _JAVA_AWT_WM_NONREPARENTING=1
export AWT_TOOLKIT=MToolkit

# fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

# autostart
$HOME/.screenlayout/triple_fixed.sh
xsetroot -cursor_name left_ptr 
xset m 0 0 
xset s off -dpms
xset r rate 240 60 
xmodmap ~/.Xmodmap

sleep 2
# (sleep 10; systemctl --user restart pipewire-pulse.service) &

# wm
exec bspwm
