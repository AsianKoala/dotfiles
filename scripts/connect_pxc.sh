#!/usr/bin/bash
MAC_ADDRESS=00:1B:66:06:1C:FF
bluetoothctl trust MAC_ADDRESS
bluetoothctl disconnect MAC_ADDRESS
bluetoothctl connect MAC_ADDRESS
