#!/bin/bash

# Prompt user to pick an emoji using wofi
chosen=$(cat ~/scripts/emoji-list.txt | wofi --dmenu --prompt "Pick an emoji" | awk '{print $1}')

# If a choice was made
if [ -n "$chosen" ]; then
	echo -n "$chosen" | wl-copy
	notify-send "Emoji Copied!" "$chosen"
fi
