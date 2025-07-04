#!/usr/bin/bash

function battery {
	case "$1" in
		"charging")
			notify-send -h string:x-dunst-stack-tag:battery -t 5000 "󰂄	"
			;;
		"discharging")
			notify-send -h string:x-dunst-stack-tag:battery -t 5000 "󰂄	"
			;;
		"critical_low")
			notify-send -h string:x-dunst-stack-tag:battery -u critical -t 0 "	Empty"
			;;
		"low")
			notify-send -h string:x-dunst-stack-tag:battery -u critical -t 16000 '	Low'
			;;
		"full")
			notify-send -h string:x-dunst-stack-tag:battery -t 16000 '	Full'
			;;
	esac
}

case "$1" in
"battery")
	battery "$2" "$3"
	;;
"device")
	notify-send -h string:x-dunst-stack-tag:device -t 8000 '	Insert'
	;;
"brightness")
	notify-send -h string:x-dunst-stack-tag:bind -t 500 "󰃟	$(light -G | sed 's/\..*//')%"
	;;
esac
