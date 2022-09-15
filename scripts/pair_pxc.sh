#!/usr/bin/bash
MAC_ADDRESS=00:1B:66:06:1C:FF
bluetoothctl scan on &
# bluetoothctl remove $MAC_ADDRESS
bluetoothctl pair $MAC_ADDRESS
bluetoothctl trust $MAC_ADDRESS
bluetoothctl connect  $MAC_ADDRESS
