#!/usr/bin/env sh

mode=$(echo -e 'window\noutput' | fuzzel -d)
case "$mode" in
	"window")
		swaymsg -t get_tree |
			jq -r '.. |
				select(.pid? and .visible?) |
				.rect + {"id": .foreign_toplevel_identifier} |
			"\(.x),\(.y) \(.width)x\(.height) \(.id)"' |
			slurp -f 'Window: %l'
		;;
	"output")
		slurp -f 'Monitor: %o' -or
		;;
esac

