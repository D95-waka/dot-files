#!/usr/bin/env sh

export GRIM_DEFAULT_DIR="$HOME/Downloads/"

action="$1"
if [[ "$action" == 'screen' ]]; then
	grim
elif [[ "$action" == 'region' ]]; then
	grim -g "$(swaymsg -t get_tree |
		jq -r '.. |
			select(.pid? and .visible?) |
			.rect |
			"\(.x),\(.y) \(.width)x\(.height)"' |
		slurp)"
elif [[ "$action" == 'selection' ]]; then
	grim -g "$(slurp)"
fi

cat "$GRIM_DEFAULT_DIR/$(ls -t "$GRIM_DEFAULT_DIR" | head -1)" | wl-copy
