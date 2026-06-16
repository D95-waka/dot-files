#!/usr/bin/env sh

if [[ "$1" == 'dark' ]]; then
	notify-send -h string:x-dunst-stack-tag:darkmode -t 500 "dark mode"
elif [[ "$1" == 'light' ]]; then
	notify-send -h string:x-dunst-stack-tag:darkmode -t 500 "light mode"
fi
