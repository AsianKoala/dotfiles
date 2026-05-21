#!/bin/sh

{% if mpd.using == "true" %}
mpd &
{% endif %}

clipster -d &

~/scripts/setbg.sh &

# compositor (rounded corners, shadows, fade, animations)
# NOTE: PRIME render offload (prime-run) does NOT work for compositors on an
# Intel-primary X server — picom can't present its NVIDIA-rendered framebuffer
# back through Intel, result is a blank desktop. To run picom on NVIDIA you
# need NVIDIA as PrimaryGPU in /etc/X11/xorg.conf.d/, not just env vars.
pgrep -x picom >/dev/null || picom --config ~/.config/picom/picom.conf -b &

# notification daemon
pgrep -x dunst >/dev/null || dunst &

# re-apply screen layout on hotplug (poll for monitor count changes)
pgrep -fx 'bash .*scripts/monitor-watch.sh' >/dev/null || ~/scripts/monitor-watch.sh &

~/.config/polybar/launch.sh &
~/scripts/xautostart.sh
