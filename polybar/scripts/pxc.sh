#!/bin/sh
devices=`bluetoothctl devices | cut -f2 -d' ' | while read uuid; do bluetoothctl info $uuid; done|grep -e "Device\|Connected\|Name"`
if echo "$devices" | grep -q "Connected: yes"; then
  ~/scripts/disconnect_pxc.sh
else
  # ~/scripts/connect_pxc.sh
  ~/scripts/pair_pxc.sh
fi
