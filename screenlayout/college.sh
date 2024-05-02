#!/bin/sh
xrandr --output {{ r_monitor }} --mode 1920x1200 --pos 2560x0 --rotate normal --output DP-3 --off --output {{ main_monitor }} --primary --mode 2560x1440 --pos 0x0 --rotate normal --rate 144 --output DP-5 --off
