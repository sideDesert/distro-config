#!/bin/bash
# We can run shell scripts here

last_status=""

acpi_listen | while read -r line; do
	label=$(echo "$line" | awk '{ print $1 }')
	value=$(echo "$line" | awk '{ print $NF }')

	if [[ "$label" == "ac_adapter" ]]; then
		if [[ "$value" == "00000001" || "$value" == "00000000" ]]; then
			if [[ "$value" != "$last_status" ]]; then
				last_status="$value"
				echo "Battery Status Changed: $value"
				# set_wallpaper or whatever you want here
			fi
		fi
	fi
done
