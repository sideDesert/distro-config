#!/bin/sh
# One-time random wallpaper changer using swww and wal

if [ $# -lt 1 ] || [ ! -d "$1" ]; then
	printf "Usage:\n\t\e[1m%s\e[0m \e[4mDIRECTORY\e[0m\n" "$0"
	exit 1
fi

# Pick a random image
IMG=$(find "$1" -type f | shuf -n 1)

# Optional: Apply theming via pywal
wal -i "$IMG"

# Set the wallpaper using swww
swww img --resize=crop "$IMG"
