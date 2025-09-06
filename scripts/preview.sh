#!/bin/sh

# Arguments: $1=file, $2=width, $3=height, $4=xpos, $5=ypos
file="$1"

# Handle image previews using viu
case "$file" in
*.png | *.jpg | *.jpeg | *.gif | *.bmp | *.webp)
	viu -w "$2" -h "$3" "$file" || echo "[Image preview failed]"
	;;
*.pdf)
	pdftotext "$file" - | head -n "$3"
	;;
*.tar*) tar tf "$file" ;;
*.zip) unzip -l "$file" ;;
*.rar) unrar l "$file" ;;
*.7z) 7z l "$file" ;;
*)
	highlight -O ansi "$file" 2>/dev/null || cat "$file"
	;;
esac
