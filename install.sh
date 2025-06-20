#!/bin/bash

CWD="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

link() {
	local target=$1
	local linkname=$2

	if [ -L "$linkname" ] || [ -f "$linkname" ] || [ -d "$linkname" ]; then
		echo "Removing existing $linkname"
		rm -rf "$linkname"
	fi

	echo "Linking $linkname -> $target"
	ln -s "$target" "$linkname"
}

link "${CWD}/scripts" ~/scripts
link "${CWD}/tmux/config" ~/.tmux.conf
link "${CWD}/i3/config" ~/.config/i3/config
link "${CWD}/picom/config" ~/.config/picom.conf
link "${CWD}/zsh/config" ~/.zshrc
link "${CWD}/nvim" ~/.config/nvim
link "${CWD}/kitty" ~/.config/kitty
link "${CWD}/polybar" ~/.config/polybar
link "${CWD}/waybar" ~/.config/waybar
link "${CWD}/foot" ~/.config/foot
link "${CWD}/hypr" ~/.config/hypr
link "${CWD}/wofi" ~/.config/wofi
