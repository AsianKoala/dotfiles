#!/bin/bash
outer='0xf2f2f2'   # outer
inner1='0xf4baf0'  # focused
inner2='0xd6d8db'  # normal

trap 'bspc config border_width 0; kill -9 -$$' INT TERM

targets() {
	case $1 in
		focused) bspc query -N -n .local.focused.\!fullscreen;;
		normal)  bspc query -N -n .\!focused.\!fullscreen
	esac
}
bspc config border_width 4

draw() { chwb2 -I "$inner" -O "$outer" -i "2" -o "5" $*; }

# initial draw, and then subscribe to events
{ echo; bspc subscribe node_geometry node_focus; } |
	while read -r _; do
		[ "$v" ] || v='abcdefg'
		inner=$inner1 draw $(targets focused)
		inner=$inner2 draw $(targets  normal)
	done
