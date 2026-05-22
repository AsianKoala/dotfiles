#!/bin/sh
# Force-raise the polybar window above all siblings.
# Needed because polybar's `wm-restack = bspwm` loses the race when bspwm raises
# a fullscreen window — kitty (in zen mode) ends up over polybar.

python3 - <<'PY'
import ctypes, re, subprocess

out = subprocess.run(['xwininfo', '-root', '-children'], capture_output=True, text=True).stdout
wids = [int(m, 16) for m in re.findall(r'(0x[0-9a-fA-F]+)\s+"bspwm":\s+\("polybar"', out)]
if not wids:
    raise SystemExit

x11 = ctypes.CDLL('libX11.so.6')
x11.XOpenDisplay.restype = ctypes.c_void_p
dpy = x11.XOpenDisplay(None)
if not dpy:
    raise SystemExit
for w in wids:
    x11.XRaiseWindow(ctypes.c_void_p(dpy), ctypes.c_ulong(w))
x11.XSync(ctypes.c_void_p(dpy), ctypes.c_int(0))
x11.XCloseDisplay(ctypes.c_void_p(dpy))
PY
