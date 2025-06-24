#!/bin/bash

POWER_FILE="/sys/class/power_supply/AC0/online"
WCD="$HOME/Pictures/wallpaper/live"
WSD="$HOME/Pictures/wallpaper/static"

last_status=""

set_wallpaper() {
	if [[ "$(cat $POWER_FILE)" == 1 ]]; then
		echo "Changing - setting wallpaper"
		waypaper --random --folder "$WCD" --backend swww
	else
		echo "Not Charging - setting wallpaper"
		waypaper --random --folder "$WSD" --backend swww
	fi

	sleep 0.5
	~/scripts/matugen-pywalfox.sh
}

set_wallpaper

TIME=3600
(
	while true; do
		sleep $TIME
		set_wallpaper
	done

) &

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
