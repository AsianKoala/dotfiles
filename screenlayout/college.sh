#!/bin/sh
xrandr ---output {{ main_monitor }} --primary --mode 2560x1440 --pos 0x0 --rotate normal --rate 144 -output {{ r_monitor }} --mode 1920x1200 --pos 2560x0 --rotate normal 
