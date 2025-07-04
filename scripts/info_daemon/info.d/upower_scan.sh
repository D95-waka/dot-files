#!/usr/bin/env sh

SOURCE_DIR="$(dirname "$0")/"
upower --monitor-detail | \
	awk -f "$SOURCE_DIR/upower_scan.awk"
