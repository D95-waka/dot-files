#!/usr/bin/env sh

for i in "$XDG_RUNTIME_DIR"/sway-*.sock; do
	export SWAYSOCK="$i"
	swaymsg reload
done
