#!/usr/bin/env sh

function profile_changed {
	local profile_name="$1"

	# Blacklisted profiles
	if [[ $profile_name =~ tun ]]; then
		return 0
	fi

	local profile_enabled="$(nmcli -g GENERAL.STATE connection show "$profile_name")"
	local profile_type="$(nmcli -g connection.type connection show "$profile_name")"
	log "Connection: $profile_type, $profile_name, $profile_enabled"
	local logo=' '
	case "$profile_type" in
		'wireless')
			logo=' '
			;;
		'vpn' | 'wireguard')
			logo='󰒘 '
			;;
	esac

	notify-send -t 5000 "$logo	$profile_name" "$profile_enabled"
}

function main {
	nmcli connection monitor | while read line; do
		if [[ $line =~ connection\ profile\ changed ]]; then
			local profile_name="${line//:*/}"
			profile_changed "$profile_name"
		fi
	done
}

main "$@"
