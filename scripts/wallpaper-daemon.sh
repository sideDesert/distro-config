#!/bin/bash

POWER_FILE="/sys/class/power_supply/AC0/online" # check actual path: AC, AC0, ACAD etc.
WCD="$HOME/Pictures/wallpaper/live"
WSD="$HOME/Pictures/wallpaper/static"

last_status=""

pick_random() {
	find "$1" -type f | shuf -n1
}

set_wallpaper() {
	# detect active monitors
	outputs=$(hyprctl monitors -j | jq -r '.[].name')

	# read current power state
	power=$(cat "$POWER_FILE")

	for out in $outputs; do
		if [[ "$power" == "1" && "$out" == "eDP-1" ]]; then
			# Plugged in: eDP → live
			echo "[$out] LIVE wallpaper (charging)"
			file=$(pick_random "$WCD")
			swww img "$file" --outputs "$out" --transition-type any
		else
			# Otherwise: always static
			echo "[$out] STATIC wallpaper"
			file=$(pick_random "$WSD")
			swww img "$file" --outputs "$out" --transition-type any
		fi
	done

	sleep 0.5
	~/scripts/matugen-pywalfox.sh
}

set_wallpaper

# periodic refresh
TIME=3600
(
	while true; do
		sleep $TIME
		set_wallpaper
	done
) &

# react to power adapter events
acpi_listen | while read -r line; do
	label=$(echo "$line" | awk '{ print $1 }')
	value=$(echo "$line" | awk '{ print $NF }')

	if [[ "$label" == "ac_adapter" ]]; then
		if [[ "$value" == "00000001" || "$value" == "00000000" ]]; then
			if [[ "$value" != "$last_status" ]]; then
				last_status="$value"
				set_wallpaper
			fi
		fi
	fi
done
