#!/usr/bin/env bash

dir="~/.config/polybar/scripts/rofi"
uptime=$(uptime -p | sed -e 's/up //g')

rofi_command="rofi"

# Options
shutdown=" Shutdown"
reboot=" Restart"
lock=" Lock"

# Confirmation
confirm_exit() {
	rofi -dmenu\
		-i\
		-no-fixed-num-lines\
		-p "Are You Sure? : "\
		-theme $dir/confirm.rasi
}

# Message
msg() {
	#rofi -theme "$dir/message.rasi" -e "Available Options  -  yes / y / no / n"
	rofi -e "Available Options  -  yes / y / no / n"
}

# Variable passed to rofi
options="$lock\n$reboot\n$shutdown"

chosen="$(echo -e "$options" | $rofi_command -p "Uptime: $uptime" -dmenu -selected-row 0 -i)"
case $chosen in
    $shutdown)
			systemctl poweroff
        ;;
    $reboot)
			systemctl reboot
        ;;
    $lock)
			betterlockscreen -l dimblur --span
        ;;
esac
