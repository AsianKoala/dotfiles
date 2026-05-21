#!/bin/sh
# testing
# arandr: xrandr --output eDP-1 --primary --mode 1920x1080 --pos 5783x1397 --rotate normal --output HDMI-1-0 --mode 1920x1200 --pos 104x583 --rotate normal --output DP-1-0 --mode 3440x1440 --pos 2147x0 --rotate normal --output DP-1-1 --off
{% if "home" in profiles %}
xrandr --output {{ monitor.main }} --auto --pos 0x180 --rotate normal --output {{ monitor.wide }} --primary --mode 3440x1440 --pos 1920x0 --rotate normal --rate 120 --output {{ monitor.left }} --auto --pos 5360x583 --rotate normal
{% elif "edward" in profiles %}
xrandr --output {{ monitor.wide }} --primary --mode 3440x1440 --pos 1920x0 --rotate normal --rate 120 --output {{ monitor.main }} --auto --pos 0x180 --rotate normal
{% elif "laptop" in profiles and "displaylink3" in profiles %}
xrandr --output {{ monitor.main }} --primary --mode 1920x1080 --pos 0x0 --rotate normal --rate 144 --output {{ monitor.left }} --auto --left-of {{ monitor.main }} --output {{ monitor.right }} --auto --right-of {{ monitor.main }}
{% elif "laptop" in profiles and "displaylink2" in profiles %}
xrandr --output {{ monitor.main }} --primary --mode 1920x1080 --pos 0x0 --rotate normal --rate 144 --output {{ monitor.left }} --auto --left-of {{ monitor.main }}
{% elif "laptop" in profiles %}
xrandr --output {{ monitor.main }} --primary --mode 1920x1080 --pos 0x0 --rotate normal --rate 144
{% else %}
xrandr --output DVI-D-0 --off --output {{ monitor.left }} --mode 1920x1200 --pos 0x56 --rotate normal --output {{ monitor.main }} --mode 2560x1440 --pos 1920x0 --rotate normal --rate 144
{% endif %}
