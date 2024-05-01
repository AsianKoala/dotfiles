#!/bin/sh
killall redshift
sleep 2
redshift -c ~/.config/redshift/orange_redshift.conf &
