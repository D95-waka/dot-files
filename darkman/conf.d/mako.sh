#!/usr/bin/env sh

if [[ "$1" == 'dark' ]]; then
	makoctl mode -s dark
elif [[ "$1" == 'light' ]]; then
	makoctl mode -s light
fi
