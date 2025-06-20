#!/bin/bash

if [[ $(file --mime-type -b "$1") == image/* ]]; then
	kitty +kitten icat --clear # clear previous image
	kitty +kitten icat --transfer-mode=file --place 0x0+0+0 "$1"
else
	cat "$1"
fi
