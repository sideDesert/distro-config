#!/bin/bash

chosen=$(cat ~/scripts/emoji-list.txt | rofi -dmenu -p "Pick an emoji" -matching fuzzy | awk '{print $1}')
if [ -n "$chosen" ]; then
	echo -n "$chosen" | xclip -selection clipboard
	notify-send "Emoji Copied!" "$chosen"
fi
