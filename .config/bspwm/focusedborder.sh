#!/bin/sh

while bspc subscribe -c 1 node_focus; do
    bw="$(bspc config border_width)"
    bspc config border_width "$bw"
    bspc config -n focused border_width "$((bw + 3))"
done
