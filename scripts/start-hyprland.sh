#!/bin/bash

# Set environment variables to mimic a proper Wayland session
export XDG_SESSION_TYPE=wayland
export XDG_CURRENT_DESKTOP=Hyprland
export GDK_BACKEND=wayland
export QT_QPA_PLATFORM=wayland
export XDG_SESSION_DESKTOP=hyprland

# Optional: Set icon and cursor theme to Ubuntu defaults (adjust if needed)
export XDG_CURRENT_DESKTOP=Hyprland
export GTK_THEME=Yaru
export XCURSOR_THEME=Yaru
export XCURSOR_SIZE=24

# Start Hyprland
exec Hyprland
