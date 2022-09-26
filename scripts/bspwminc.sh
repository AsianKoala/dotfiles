#!/bin/sh
bspc config top_padding $((`bspc config top_padding` + 2 )); \
bspc config bottom_padding $((`bspc config bottom_padding` + 2 )); \
bspc config left_padding $((`bspc config left_padding` + 2 )); \
bspc config right_padding $((`bspc config right_padding` + 2 ))
