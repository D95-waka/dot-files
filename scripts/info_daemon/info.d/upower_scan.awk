#!/usr/bin/env awk

function _log(message) {
	system("sh -c 'log " message "'")
}

BEGIN {
	state = "unknown"
	percent = 0
	bar = "unknown"
	skip = 0
}

$2 == "device" {
	skip = $4 == "/org/freedesktop/UPower/devices/battery_BAT0"
}

$1 == "state:" {
	if (skip == 0)
		next

	state_new = $2
}

$1 == "percentage:" {
	if (skip == 0)
		next

	sub("%", "", $2)
	percent_new = $2 + 0
	if (percent_new == 100) {
		bar_new = "full"
	} else if (percent_new <= 10) {
		bar_new = "critical_low"
	} else if (percent_new <= 20) {
		bar_new = "low"
	} else {
		bar_new = "normal"
	}
}

$1 == "icon-name:" {
	if (skip == 0)
		next

	gsub("'", "", $2)
	icon_name = $2
}

NF == 0 {
	if (skip == 0)
		next

	if (percent_new != percent) {
		_log("Percent changed from: " percent " to: " percent_new)
		percent = percent_new
	}
	
	if (bar == "unknown") {
		bar = bar_new
	}

	if (bar_new != bar) {
		_log("Bar changed from: " bar " to: " bar_new)
		bar = bar_new
		if (bar != "normal") {
			system("~/.config/scripts/notification_templates.sh battery " bar)
		}
	}

	if (state == "unknown") {
		state = state_new
	}

	if (state_new != state) {
		_log("State changed from: " state " to: " state_new)
		state = state_new
		system("~/.config/scripts/notification_templates.sh battery " state " " icon_name)
	}
}
